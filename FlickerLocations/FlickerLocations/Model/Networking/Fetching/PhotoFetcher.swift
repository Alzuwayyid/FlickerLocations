//
//  PhotoFetcher.swift
//  FlickerLocations
//
//  Created by Mohammed on 29/11/2020.
//

import Foundation
import UIKit

enum PhotoError: Error{
    case imageCreationError
    case missingImageURL
}


class fetcher{
    private let imageStore = ImageStore()

    
    func fetchFlickerPhotos(userLon: Double, userLat: Double, url: URL, completion: @escaping ([PhotoStruct]?, Error?) -> ()){
        //       let dispatchGroup = DispatchGroup()
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            
            let decoder = JSONDecoder()
            
            do{
                let photosFeed = try decoder.decode(PhotoResponse.self, from: data!)
                
                let tempResult = photosFeed.photos.photo
                
                
                DispatchQueue.main.async {
                    completion(tempResult, error)
                }
            }
            catch{
                print("Fetching Photo error:  \(error.localizedDescription)")
            }
        }.resume()
        
    }
    
    func fetchImage(for photo: PhotoStruct, completion: @escaping (Result<UIImage, Error>)->Void){
        let photoKey = photo.id
        
        if let image = imageStore.image(forKey: photoKey){
            OperationQueue.main.addOperation{
                completion(.success(image))
            }
            return
        }
        
        guard let photoURL = URL(string: photo.url_m) else{
            completion(.failure(PhotoError.missingImageURL))
            return
        }
        
        let request = URLRequest(url: photoURL)
        let task = session.dataTask(with: request){
            (data, response, error) in
            
            
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .success(image) = result{
                self.imageStore.setImage(image, forKey: photoKey)
            }
            OperationQueue.main.addOperation {
                completion(result)
            }
            
        }
        task.resume()
    }
    
    
    func fetchPhotosLocation(url: URL, completion: @escaping (Location?, Error?) -> ()){
        
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            let decoder = JSONDecoder()
            
            do{
                let locationFeed = try decoder.decode(LocationResponse.self, from: data!)
                
                let passedVar = locationFeed.photo.location
                DispatchQueue.main.async {
                    completion(passedVar , error)
                }
            }
            catch{
                print("Fetching Location error:  \(error.localizedDescription)")
            }
        }.resume()
    }
    
    private func processImageRequest(data: Data?, error: Error?)->Result<UIImage, Error> {
        guard let imageData = data, let image = UIImage(data: imageData) else{
            // Could not create the image
            if data == nil {
                return .failure(error!)
            }
            else{
                return .failure(PhotoError.imageCreationError)
            }
        }
        return .success(image)
    }
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
}

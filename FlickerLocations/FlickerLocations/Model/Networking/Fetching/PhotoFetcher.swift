//
//  PhotoFetcher.swift
//  FlickerLocations
//
//  Created by Mohammed on 29/11/2020.
//

import Foundation
import UIKit

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
    
}

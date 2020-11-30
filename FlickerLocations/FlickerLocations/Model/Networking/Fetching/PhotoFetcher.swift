//
//  PhotoFetcher.swift
//  FlickerLocations
//
//  Created by Mohammed on 29/11/2020.
//

import Foundation
import UIKit

class fetcher{
    
    
    func fetchFlickerPhotos(url: URL, completion: @escaping ([PhotoStruct]?, Error?) -> ()){
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
                print("Fetching error:  \(error.localizedDescription)")
            }
        }.resume()
        
    }
    
}

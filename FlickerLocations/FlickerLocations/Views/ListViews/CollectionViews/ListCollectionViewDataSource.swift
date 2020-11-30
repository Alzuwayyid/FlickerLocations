//
//  CollectionViewDataSource.swift
//  FlickerLocations
//
//  Created by Mohammed on 30/11/2020.
//

import UIKit
import Alamofire

class ListCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var photos = [PhotoStruct]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "PhotoListCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotosListCollectionViewCell
        
        let url = URL(string: photos[indexPath.row].url_m)
        
        AF.request(url!,method: .get).response{
            (response) in
            
            switch response.result{
                
                case .success(let photoData):
                    cell.photoImageView.image = UIImage(data: photoData!, scale: 1)
                case .failure(let error):
                    print("Error while fetching image from URL: \(error)")
            }
        }
        
        cell.distanceLabel.text = photos[indexPath.row].title
        
        return cell
    }
    
    



}

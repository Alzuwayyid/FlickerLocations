//
//  CollectionViewDataSource.swift
//  FlickerLocations
//
//  Created by Mohammed on 30/11/2020.
//

import UIKit
import Alamofire
import CoreLocation


class ListCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var photos = [PhotoStruct]()
    private let imageStore = ImageStore()
    var photoFetcher = fetcher()
    var latitude = 0.0
    var longitude = 0.0
    var address = [String]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "PhotoListCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotosListCollectionViewCell
        
        var url = URL(string: photos[indexPath.row].url_m)

        // Build URL based on photoID.
        url = getphotoLocationURL(photoId: Int(photos[indexPath.row].id)!)
        
        
        // Fetch photo location.
        photoFetcher.fetchPhotosLocation(url: url!) { (location, error) in
            let distanceBetweenTwoLoc = self.distance(lon: location!.longitude, lat: location!.latitude)
            DispatchQueue.main.async {
                self.address.append("\(location!.country.content), \(location!.region.content), \(location!.neighbourhood.content)\(location!.locality.content)")
                cell.distanceLabel.text = distanceBetweenTwoLoc
            }
            
        }

        // Display number of views
        cell.numOfViewsLabel.text = photos[indexPath.row].views

        cell.isUserInteractionEnabled = true
        
        // Animation with borderWidth
        let layer = cell.layer
        let animetion = CABasicAnimation(keyPath: #keyPath(CALayer.borderWidth))
        animetion.fromValue = NSNumber(50)
        animetion.toValue = -50
        animetion.duration = 0.90

        layer.add(animetion, forKey: "disappear")
        
        return cell
    }
    
    // If the distance is less than a Kilo, pass the meters
    func distance(lon: String, lat: String)->String{
        let currentLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let photoLocation = CLLocation(latitude: Double(lat)!, longitude: Double(lon)!)
        var distance = 0.0
        
        let distanceInMeters = String(currentLocation.distance(from: photoLocation))
        
        if Double(distanceInMeters)! > 1000{
            let distance = round(Double(distanceInMeters)! * 1000) / 1000000
            return "\(String(format: "%.2f", distance)) KM"
        }
        //       Alaa Location: 51.30384644267682
        distance = Double(distanceInMeters)!
        return "\(String(format: "%.3f", distance)) Meter"
    }
    
    func removeAllAddresses(){
        self.address.removeAll()
    }
    
    
}

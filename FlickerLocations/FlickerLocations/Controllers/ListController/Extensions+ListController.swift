//
//  Extensions+ListController.swift
//  FlickerLocations
//
//  Created by Mohammed on 04/12/2020.
//

import UIKit
import MapKit
import CoreLocation

extension ListViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locationss = \(locValue.latitude) \(locValue.longitude)")
        
        // Set the two locValue varibles to the current lon and lat of the user
            DispatchQueue.main.async {
                self.latitude = locValue.latitude
                self.longitude = locValue.longitude
            }

        print("longe: \(longitude) late: \(latitude)")
        
        // Update the map and set the label below it to the user city
        let geoCoder = CLGeocoder()
        let currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        // Submit current location to geocoding server and update label with the result
        if viewCounter == 0{
            geoCoder.reverseGeocodeLocation(currentLocation) { (placemarks, _) in
                placemarks?.forEach { (placemark) in
                    
                    if let city = placemark.locality {
                        DispatchQueue.main.async { [self] in
                                self.addressLabel.text = "  \(city)"
                                self.addressLabel.reloadInputViews()
                        }
                    }
                }
            }
        }

        
        // If the view was loaded for the first time, update the Data Source
        if viewCounter == 0 && longitude != 0.0{
            let url = getFlickerURL(accuracy:16, longitude: latitude, latitude: longitude, radius: 9, totalPagesAmount: 100, photosPerPage: 100)
            photoFetcher.fetchFlickerPhotos(userLon: longitude, userLat: latitude, url: url) { (array, error) in
                
                print(array!)
                self.collectionViewDataSource.latitude = self.latitude
                self.collectionViewDataSource.longitude = self.longitude
                self.collectionViewDataSource.photos = array!
                self.collectionViewDelegate.photos = array!
                self.collectionView.reloadSections(IndexSet(integer: 0))
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            
            // Update the map to display current location in the map
            let center = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
            // Add pin to the current location
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
            self.mapView.addAnnotation(annotation)
            viewCounter += 1
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    // If authorization was given by the user, request his/her location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
}

extension ListViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            // Updating imageView, title, taken date and description in the detailesViewController
            case "showPhotoDetail":
                if let selectedIndexPath = collectionView.indexPathsForSelectedItems!.first{
                    let photoURL = collectionViewDataSource.photos[selectedIndexPath.row].url_m
                    let photoTitle = collectionViewDataSource.photos[selectedIndexPath.row].title
                    let address = collectionViewDataSource.address[selectedIndexPath.row]
                    let takenDate = collectionViewDataSource.photos[selectedIndexPath.row].datetaken
                    let ownerName = collectionViewDataSource.photos[selectedIndexPath.row].ownername
                    let photoDescription = collectionViewDataSource.photos[selectedIndexPath.row].photoDescription
                    
                    let decVC = segue.destination as! DetailsViewController
                    decVC.ownerName = ownerName
                    decVC.takenDate = takenDate
                    decVC.address = address
                    decVC.imageURL = photoURL
                    decVC.titleText = photoTitle
                    decVC.Photodescription = photoDescription.content
                }
            // Set the longitude and latitude in the locationController to be the user's location
            case "changeLocation":
                let decVC = segue.destination as! LocationViewController
                // set this controller to be delegate in order to update the collectionView with the new location
                decVC.delegate = self
                decVC.latitude = self.latitude
                decVC.longitude = self.longitude
                
            default:
                print("Could not prefrom segue")
        }
    }
}

// Update the collectionView and address label based on the new chosen location
extension ListViewController: passBackLonLat{
    func passLonLat(lon: Double, lat: Double, country: String) {
        self.latitude = lat
        self.longitude = lon
        self.addressLabel.text = country
        viewCounter -= 1
        collectionViewDataSource.removeAllAddresses()
        
        DispatchQueue.main.async { [self] in
            self.activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
        
    }
}

//
//  MainViewController.swift
//  FlickerLocations
//
//  Created by Mohammed on 29/11/2020.
//

import UIKit
import MapKit
import CoreLocation

class ListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var addressLabel: UILabel!
    
    // MARK: - Data Sources and Delegates
    let mapViewDelegate = ListMapViewDelegate()
    let collectionViewDataSource = ListCollectionViewDataSource()
    let collectionViewDelegate = ListCollectionViewDelegate()
    
    // MARK: - Properties
    var photoFetcher = fetcher()
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    var viewCounter = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Delegating
        mapView.delegate = mapViewDelegate
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
        locationManager.delegate = self
        
        
        // MARK: - Request and Update Location
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
        
        // Modify views layers
        modifyViewLayer()
        
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
            default:
                print("Could not prefrom segue")
        }
    }
}





extension ListViewController: CLLocationManagerDelegate{
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locationss = \(locValue.latitude) \(locValue.longitude)")
        
        // Set the two varibles to the current lon and lat of the user
        DispatchQueue.main.async {
            self.latitude = locValue.latitude
            self.longitude = locValue.longitude
        }

        print("longe: \(longitude) late: \(latitude)")
        
        // Update the map and set the label below it to the user city
        let geoCoder = CLGeocoder()
        let currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(currentLocation) { (placemarks, _) in
            placemarks?.forEach { (placemark) in

                if let city = placemark.locality {
                    DispatchQueue.main.async {
                        self.addressLabel.text = "  \(city)"
                        self.addressLabel.reloadInputViews()
                    }
                }
            }
        }
        
        // If the view is loaded for the first time then update the Collection Data Source
        if viewCounter == 0 && longitude != 0.0{
            let url = getFlickerURL(accuracy:16, longitude: latitude, latitude: longitude, radius: 9, totalPagesAmount: 100, photosPerPage: 100)
            photoFetcher.fetchFlickerPhotos(userLon: longitude, userLat: latitude, url: url) { (array, error) in
                
                print(array!)
                self.collectionViewDataSource.latitude = self.latitude
                self.collectionViewDataSource.longitude = self.longitude
                self.collectionViewDataSource.photos = array!
                self.collectionViewDelegate.photos = array!
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
            viewCounter += 1
        }
        
        // Add pin to the map for the current location of the user
        let region = MKCoordinateRegion(center: locValue, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        self.mapView.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    
    func modifyViewLayer(){
        addressLabel.layer.cornerRadius = 10
        addressLabel.layer.masksToBounds = true
        addressLabel.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        mapView.layer.cornerRadius = 15
        mapView.layer.maskedCorners = [ .layerMinXMinYCorner, .layerMaxXMinYCorner]
        mapView.layer.masksToBounds = true
    }
    
}

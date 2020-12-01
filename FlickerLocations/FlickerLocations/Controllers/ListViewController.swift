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
        
        mapView.delegate = mapViewDelegate
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
        locationManager.delegate = self
        
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()

        print("longe: \(longitude) late: \(latitude)")
        let url = getphotoLocationURL(photoId: 50666290098)
        
        print("The location URL: \(url)")
        photoFetcher.fetchPhotosLocation(url: url) { (location, error) in
            
            
            print("Fetched lon: \(location!.longitude) lat: \(location!.latitude)")
        }
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    



}

extension ListViewController: CLLocationManagerDelegate{
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locationss = \(locValue.latitude) \(locValue.longitude)")
        
        DispatchQueue.main.async {
            self.latitude = locValue.latitude
            self.longitude = locValue.longitude
        }

        print("longe: \(longitude) late: \(latitude)")
        
        if viewCounter == 0 && longitude != 0.0{
            let url = getFlickerURL(accuracy:16, longitude: latitude, latitude: longitude, radius: 9, totalPagesAmount: 100, photosPerPage: 100)

            photoFetcher.fetchFlickerPhotos(url: url) { (array, error) in
                
                print(array!)
                self.collectionViewDataSource.photos = array!
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
            viewCounter += 1
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    
    
    
}

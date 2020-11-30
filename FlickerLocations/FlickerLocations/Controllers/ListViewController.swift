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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = mapViewDelegate
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
        
        locationManager.delegate = self
        

        
        _ = URLSession.shared.dataTask(with: getFlickerURL(longitude: 46.675297, latitude: 24.713552, radius: 20, totalPagesAmount: 17, photosPerPage: 15)){
            (data,response,error)
            in
            print(data!)
            print(response!)
            print(error!)
            
        }
        
        
        let url = getFlickerURL(longitude: 24.755562, latitude: 46.589584, radius: 20, totalPagesAmount: 20, photosPerPage: 20)
        print("url:  \(url)")
        
        photoFetcher.fetchFlickerPhotos(url: url) { (array, error) in
            print("arararararr: \(array)")
            print("error:  \(error)")
            
            self.collectionViewDataSource.photos = array!
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }
    



}

extension ListViewController: CLLocationManagerDelegate{
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locationss = \(locValue.latitude) \(locValue.longitude)")
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

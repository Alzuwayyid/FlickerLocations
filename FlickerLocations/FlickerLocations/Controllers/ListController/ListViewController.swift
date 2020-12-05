//
//  MainViewController.swift
//  FlickerLocations
//
//  Created by Mohammed on 29/11/2020.
//

import UIKit
import MapKit
import CoreLocation

class ListViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    // MARK: - Outlets
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var changeLocationButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Data Sources and Delegates
    let mapViewDelegate = ListMapViewDelegate()
    let collectionViewDataSource = ListCollectionViewDataSource()
    let collectionViewDelegate = ListCollectionViewDelegate()
    
    // MARK: - Properties
    var photoFetcher = fetcher()
    var styleViews = modifyLayersFunctions()
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    var viewCounter = 0.0
    var locationChangedByUser = false
    
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
        styleViews.modifyViewLayer(button: &addressLabel, button2: &changeLocationButton, mapView: &mapView)
        
        mapView.isScrollEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
    }
    
    
    
}



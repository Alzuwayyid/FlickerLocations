//
//  LocationViewController.swift
//  FlickerLocations
//
//  Created by Mohammed on 03/12/2020.
//

import UIKit
import CoreLocation
import MapKit


protocol passBackLonLat{
    func passLonLat(lon: Double, lat: Double, country: String)
}

class LocationViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var dismissController: UIButton!
    @IBOutlet var chooseAndDismiss: UIButton!
    @IBOutlet var mapView: MKMapView!
    
    
    // MARK: - Properties
    var latitude = 0.0
    var longitude = 0.0
    var locationName = ""
    var locationCountry = ""
    var delegate: passBackLonLat!
    var mapViewDelegate = ListMapViewDelegate()
    var styleViews = modifyLayersFunctions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Modify views layers
        styleViews.modifyViewLayer(button: &dismissController)
        
        // Set mapViewDelegate as the controller delegate
        mapView.delegate = mapViewDelegate
        
        // Set the location to the current one in the mapView
        mapView.setRegion(mapViewDelegate.setRegionToCurrent(lon: self.longitude, lat: self.latitude), animated: true)
        mapView.addAnnotation(mapViewDelegate.setPointAnnotationToCurrent(lon: self.longitude, lat: self.latitude))
    }
    
    
    // When user press in the 'X' button
    @IBAction func dismissTheView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // When user long press on the map it will convert specified view’s coordinate system to a map coordinate.
    @IBAction func longPressOnMap(_ sender: UILongPressGestureRecognizer) {
        let locationCoordinate = mapView.convert(sender.location(in: mapView), toCoordinateFrom: mapView)
       saveGeoCoordination(from: locationCoordinate)
    }
    
    
    func saveGeoCoordination(from coordinate: CLLocationCoordinate2D) {
        let geoPos = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let annotation = MKPointAnnotation()
        CLGeocoder().reverseGeocodeLocation(geoPos) { (placemarks, error) in
            guard let placemark = placemarks?.first else { return }
            annotation.title = placemark.name ?? "Not Known"
            annotation.subtitle = placemark.country
            annotation.coordinate = coordinate
            self.copyLocation(annotation)
        }
    }
    
    
    func copyLocation(_ annotation: MKPointAnnotation) {
        longitude = annotation.coordinate.longitude
        latitude = annotation.coordinate.latitude
        locationName = annotation.title!
        locationCountry = annotation.subtitle!
        let CLLCoordType = CLLocationCoordinate2D(latitude: latitude,
                                                  longitude: longitude)
        let annotationPin = MKPointAnnotation()
        annotationPin.coordinate = CLLCoordType
        self.mapView.addAnnotation(annotationPin)
    }
    
    
    @IBAction func checkMarkAndDismiss(_ sender: UIButton) {
        delegate.passLonLat(lon: longitude, lat: latitude, country: locationName)
        self.dismiss(animated: true, completion: nil)
    }
    
    

    
}

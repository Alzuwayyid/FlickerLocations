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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Modify views layers
        modifyViewLayer()
        
        
        // Set the location to the current one in the mapView
        setLocationToCurrent()
        
    }

    @IBAction func dismissTheView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
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
        print("Name: \(locationName) country: \(locationCountry) long: \(longitude) lat: \(latitude)")
        
    }
    @IBAction func checkMarkAndDismiss(_ sender: UIButton) {
        delegate.passLonLat(lon: longitude, lat: latitude, country: locationName)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func modifyViewLayer(){
        dismissController.frame = CGRect(x: 355, y: 740, width: 100, height: 100)
        dismissController.backgroundColor = UIColor(named: "MapGrayColor")
        dismissController.layer.cornerRadius = 0.5 * dismissController.bounds.size.width
    }
    
    func setLocationToCurrent(){
        let locValue = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: locValue, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        self.mapView.addAnnotation(annotation)
    }
}

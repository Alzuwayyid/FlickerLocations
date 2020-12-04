//
//  ListMapViewDataSource.swift
//  FlickerLocations
//
//  Created by Mohammed on 30/11/2020.
//

import UIKit
import MapKit
import CoreLocation

class ListMapViewDelegate: NSObject, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    var locationName = ""
    var locationCountry = ""
    let mapView = MKMapView()
    
    
    func setRegionToCurrent(lon: Double, lat: Double)->MKCoordinateRegion{
        let locValue = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(center: locValue, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        return region
    }
    
    func setPointAnnotationToCurrent(lon: Double, lat: Double)->MKPointAnnotation{
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        return annotation
    }
    
}





//
//  stylingFunctions.swift
//  FlickerLocations
//
//  Created by Mohammed on 04/12/2020.
//

import Foundation
import UIKit
import MapKit

class modifyLayersFunctions{
    
    func modifyViewLayer(button: inout UIButton){
        button.frame = CGRect(x: 355, y: 740, width: 100, height: 100)
        button.backgroundColor = UIColor(named: "MapGrayColor")
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
    }
    
    func modifyViewLayer(button: inout UILabel, button2: inout UIButton, mapView: inout MKMapView){
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        mapView.layer.cornerRadius = 15
        mapView.layer.maskedCorners = [ .layerMinXMinYCorner, .layerMaxXMinYCorner]
        mapView.layer.masksToBounds = true
        
        button2.frame = CGRect(x: 355, y: 740, width: 50, height: 50)
        button2.backgroundColor = UIColor(named: "MapGrayColor")
        button2.layer.cornerRadius = 0.5 * button2.bounds.size.width
        
    }
}

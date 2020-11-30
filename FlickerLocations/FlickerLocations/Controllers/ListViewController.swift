//
//  MainViewController.swift
//  FlickerLocations
//
//  Created by Mohammed on 29/11/2020.
//

import UIKit
import MapKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = mapViewDelegate
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
        
        
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
    



}

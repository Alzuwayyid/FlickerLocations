//
//  MainViewController.swift
//  FlickerLocations
//
//  Created by Mohammed on 29/11/2020.
//

import UIKit

class ListViewController: UIViewController {

    var photoFetcher = fetcher()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        }
    }
    



}

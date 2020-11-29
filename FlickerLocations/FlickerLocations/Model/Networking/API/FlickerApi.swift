//
//  FlickerApi.swift
//  FlickerLocations
//
//  Created by Mohammed on 29/11/2020.
//

import Foundation
import UIKit

struct FlickerAPI{
    static let baseURLString = "shttps://api.flickr.com/services/rest"
    static let apiKey = "a6d819499131071f158fd740860a5a88"
}


enum EndPoint{
    
    //This method requires authentication with 'write' permission.
    static let batchCorrectLocation = "flickr.photos.geo.batchCorrectLocation"
    //This method does not require authentication.
    static let getLocation = "flickr.photos.geo.getLocation"
    //This method requires authentication with 'read' permission.
    static let flickrPhotosSearch = "https://www.flickr.com/services/rest/?method=flickr.photos.search"
    
    static let radius = 20
    
    case searchURLString(Double,Double,Double,Int,Int)
    
    var urlString: String{
        switch self{
            case .searchURLString(let latitude, let longitude, let radius, let perPage, let pageNum):
                return EndPoint.flickrPhotosSearch + "&api_key=\(FlickerAPI.apiKey)" + "&lat=\(latitude)" + "&lon=\(longitude)" + "&radius=\(radius)" + "&per_page=\(perPage)" + "&page=\(pageNum)" + "&format=json&nojsoncallback=1&extras=url_m"
        }
    }
    
    var url: URL {
        return URL(string: urlString)!
    }
    
    
}

func getFlickerURL(longitude: Double, latitude: Double, radius: Double = 20, totalPagesAmount: Int = 17, photosPerPage: Int = 17)->URL{
    let searchURL = EndPoint.searchURLString(longitude, latitude, radius, totalPagesAmount, photosPerPage).url
    return searchURL
}


//
//  Photo.swift
//  FlickerLocations
//
//  Created by Mohammed on 29/11/2020.
//

import Foundation
import UIKit

//class PhotoData: Codable{
//    let title: String
//    var photoImage: UIImage?
//    let remoteURL: URL?
//    let photoId: String
//    let dateCreated: Date
//    let latitude: Double
//    let longitude: Double
//    let totalPageAmount: Int
//    let photoPerPage: Int
//    let radius: Double
//    let url_m: String
//    
//    enum CodingKeys: String, CodingKeys{
//        case title, radius
//        case photoId = "id"
//        case dateCreated = "datetaken"
//        case remoteURL = "url_z"
//        case latitude = "lat"
//        case longitude = "lon"
//        case url_m = "url_m"
//
//    }
//    
//    
//}







// MARK: - Photo
struct PhotoStruct: Codable {
//    var photoImage: UIImage?
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let url_m: String

    
    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily//, height_m, width_m
        case url_m = "url_m"
    }
}

/// The response data returned from the flickr API.
struct PhotoResponse: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage: Int
    let total: String
    let photo: [PhotoStruct]
}








//struct Location: Codable {
//    let latitude: Double
//    let longitude: Double
//    let location: String
//    let country: String
//
//    enum CodingKeys: String, CodingKey {
//        case location, country, latitude, longitude
//    }
//}
//

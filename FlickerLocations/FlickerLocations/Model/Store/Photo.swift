//
//  Photo.swift
//  FlickerLocations
//
//  Created by Mohammed on 29/11/2020.
//

import Foundation
import UIKit

// MARK: - Photo
struct PhotoStruct: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let url_m: String
    
    let datetaken: String
    let photoDescription: Description
    let ownername: String
    let views: String
    
    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily, datetaken,ownername, views // datetakengranularity, datetakenunknown,
        case url_m = "url_m"
        case photoDescription = "description"
    }
}

struct Description: Codable {
    let content: String

    enum CodingKeys: String, CodingKey {
        case content = "_content"
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


// MARK: - Location
struct LocationResponse: Codable {
    let photo: Photo
    let stat: String
}

struct Photo: Codable {
    let id: String
    let location: Location
}

struct Location: Codable {
    let latitude, longitude: String
    let accuracy, context: String
    let locality, neighbourhood, region, country: Country

}

struct Country: Codable {
    let content: String

    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}

extension PhotoStruct: Equatable{
    static func == (lhs: PhotoStruct, rhs: PhotoStruct) -> Bool {
        return lhs.farm == rhs.farm && lhs.id == rhs.id && lhs.isfamily == rhs.isfamily && lhs.isfriend == rhs.isfriend && lhs.ispublic == rhs.ispublic && lhs.owner == rhs.owner && lhs.secret == rhs.secret && lhs.server == rhs.server && lhs.title == rhs.title && lhs.url_m == rhs.url_m
        
    }
}

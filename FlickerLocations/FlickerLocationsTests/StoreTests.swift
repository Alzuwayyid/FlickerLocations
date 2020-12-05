
//
//  StoreTests.swift
//  FlickerLocationsTests
//
//  Created by Mohammed on 05/12/2020.
//

import Foundation
import XCTest
@testable import FlickerLocations

class FlickerStoreTest: XCTestCase{
    var imageStore = ImageStore()
    
    // Test if imageURL() method do load a URL of an image from the disk
    func testfetchImageURLFromDisk(){
        let fetchImageURL = imageStore.imageURL(forKey: "50666290098")
        XCTAssertNotNil(fetchImageURL)
    }
    
    // Test if image() does return an image form the disk
    func testFetchingImageFromTheDisk(){
        let fetchImage = imageStore.image(forKey: "50666290098")
        XCTAssertNotNil(fetchImage)
    }
}


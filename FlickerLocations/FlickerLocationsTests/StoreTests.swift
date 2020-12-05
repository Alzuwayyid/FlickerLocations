
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
    
    
    func testfetchImageURLFromDisk(){
        let fetchImageURL = imageStore.imageURL(forKey: "50666290098")
        XCTAssertNotNil(fetchImageURL)
    }
    
    func testFetchingImageFromTheDisk(){
        let fetchImage = imageStore.image(forKey: "50666290098")
        XCTAssertNotNil(fetchImage)
    }
}

//"file:///Users/mohammed/Library/Developer/CoreSimulator/Devices/6CA0065C-E220-488F-BADE-8E8526B179BA/data/Containers/Data/Application/BCBAB2CC-A83D-47F5-93C9-A7DD62B4562A/Documents/50666290098"

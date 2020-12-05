//
//  APITests.swift
//  FlickerLocationsTests
//
//  Created by Mohammed on 05/12/2020.
//

import XCTest
@testable import FlickerLocations

class FlickerApiTest: XCTestCase{
    var photoFetcher = fetcher()
    var constants = Constants()
    var customError = CustomError(title: nil, description: "NA", code: 404)
    
    override func setUp(){
        super.setUp()
        // Do stuff
    }
    
    override func tearDown() {
        // Do stuff
        super.tearDown()
    }
    
    func testProccessingImage(){
 
        let data = Data()
        
        let photo = photoFetcher.processImageRequest(data: data, error: customError)
        XCTAssertNotNil(photo)
        XCTAssertEqual(OperationQueue.current, OperationQueue.main)
    }
    
    func testLocationOfImage(){
        
        let completionExpectation = expectation(description: "Execute completion closure.")
        
        let _: () = photoFetcher.fetchPhotosLocation(url: (getphotoLocationURL(photoId: 50666290098))) { (location, error) in
            XCTAssertEqual(location?.country.content, "Saudi Arabia")
            XCTAssertEqual(OperationQueue.current,
                           OperationQueue.main,
                           "Completion handler should run on the main thread; it did not.")
            completionExpectation.fulfill()

        }
        waitForExpectations(timeout: 1.0, handler: nil)

    }
    
}

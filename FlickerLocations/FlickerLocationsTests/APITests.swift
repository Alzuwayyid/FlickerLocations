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
    
    
    func testPhotosHTTPResponse() {
        let url = getFlickerURL(accuracy:16, longitude: 46.712912, latitude: 24.853905, radius: 9, totalPagesAmount: 100, photosPerPage: 100)

      let promise = expectation(description: "Status code: 200")

      let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in

        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {

            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)
    }
    
}

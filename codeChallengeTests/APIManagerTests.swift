//
//  APIManagerTests.swift
//  codeChallengeTests
//
//  Created by Ayman  on 12.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import XCTest
@testable import codeChallenge

class APIManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testgetFlickrPhotosAPI () {
        let expectation = XCTestExpectation(description: "Get list of photos")
        APIManager.sharedInstance.getFlickrPhotosWith(pageNumber: 1, dateSort: .posted, completionWithSuccess: { response in
            XCTAssertNotNil(response, "Expect photosReponse not nil")
            XCTAssertNotNil(response.photos, "Expect photos not nil")
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
        }, completionWithFail: { error in
            
        })
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

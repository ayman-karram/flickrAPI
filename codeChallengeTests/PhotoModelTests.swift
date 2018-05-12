//
//  PhotoModelTests.swift
//  codeChallengeTests
//
//  Created by Ayman  on 12.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import XCTest
@testable import codeChallenge

class PhotoModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTheInitiationOfPhotoModelWithGivenValues () {
        
        let photoObject : PhotoModel?
        let title = "Manzo firoi zucchine pesto aglio olio e uovo marinato"
        let description = "aglio olio e uovo marinato"
        let photosArray : NSArray = [[
            "title": title,
            "description": [
                "_content": description
            ],
            "datetaken": "2018-05-06 11:14:11",
            "datetakengranularity": "0",
            "datetakenunknown": "0"
            ]]
        photoObject = PhotoWrapper.wrapeJSONDataToPhotoModel(dict: photosArray.firstObject as! [String : AnyObject])
        XCTAssertNotNil(photoObject, "Expect photosReponse not nil")
        XCTAssertTrue(photoObject?.title == title)
        XCTAssertTrue(photoObject?.descriptionText == description)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

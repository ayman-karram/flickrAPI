//
//  PhotosResponseModelTests.swift
//  codeChallenge
//
//  Created by Ayman  on 12.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import XCTest
@testable import codeChallenge

class PhotosResponseModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTheInitiationOfPhotosResponseModelWithGivenValues () {
        
        let photosReponse : PhotosResponseModel?
        let dictionary = [
            "photos": [
            "page": 1,
            "pages": 41737,
            "perpage": 15,
            "total": "626054"]] as [String : AnyObject]
        photosReponse = PhotosResponseModelWrapper.wrapeJSONDataToPhotosResponseModel(dict: dictionary )
        XCTAssertNotNil(photosReponse, "Expect photosReponse not nil")
        XCTAssertTrue(photosReponse?.pages == 41737)
        XCTAssertTrue(photosReponse?.perpage == 15)
    }
    
    func testTheInitiationOfPhotosArrayInPhotosResponseModel () {
        
        let photosReponse : PhotosResponseModel?
        let photosArray : NSArray = [[
            
            "id": "41031711415",
            "owner": "141007500@N05",
            "secret": "d4cac5008e",
            "server": "959",
            "farm": 1,
            "title": "Manzo firoi zucchine pesto aglio olio e uovo marinato",
            "ispublic": 1,
            "isfriend": 0,
            "isfamily": 0,
            "description": [
                "_content": ""
            ],
            "datetaken": "2018-05-06 11:14:11",
            "datetakengranularity": "0",
            "datetakenunknown": "0"
            ]]
        let dictionary = [
            "photos": [
                "page": 1,
                "pages": 41737,
                "perpage": 15,
                "total": "626054" ,"photo": photosArray]] as [String : AnyObject]
        photosReponse = PhotosResponseModelWrapper.wrapeJSONDataToPhotosResponseModel(dict: dictionary )
        XCTAssertNotNil(photosReponse, "Expect photosReponse not nil")
        XCTAssertNotNil(photosReponse?.photos, "Expect photos not nil")

        XCTAssertTrue(photosReponse?.photos.count == 1)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

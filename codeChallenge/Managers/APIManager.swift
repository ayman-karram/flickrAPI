//
//  APIManager.swift
//  codeChallenge
//
//  Created by Ayman  on 06.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import Foundation
import UIKit


@objc class APIManager : NSObject {
    
    @objc static let sharedInstance = APIManager()
    
    private static let APIKey = "2ed35a9f4fda03bc96e73dbd03602780"
    
    struct URLS {
        static let mainURL = "https://api.flickr.com"
        static let photoSearch = mainURL + "/services/rest/"
    }
    
    @objc func getFlickrPhotosWith (pageNumber : Int, completionWithSuccess:  @escaping (PhotosResponseModel) -> Void , completionWithFail : @escaping (Error) -> Void) {
     
        let url = URLS.photoSearch
        let perPage = "15"
        
        let paramters = ["method":"flickr.photos.search" , "api_key" : APIManager.APIKey,"tags" : "cooking","per_page" : perPage, "page" : "\(pageNumber)", "format" : "json", "nojsoncallback" : "1", "extras" : "date_taken,description,tags,url_t"]
        
        RequestsManager.sharedInstance.request(method: .get,
                                               urlString: url,
                                               paramters: paramters,
                                               paramtersEncoding: .inURLQuary,
                                               completionHandler: {  response in
                                                
                                                switch response {
                                                case .success(let value):
                                                    if let JsonValue = value as? [String : AnyObject] {
                                                        let photos = PhotosResponseModelWrapper.wrapeJSONDataToPhotosResponseModel(dict: JsonValue)
                                                        completionWithSuccess(photos)
                                                    }
                                                    else
                                                    {
                                                        completionWithSuccess(PhotosResponseModel())
                                                    }
                                                case .failure(let error):
                                                    completionWithFail(error)
                                                }
        })
    }
}




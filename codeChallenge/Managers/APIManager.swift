//
//  APIManager.swift
//  codeChallenge
//
//  Created by Ayman  on 06.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import Foundation

@objc class APIManager : NSObject {
    
    @objc static let sharedInstance = APIManager()
    private static let APIKey = ""
    
    struct URLS {
        static let mainURL = "https://api.flickr.com/services"
        static let photoSearch = mainURL + "services/rest/"
    }
    
    @objc func getFlickrPhotos (completionWithSuccess:  @escaping ([FoodModel]) -> Void , completionWithFail : @escaping (Error) -> Void) {
       
        let url = URLS.photoSearch 
        let paramters = ["method=":"flickr.photos.search" , "api_key" : APIManager.APIKey,"tags" : "cooking", "format" : "json", "nojsoncallback" : "1", "extras" : "date_taken,description,tags"]
        
        RequestsManager.sharedInstance.request(method: .get,
                                               urlString: url,
                                               paramters: paramters,
                                               paramtersEncoding: .inURLQuary,
                                               reposponseModel: FoodModel.self,
                                               completionHandler: {  response in
                                                
                                                switch response {
                                                case .success(let value):
                                                    completionWithSuccess(value as! [FoodModel])
                                                case .failure(let error):
                                                    completionWithFail(error)
                                                }
        })
    }
    
}


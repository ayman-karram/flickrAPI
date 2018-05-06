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
    
    @objc func getFlickrPhotos (success:  @escaping ([FoodModel]) -> Void , fail : @escaping (Error) -> Void) {
        
        let url = URL (string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=2ed35a9f4fda03bc96e73dbd03602780&tags=cooking&per_page=15&format=json&nojsoncallback=1&extras=date_taken,description,tags")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        _ = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    fail(error)
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()
                    do {
                        let posts = try decoder.decode([FoodModel].self, from: jsonData)
                        success(posts)
                    } catch {
                        fail(error)
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    fail(error)
                }
            }
        }
    }
}


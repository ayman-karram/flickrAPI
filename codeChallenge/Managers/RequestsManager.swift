//
//  RequestsManager.swift
//  codeChallenge
//
//  Created by Ayman Karram on 07.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
}

public enum EncodingParameters {
    case inURLQuary
    
}

public enum Response<T> {
    case success(T)
    case failure(Error)
}

class RequestsManager {
    
    static let sharedInstance = RequestsManager()
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    func request<T : Codable> (method : HTTPMethod, urlString : String,
                               paramters : [String : Any]?,
                               paramtersEncoding :EncodingParameters = .inURLQuary,
                               reposponseModel :T.Type,
                               completionHandler : @escaping (Response<Any>) -> Void) {
        
        let url : URL = self.prepareURLRequest(urlString: urlString, paramters: paramters, paramtersEncoding: paramtersEncoding)!

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        _ = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completionHandler(Response.failure(error))
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()
                    do {
                        let food = try decoder.decode(reposponseModel.self, from: jsonData)
                        completionHandler(Response.success(food))
                    } catch {
                        completionHandler(Response.failure(error))
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completionHandler(Response.failure(error))
                }
            }
        }
        
    }
    
    
    private func prepareURLRequest(urlString : String, paramters : [String : Any]?,
                                    paramtersEncoding :EncodingParameters = .inURLQuary) -> URL? {
        guard let paramters = paramters else {
            return URL(string: urlString)
        }
        
        switch paramtersEncoding {
        case .inURLQuary:
            let url = self.createURL(url: urlString, WithComponents: paramters)
            return url
        }
        
    }
    
    private func createURL(url : String, WithComponents paramters : [String : Any]) -> URL? {
        let urlComponents = NSURLComponents()
        urlComponents.path = url
        // add params
        for key in paramters.keys {
            let dateQuery = URLQueryItem(name: key, value: paramters[key] as? String)
            urlComponents.queryItems?.append(dateQuery)
        }
        return urlComponents.url
    }
    
}

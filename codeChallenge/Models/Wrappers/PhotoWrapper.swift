//
//  PhotoWrapper.swift
//  codeChallenge
//
//  Created by Ayman  on 09.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import Foundation

class PhotoWrapper {
    
    class func wrapeJSONDataToPhotoModel (dict: [String: AnyObject]) -> PhotoModel {
        
        let photosModel = PhotoModel()
        
        if let title = dict["title"] as? String {
            photosModel.title = title
        }
        if let url = dict["url_t"] as? String {
            photosModel.url = url
        }
        if let url = dict["url_n"] as? String {
            photosModel.url_n = url
        }
        if let descriptionObject =  dict["description"] as? NSDictionary  {
            if let descriptionText = descriptionObject["_content"] as? String {
                photosModel.descriptionText = descriptionText
                photosModel.descriptionRenderedText = descriptionText.htmlAttributedString()
            }
        }
        
        return photosModel
    }
}

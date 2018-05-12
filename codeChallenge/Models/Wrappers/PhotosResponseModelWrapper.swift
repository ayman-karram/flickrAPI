//
//  PhotosResponseModelWrapper.swift
//  codeChallenge
//
//  Created by Ayman  on 09.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import Foundation

/**
 Wrape JSON response data to PhotosResponseModel
 
 - parameter dict JSON data dictionary
 
 - returns: PhotosResponseModel
 
 */
class PhotosResponseModelWrapper {
    class func wrapeJSONDataToPhotosResponseModel (dict: [String: AnyObject]) -> PhotosResponseModel {
        
        let photosResponseModel = PhotosResponseModel()
        
        guard let photosReponse = dict ["photos"] as? NSDictionary else
        {
            return photosResponseModel
        }
        if let page = photosReponse["page"] as? Int {
            photosResponseModel.page = page
        }
        if let pages = photosReponse["pages"] as? Int {
            photosResponseModel.pages = pages
        }
        if let perpage = photosReponse["perpage"] as? Int {
            photosResponseModel.perpage = perpage
        }
        if let total = photosReponse["total"] as? Int {
            photosResponseModel.total = total
        }
        
        if let photosArray = photosReponse["photo"] as? NSArray {
            for phtotObject in photosArray {
                let photoModel  = PhotoWrapper.wrapeJSONDataToPhotoModel(dict: phtotObject as! [String : AnyObject])
                photosResponseModel.photos.append(photoModel)
            }
        }
        
        return photosResponseModel
    }
}

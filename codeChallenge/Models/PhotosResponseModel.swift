//
//  PhotosResponseModel.swift
//  codeChallenge
//
//  Created by Ayman  on 09.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import Foundation

@objc class PhotosResponseModel : NSObject {
    
    @objc var page:Int = 0
    @objc var pages:Int = 0
    @objc var perpage:Int = 0
    @objc var total: Int = 0
    @objc var photos : [PhotoModel] = []

    
}

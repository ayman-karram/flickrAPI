//
//  PPhotoModel.swift
//  codeChallenge
//
//  Created by Ayman  on 06.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import Foundation

@objc class PhotoModel: NSObject {

    @objc var title : String = ""
    @objc var descriptionText : String = ""
    @objc var descriptionRenderedText : NSAttributedString?
    @objc var url : String = ""
    @objc var url_n : String = ""

}

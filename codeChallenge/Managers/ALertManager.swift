//
//  ALertManager.swift
//  codeChallenge
//
//  Created by Ayman  on 12.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import Foundation
import UIKit

@objc class ALertManager: NSObject {
   @objc class func somethingWentWrongAlert () -> UIAlertController {
        let alert = UIAlertController(title: "Sorry!", message: "something went wrong.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "", style: .cancel, handler: { handler in
            alert.dismiss(animated: true, completion: nil)
        }))
        return alert
    }
}

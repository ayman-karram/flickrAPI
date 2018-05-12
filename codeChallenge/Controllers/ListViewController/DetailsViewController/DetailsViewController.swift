//
//  DetailsViewController.swift
//  codeChallenge
//
//  Created by Ayman  on 12.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import Foundation
import UIKit

@objc class DetailsViewController: UIViewController {
    
    //MARK : - Variables
    @IBOutlet weak var detailsScrollView: UIScrollView!
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @objc var photoModel : PhotoModel?

    //MARK : - View life cycle
    override func viewDidLoad() {
        setViewWith(photoModel: photoModel)
        setUpView()
    }
    
    //MARK : - Helpers Method
    func setUpView () {
        self.title = "Details"
        descriptionTextView.sizeToFit()
        descriptionTextView.isScrollEnabled = false
    }
    
    func setViewWith (photoModel : PhotoModel?) {
        guard let photo = photoModel else {
            return
        }
        self.titleLabel.text = photo.title
        self.descriptionTextView.attributedText = photo.descriptionRenderedText
        if photo.url_n != "" {
        self.detailsImageView.downloadImageFrom(link: photo.url_n, contentMode: .scaleAspectFit)
        }
    }
    
}

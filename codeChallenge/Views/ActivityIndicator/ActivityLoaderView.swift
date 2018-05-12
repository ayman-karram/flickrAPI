//
//  ActivityLoaderView.swift
//  codeChallenge
//
//  Created by Ayman  on 10.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import UIKit

class ActivityLoaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   @objc func show(){
        self.activityIndicator.startAnimating()
        self.isHidden = false
    }
    
   @objc func hide(){
        self.isHidden = true
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ActivityLoaderView", owner: self, options:nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight , .flexibleWidth]
    }
}

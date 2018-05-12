//
//  ExtenstionManager.swift
//  codeChallenge
//
//  Created by Ayman  on 10.05.18.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding(rawValue: String.Encoding.utf16.rawValue), allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
}

extension UIImageView {
    @objc func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async() {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

extension UITableView {
    
   @objc func addLoadMoreLoaderToFooter() {
        let tableViewFrame = self.frame
        let xPosition : CGFloat = 0
        let yPosition : CGFloat = 0
        let width = tableViewFrame.size.width
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: 35)
        let loadMoreView  = ActivityLoaderView(frame: frame)
        self.tableFooterView = loadMoreView
        self.tableFooterView?.isHidden = true
        
    }
    
   @objc func starLoadMoreIndicator() {
        if let loadMoreView = self.tableFooterView as? ActivityLoaderView {
            self.tableFooterView?.isHidden = false
            loadMoreView.activityIndicator.startAnimating()
        }
    }
    
    @objc func removeLoadMoreLoaderFromFooter () {
        self.tableFooterView?.isHidden = true
    }
    
}

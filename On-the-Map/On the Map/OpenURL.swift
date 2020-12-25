//
//  OpenURL.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/16/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit

class OpenURL : NSObject{
    static func open (toOpen: String, errorHandler: (error: String?) -> Void){
        let app = UIApplication.sharedApplication()

        var uri = toOpen
        
        if !(toOpen.hasPrefix("http://") || toOpen.hasPrefix("https://")) {
            uri = "http://" + toOpen
        }
        
        if let url = NSURL(string: uri) {
            if app.canOpenURL(url){
                app.openURL(url)
            } else {
                errorHandler(error: SharedTabBarViewConstants.UrlError)
            }
        } else {
            errorHandler(error: SharedTabBarViewConstants.UrlError)
        }

    }
}
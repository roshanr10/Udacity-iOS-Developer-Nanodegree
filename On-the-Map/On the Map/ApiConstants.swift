//
//  APIConstants.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/14/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import Foundation

struct APIConstants {
    // MARK: URLs
    let ApiScheme : String
    let ApiHost : String
    let ApiPath : String
    
    init(scheme: String, host: String, path: String) {
        ApiScheme = scheme
        ApiHost = host
        ApiPath = path
    }
}
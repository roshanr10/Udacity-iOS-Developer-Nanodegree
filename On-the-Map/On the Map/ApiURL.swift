//
//  APIURLParsing.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/14/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import Foundation

extension APIClient {
    func createURLFromParameters(constants: APIConstants, parameters: [String:AnyObject], withPathExtension: String? = nil) -> NSURL {
        let components = NSURLComponents()
        components.scheme = constants.ApiScheme
        components.host = constants.ApiHost
        components.path = constants.ApiPath + (withPathExtension ?? "")
        components.queryItems = [NSURLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.URL!
    }
}
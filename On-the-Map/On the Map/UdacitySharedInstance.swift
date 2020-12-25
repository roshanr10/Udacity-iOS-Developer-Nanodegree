//
//  UdacitySharedInstance.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/14/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import Foundation

extension UdacityAuthClient {
    static func sharedInstance() -> UdacityAuthClient {
        struct Singleton {
            static var sharedInstance = UdacityAuthClient()
        }
        return Singleton.sharedInstance
    }
}
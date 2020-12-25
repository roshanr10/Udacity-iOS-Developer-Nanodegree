//
//  ParseSharedInstance.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/14/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import Foundation

extension ParseClient {
    static func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
}
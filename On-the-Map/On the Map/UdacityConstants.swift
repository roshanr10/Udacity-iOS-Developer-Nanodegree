//
//  UdacityConstants.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/13/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import Foundation

extension UdacityAuthClient {
    struct Shared {
        static let SignUpURL = "https://www.udacity.com/account/auth#!/signup"
    }
    
    // MARK: Methods
    struct Methods {
        // MARK: Authentication
        static let Session = "/session"
        static let GetData = "/users/"
    }
}
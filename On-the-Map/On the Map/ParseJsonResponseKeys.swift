//
//  ParseJsonResponseKeys.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/14/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import Foundation

extension ParseClient {
    struct JSONResponseKeys {
        static let Results = "results"
        
        static let ObjectID = "objectId"
        static let UniqueKey = "uniqueKey"
        
        static let FirstName = "firstName"
        static let LastName = "lastName"
        
        static let MediaURL = "mediaURL"
        
        static let MapString = "mapString"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
    }
}
//
//  ParseConstants.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/13/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import Foundation

extension ParseClient {
    struct ApiKey {
        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let RestAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
    
    struct Methods {
        static let StudentLocation = "/StudentLocation?order=-updatedAt&limit=100"
        static let NewStudentLocation = "/StudentLocation"
    }
    
    struct ErrorMessages {
        static let LoadingError = "There was an error loading the locations, please try again later."
    }
    
    struct DefaultValues {
        static let ObjectID = "[No ObjectID]"
        static let UniqueKey = "[No Unique Key]"
        
        static let FirstName = "[No First Name]"
        static let LastName = "[No Last Name]"
        
        static let MediaURL = "[No Media URL]"
        static let MapString = "[No Map String]"
    }
}
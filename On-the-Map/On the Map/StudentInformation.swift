
//
//  StudentInformation.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/14/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import Foundation

struct StudentInformation {
    let objectID: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    
    init(dictionary: [String:AnyObject]) {
        objectID = dictionary[ParseClient.JSONResponseKeys.ObjectID] as? String ?? ""
        uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String ?? ParseClient.DefaultValues.ObjectID
        
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String ?? ParseClient.DefaultValues.FirstName
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as? String ?? ParseClient.DefaultValues.LastName
        
        mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String ?? ParseClient.DefaultValues.MediaURL
    
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Double ?? 0.0
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Double ?? 0.0
        mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String ?? ParseClient.DefaultValues.MapString
    }
    
    static func locationsFromDictionaries(dictionaries: [[String:AnyObject]]) -> [StudentInformation] {
        var studentInformations = [StudentInformation]()
        for studentDictionary in dictionaries {
            studentInformations.append(StudentInformation(dictionary: studentDictionary))
        }
        return studentInformations
    }
}
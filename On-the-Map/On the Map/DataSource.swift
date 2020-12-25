//
//  DataSource.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/14/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import Foundation

class DataSource: NSObject {
    private let parseClient = ParseClient.sharedInstance()
    
    var studentLocations = [StudentInformation]()
    
    func refreshLocations(completionHandler: (locations: [StudentInformation], error: NSError?) -> Void){
        ParseClient.sharedInstance().getLocations { (locations, error) in
            if((error == nil)){
                self.studentLocations = locations
            }
            completionHandler(locations: locations, error: error)
        }
    }
    
    static func sharedInstance() -> DataSource {
        struct Singleton {
            static var sharedInstance = DataSource()
        }
        return Singleton.sharedInstance
    }
}
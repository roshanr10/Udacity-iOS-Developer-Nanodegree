//
//  ParseClient.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/13/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import Foundation

class ParseClient : APIClient {
    let constants = APIConstants(scheme: "https", host: "api.parse.com", path: "/1/classes")
    
    func getLocations(completionHandlerForGET: (locations: [StudentInformation], error: NSError?) -> Void) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: self.createURLFromParameters(constants, parameters: [:], withPathExtension: ParseClient.Methods.StudentLocation))
        request.addValue(ApiKey.ApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ApiKey.RestAPIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error...
                completionHandlerForGET(locations: [], error: error)
            } else {
                self.convertDataWithCompletionHandler(data!, completionHandlerForConvertData: { (result, error) in
                    let locations = result[ParseClient.JSONResponseKeys.Results] as? [[String:AnyObject]]
                    if(error != nil){
                        completionHandlerForGET(locations: [], error: error)
                        return
                    }
                    else if(locations != nil){
                        completionHandlerForGET(locations: StudentInformation.locationsFromDictionaries(locations!), error: nil)
                    } else {
                        // Server Error
                        completionHandlerForGET(locations: [], error: NSError(domain: "containerize", code: 1, userInfo: nil))
                    }
                })
            }
        }
        task.resume()
        
        return task
    }
    
    func postLocations(info: StudentInformation, completionHandler: (error: NSError?) -> Void) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: self.createURLFromParameters(constants, parameters: [:], withPathExtension: ParseClient.Methods.NewStudentLocation))
        request.HTTPMethod = "POST"
        request.addValue(ApiKey.ApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ApiKey.RestAPIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = "{\"uniqueKey\": \"\(info.uniqueKey))\", \"firstName\": \"\(info.firstName)\", \"lastName\": \"\(info.lastName)\",\"mapString\": \"\(info.mapString)\", \"mediaURL\": \"\(info.mediaURL)\",\"latitude\": \(info.longitude), \"longitude\": \(info.latitude)}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            completionHandler(error: error)
        }
        task.resume()
        
        return task
    }
}
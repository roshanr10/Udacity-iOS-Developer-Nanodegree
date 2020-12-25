
//
//  UdacityAuthClient.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/13/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import Foundation

class UdacityAuthClient : APIClient {
    let constants = APIConstants(scheme: "https", host: "www.udacity.com", path: "/api")
    // MARK: Properties
    var firstName: String? = nil
    var lastName: String? = nil
    var id: String? = nil
    
    func login(username: String, password: String, completionHandlerForGET: (result: AnyObject!, error: NSError?, errorString: String) -> Void) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: self.createURLFromParameters(self.constants, parameters: [:], withPathExtension: UdacityAuthClient.Methods.Session))
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"" + password + "\"}}"
        request.HTTPBody = data.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            func sendError(error: String, clientErr: String) {
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(result: nil, error: NSError(domain: "login", code: 1, userInfo: userInfo), errorString: clientErr)
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)", clientErr: "There was an error logging in.")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!", clientErr: "The username and password do not match.")
                
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!", clientErr: "There was an error logging in.")
                return
            }
            
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: { (data, error) in
                let id = data["account"]!!["key"] as! String
                let path = UdacityAuthClient.Methods.GetData + "\(id)"
                
                let infoRequest = NSMutableURLRequest(URL: self.createURLFromParameters(self.constants, parameters: [:], withPathExtension: path))
                let infoTask = self.session.dataTaskWithRequest(infoRequest) { data, response, error in
                    /* GUARD: Was there an error? */
                    guard (error == nil) else {
                        sendError("There was an error with your request: \(error)", clientErr: "There was an error logging in.")
                        return
                    }
                    
                    /* GUARD: Did we get a successful 2XX response? */
                    guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                        sendError("Your request returned a status code other than 2xx!", clientErr: "There was an error logging in.")
                        return
                    }
                    
                    /* GUARD: Was there any data returned? */
                    guard let data = data else {
                        sendError("No data was returned by the request!", clientErr: "There was an error logging in.")
                        return
                    }

                    let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
                    
                    self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: { (data, error) in
                        if error != nil { // Handle error...
                            sendError("There was an error with your request: \(error)", clientErr: "There was an error logging in.")
                        }
                        
                        self.id = (data["user"]!!["key"] as! String)
                        self.firstName = (data["user"]!!["first_name"] as! String)
                        self.lastName = (data["user"]!!["last_name"] as! String)
                        
                        completionHandlerForGET(result: self.firstName, error: nil, errorString: "")
                    })
                }
                infoTask.resume()
            })
        }
        
        task.resume()
        
        return task
    }
    
    func logout() -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: self.createURLFromParameters(self.constants, parameters: [:], withPathExtension: UdacityAuthClient.Methods.Session))
        
        request.HTTPMethod = "DELETE"
        
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }

        let task = session.dataTaskWithRequest(request)
        
        task.resume()
        
        return task
    }
}
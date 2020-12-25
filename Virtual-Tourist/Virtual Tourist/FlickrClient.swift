//
//  FlickrClient.swift
//  Virtual Tourist
//
//  Created by Roshan Ravi on 5/21/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import Foundation
import CoreData

class FlickrClient: NSObject {
    var session = NSURLSession.sharedSession()
    
    var photos: [Photo] = []
    var photosCount: Int = 0
    
    func getPhotos(pin: Pin, updateHandler: (error: NSError?) -> Void) {
        self.photos = []
        self.photosCount = 0
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName("Photo", inManagedObjectContext: CoreDataStack.sharedInstance().managedObjectContext)
        fetchRequest.predicate = NSPredicate(format: "pin = %@ ", argumentArray: [pin])
        
        do {
            let results = try CoreDataStack.sharedInstance().managedObjectContext.executeFetchRequest(fetchRequest)
            if(results.count > 0){
                photos = results as! [Photo]
                photosCount = photos.count
                updateHandler(error: nil)
            } else {
                downloadPhotos(pin, updateHandler: updateHandler)
            }
        } catch {
            print(error)
        }
    }
    
    func newPhotos(pin: Pin, updateHandler: (error: NSError?) -> Void) {
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName("Pin", inManagedObjectContext: CoreDataStack.sharedInstance().managedObjectContext)
        fetchRequest.predicate = NSPredicate(format: "latitude = %@ AND longitude = %@ ", argumentArray: [pin.latitude!, pin.longitude!])
        do {
            let results = try CoreDataStack.sharedInstance().managedObjectContext.executeFetchRequest(fetchRequest)
            let page = results[0].valueForKey("page") as! Int + 1
            results[0].setValue(page, forKey: "page")
            CoreDataStack.sharedInstance().saveContext()
            
            let fetchRequest = NSFetchRequest()
            fetchRequest.entity = NSEntityDescription.entityForName("Photo", inManagedObjectContext: CoreDataStack.sharedInstance().managedObjectContext)
            fetchRequest.predicate = NSPredicate(format: "pin = %@ ", argumentArray: [results[0]])

            do {
                let fetchedEntities = try CoreDataStack.sharedInstance().managedObjectContext.executeFetchRequest(fetchRequest) as! [Photo]
                
                for entity in fetchedEntities {
                    CoreDataStack.sharedInstance().managedObjectContext.deleteObject(entity)
                }
            } catch {
                print(error)
            }
            downloadPhotos(results[0] as! Pin, updateHandler: updateHandler)
        } catch {
            print(error)
        }
    }
    
    func downloadPhotos(pin: Pin, updateHandler: (error: NSError?) -> Void) {
        self.photos = []

        let URL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f27bc09ae419a95ae7759870a61243eb&hasGeo=true&lat=\(pin.latitude!)&lon=\(pin.longitude!)&format=json&nojsoncallback=true&per_page=15&page=\(pin.page!)&media=photos&extras=url_t&content_type=1"
        
        let request = NSMutableURLRequest(URL: NSURL(string: URL)!)
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error...
                updateHandler(error: error)
            } else {
                self.convertDataWithCompletionHandler(data!, completionHandlerForConvertData: { (result, error) in
                    let res_photos = result["photos"]!!["photo"] as! [[String:AnyObject]]
                    self.photosCount = res_photos.count
                    updateHandler(error: nil)
                    for var photo in res_photos {
                        let data = NSData(contentsOfURL: NSURL(string: photo["url_t"] as! String)!)
                        
                        let entityDescription = NSEntityDescription.entityForName("Photo", inManagedObjectContext: CoreDataStack.sharedInstance().managedObjectContext)
                        let photograph = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: CoreDataStack.sharedInstance().managedObjectContext)
                        
                        photograph.setValue(data, forKey: "photo")
                        photograph.setValue(pin, forKey: "pin")
                        
                        CoreDataStack.sharedInstance().saveContext()
                        
                        self.photos.append(photograph as! Photo)
                        
                        updateHandler(error: nil)
                    }
                })
            }
        }
        task.resume()
    }
    
    func removePhoto(index: Int){
        CoreDataStack.sharedInstance().managedObjectContext.deleteObject(photos[index])
        photos.removeAtIndex(index)
        photosCount -= 1
    }
    
    func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(result: parsedResult, error: nil)
    }
}

extension FlickrClient {
    static func sharedInstance() -> FlickrClient {
        struct Singleton {
            static var sharedInstance = FlickrClient()
        }
        return Singleton.sharedInstance
    }
}
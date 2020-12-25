//
//  ShowPins.swift
//  Virtual Tourist
//
//  Created by Roshan Ravi on 5/21/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit
import MapKit
import CoreData

extension MapViewController {
    func showPins(){
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName("Pin", inManagedObjectContext: CoreDataStack.sharedInstance().managedObjectContext)
        do {
            let results = try CoreDataStack.sharedInstance().managedObjectContext.executeFetchRequest(fetchRequest)
            for result in results {
                let res = result as! NSManagedObject
                
                let annotation = MKPointAnnotation()
                annotation.coordinate.latitude = res.valueForKey("latitude") as! Double
                annotation.coordinate.longitude = res.valueForKey("longitude") as! Double
                
                mapView.addAnnotation(annotation)
            }
        } catch {
            print(error)
        }
    }
}
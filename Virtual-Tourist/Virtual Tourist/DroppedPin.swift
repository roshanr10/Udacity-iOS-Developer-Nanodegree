//
//  DroppedPin.swift
//  Virtual Tourist
//
//  Created by Roshan Ravi on 5/21/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit
import MapKit
import CoreData

extension MapViewController {
    func addRecognizer(){
        pinDropRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.dropPin(_:)))
        pinDropRecognizer.minimumPressDuration = 0.5
        
        mapView.addGestureRecognizer(pinDropRecognizer)
    }
    
    func dropPin(gestureRecognizer:UIGestureRecognizer){
        if gestureRecognizer.state == .Began {
            let touchPoint = gestureRecognizer.locationInView(mapView)
            
            let newCoordinates = mapView.convertPoint(touchPoint, toCoordinateFromView: mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinates
            
            let entityDescription = NSEntityDescription.entityForName("Pin", inManagedObjectContext: CoreDataStack.sharedInstance().managedObjectContext)
            let pin = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: CoreDataStack.sharedInstance().managedObjectContext)
            
            pin.setValue(annotation.coordinate.latitude, forKey: "latitude")
            pin.setValue(annotation.coordinate.longitude, forKey: "longitude")
            pin.setValue(1, forKey: "page")
            
            CoreDataStack.sharedInstance().saveContext()
            
            mapView.addAnnotation(annotation)
        }
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pinView = MKPinAnnotationView()
        
        pinView.animatesDrop = true
        pinView.pinTintColor = UIColor.redColor()
        return pinView
    }
}
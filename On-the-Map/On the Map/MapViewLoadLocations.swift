//
//  MapViewLoadLocations.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/14/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit
import MapKit

extension MapViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.refreshLocations()
    }
    
    @IBAction func refresh(sender: UIBarButtonItem) {
        self.refreshLocations()
    }
    
    func refreshLocations() -> Void {
        DataSource.sharedInstance().refreshLocations { (locations, error) in
            if error != nil {
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    let alert = UIAlertController(title: "Error", message: ParseClient.ErrorMessages.LoadingError, preferredStyle: UIAlertControllerStyle.Alert);
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            } else {
                self.loadLocations()
            }
        }
    }
    
    func loadLocations() {
        var annotations = [MKPointAnnotation]()
        
        for location in dataSource.studentLocations {
            let lat = CLLocationDegrees(location.latitude)
            let long = CLLocationDegrees(location.longitude)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = location.firstName
            let last = location.lastName
            
            let mediaURL = location.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotations(annotations)
        }
    }
    
}
//
//  MapViewSelection.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/16/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit
import MapKit

extension MapViewController {
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            OpenURL.open((view.annotation?.subtitle!)!) { (error) in
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.Alert);
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
//
//  InformationPostingFindLocation.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/16/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit
import MapKit

extension InformationPostingViewController {
    @IBAction func findLocation(sender: AnyObject) {
        self.activityIndicator.startAnimating()
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(locationField.text!, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    let alert = UIAlertController(title: "Error", message: SharedTabBarViewConstants.GeocodeError, preferredStyle: UIAlertControllerStyle.Alert);
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            
            if let placemark = placemarks?.first {
                let lat = CLLocationDegrees(placemark.location!.coordinate.latitude)
                let long = CLLocationDegrees(placemark.location!.coordinate.longitude)
                self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = self.coordinate
                self.mapView.addAnnotation(annotation)
                
                var mapRegion = MKCoordinateRegion()
                mapRegion.center = self.coordinate
                mapRegion.span.latitudeDelta = 0.2
                mapRegion.span.longitudeDelta = 0.2
                
                self.linkView.hidden = false
                self.geocodeView.hidden = true
                
                self.mapView.setRegion(mapRegion, animated: true)
            }
            
            self.activityIndicator.stopAnimating()
        })
    }
    
    @IBAction func postLocation(sender: AnyObject) {
        let student = StudentInformation(dictionary: [
            ParseClient.JSONResponseKeys.UniqueKey: UdacityAuthClient.sharedInstance().id!,
            ParseClient.JSONResponseKeys.FirstName: UdacityAuthClient.sharedInstance().firstName!,
            ParseClient.JSONResponseKeys.LastName: UdacityAuthClient.sharedInstance().lastName!,
            ParseClient.JSONResponseKeys.MediaURL: linkField.text!,
            ParseClient.JSONResponseKeys.Latitude: self.coordinate.latitude,
            ParseClient.JSONResponseKeys.Longitude: self.coordinate.longitude,
            ParseClient.JSONResponseKeys.MapString: locationField.text!
        ])
        
        ParseClient.sharedInstance().postLocations(student) { (error) in
            if error != nil {
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    let alert = UIAlertController(title: "Error", message: InformationPostingViewConstants.PostError, preferredStyle: UIAlertControllerStyle.Alert);
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
}

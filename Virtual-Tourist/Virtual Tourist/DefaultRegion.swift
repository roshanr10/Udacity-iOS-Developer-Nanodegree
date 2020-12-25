//
//  DefaultRegion.swift
//  Virtual Tourist
//
//  Created by Roshan Ravi on 5/21/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit
import MapKit

extension MapViewController {
    func adjustRegion(){
        if(NSUserDefaults.standardUserDefaults().boolForKey("regionChanged")){
            var region = MKCoordinateRegion()
            region.center.latitude = NSUserDefaults.standardUserDefaults().doubleForKey("latitude") ?? 0.0
            region.center.longitude = NSUserDefaults.standardUserDefaults().doubleForKey("longitude") ?? 0.0
            region.span.latitudeDelta = NSUserDefaults.standardUserDefaults().doubleForKey("latitudeDelta") ?? 1.0
            region.span.longitudeDelta = NSUserDefaults.standardUserDefaults().doubleForKey("longitudeDelta") ?? 1.0
            
            let adjustedRegion = mapView.regionThatFits(region)
            mapView.setRegion(adjustedRegion, animated: false)
        }
    }
    
    func mapView(_mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "regionChanged")
        NSUserDefaults.standardUserDefaults().setDouble(_mapView.region.center.latitude, forKey: "latitude")
        NSUserDefaults.standardUserDefaults().setDouble(_mapView.region.center.longitude, forKey: "longitude")
        NSUserDefaults.standardUserDefaults().setDouble(_mapView.region.span.latitudeDelta, forKey: "latitudeDelta")
        NSUserDefaults.standardUserDefaults().setDouble(_mapView.region.span.longitudeDelta, forKey: "longitudeDelta")
    }
}
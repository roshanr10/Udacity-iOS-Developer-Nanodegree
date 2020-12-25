//
//  AnnotationClicked.swift
//  Virtual Tourist
//
//  Created by Roshan Ravi on 5/21/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit
import MapKit

extension MapViewController {
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        selectedLatitude = view.annotation!.coordinate.latitude
        selectedLongitude = view.annotation!.coordinate.longitude
        self.performSegueWithIdentifier("photoalbum", sender: self)
        mapView.deselectAnnotation(view.annotation, animated: false)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController = segue.destinationViewController as! PhotoAlbumViewController
        viewController.latitude = selectedLatitude
        viewController.longitude = selectedLongitude
    }
}

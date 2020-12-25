//
//  MapViewController.swift
//  Virtual Tourist
//
//  Created by Roshan Ravi on 5/20/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var pinDropRecognizer: UILongPressGestureRecognizer!
    
    var selectedLatitude: NSNumber = 0.0
    var selectedLongitude: NSNumber = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.adjustRegion()
        
        self.showPins()
        
        self.addRecognizer()
    }
}
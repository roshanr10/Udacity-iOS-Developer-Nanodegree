//
//  InformationPostingViewController.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/16/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit
import MapKit

class InformationPostingViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var geocodeView: UIView!
    @IBOutlet weak var linkView: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var linkField: UITextField!
    
    var coordinate = CLLocationCoordinate2D()
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
    }

    @IBAction func dismissView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

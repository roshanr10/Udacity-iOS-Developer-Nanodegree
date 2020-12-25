//
//  ListViewLoadLocations.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/14/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit

extension ListViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
        
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
                self.tableView.reloadData()
            }
        }
    }

}

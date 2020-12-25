//
//  SharedTabBarViewController.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/14/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit

class SharedTabBarViewController: UIViewController {
    let dataSource = DataSource.sharedInstance()
    
    @IBAction func logout(sender: UIBarButtonItem) {
        UdacityAuthClient.sharedInstance().logout();
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
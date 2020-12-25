//
//  LoginViewController.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/8/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    var keyboardShown: Bool = false
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self;
        emailTextField.tag = 1
        
        passwordTextField.delegate = self;
        passwordTextField.tag = 2
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // SUBSCRIBE TO KEYBOARD NOTIFICATIONS
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // UNSUBSCRIBE FROM KEYBOARD NOTIFCATIONS
        unsubscribeToKeyboardNotifications()
    }
}


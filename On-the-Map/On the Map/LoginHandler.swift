//
//  LoginHandler.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/14/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit

extension LoginViewController {
    func textFieldShouldReturn(sender: UITextField) -> Bool {   //delegate method
        if(sender.tag == 1){
            passwordTextField.becomeFirstResponder();
        } else if(sender.tag == 2){
            login()
        }
        return false;
    }
    
    // MARK: - LOGIN
    @IBAction func login(sender: AnyObject) {
        login();
    }
    
    func login(){
        UdacityAuthClient.sharedInstance().login(emailTextField.text!, password: passwordTextField.text!) { (results, error, errorString) in
            if error != nil {
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    let alert = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertControllerStyle.Alert);
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            } else {
                // SEGUE TO TABBED VIEW
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self.performSegueWithIdentifier("login", sender: nil)
                }
            }
        }
    }
    
    @IBAction func signup(sender: AnyObject) {
        if let signupURL = NSURL(string: UdacityAuthClient.Shared.SignUpURL) where UIApplication.sharedApplication().canOpenURL(signupURL) {
            UIApplication.sharedApplication().openURL(signupURL)
        }
    }
}
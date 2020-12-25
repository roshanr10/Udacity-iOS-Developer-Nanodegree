//
//  LoginKeyboard.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/14/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit

extension LoginViewController {
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if(!keyboardShown){
            view.frame.origin.y -= getKeyboardHeight(notification) - 119
            keyboardShown = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if(keyboardShown){
            view.frame.origin.y += getKeyboardHeight(notification) + 119
            keyboardShown = false
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let keyboardSize = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }

}
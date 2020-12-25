//
//  MemeEditorViewController.swift
//  MemeMe v1.0
//
//  Created by Roshan Ravi on 8/19/15.
//  Copyright (c) 2015 Roshan Ravi. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    var memes: [Meme]!
    var meme: Meme!

    // Configure Outlets to All Storyboard Elements
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!

    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!

    // Maintain Cleared State
    var topCleared = false
    var bottomCleared = false

    // Preset Meme Text Attributes
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -5.0
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // CONFIGURE TEXTFIELDS
        topTextField.delegate = self
        topTextField.tag = 1
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.text = "TOP"
        topTextField.textAlignment = .Center
        topTextField.autocapitalizationType = .AllCharacters

        bottomTextField.delegate = self
        bottomTextField.tag = 2
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.text = "BOTTOM"
        bottomTextField.textAlignment = .Center
        bottomTextField.autocapitalizationType = .AllCharacters

        // DISABLE ACTION BUTTON UNTIL IMAGE HAS BEEN PICKED
        actionButton.enabled = false

        // DISABLE CAMERA ON DEVICE WITHOUT CAMERA CAPABILITY
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Fetch Memes into Array
        memes = getMemes()

        // Disable Cancel Button if There are No Memes in Array
        if memes.count == 0 {
            cancelButton.enabled = false
        }

        // Populate With Existing Data
        if meme != nil{
            topTextField.text = meme.topText
            bottomTextField.text = meme.bottomText
            imagePickerView.image = meme.originalImage
            actionButton.enabled = true
            toolbar.hidden = true
        }

        // SUBSCRIBE TO KEYBOARD NOTIFICATIONS
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // UNSUBSCRIBE FROM KEYBOARD NOTIFCATIONS
        unsubscribeToKeyboardNotifications()
    }


    // MARK: - Image Picker using Album/Camera
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        // Initialize UIImagePickerController
        let imagePicker = UIImagePickerController()
        // Delegate Self as Delegate for ImagePickerController
        imagePicker.delegate = self
        // Define Source Type as Photo Library
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        // Present imagePicker ViewContoller
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        // Initialize UIImagePickerController
        let imagePicker = UIImagePickerController()
        // Delegate Self as Delegate for ImagePickerController
        imagePicker.delegate = self
        // Define Source Type as Camera
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        // Present imagePicker ViewContoller
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        // Unwrap Original Image Object
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            // Configure ImageView to Show Selected Image
            imagePickerView.image = image
            // Dismiss the imagePicker with Animations
            dismissViewControllerAnimated(true, completion: nil)
            // Enable the Action Button as There is an Image in Place
            actionButton.enabled = true
        }
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Configure Textfields
    // CLEAR DEFAULT TEXT WHEN EDITING BEGINS
    @IBAction func textFieldEditingDidBegin(sender: UITextField) {
        if sender.tag == 1 && topCleared == false {
            topCleared = true
            sender.text = ""
        } else if sender.tag == 2 && bottomCleared == false {
            bottomCleared = true
            sender.text = ""
        }
    }
    // CLOSE KEYBOARD WHEN RETURN KEY IS PRESSED
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    // MARK: - Subscribe and Unsubscribe from Notifications
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            // Push view up by keyboard height
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            // Push view down by keyboard height
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }

    // Get Keyboard Height
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let keyboardSize = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }

    // MARK: - Handle Actions
    // Handle Action Button Click
    @IBAction func actionButtonClick(sender: AnyObject) {
        // Generate Meme
        let memedImage = generateMemedImage()
        // Initialize ActivityViewController
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        // Configure Completion Handler for ActivityView to Save Meme
        activityViewController.completionWithItemsHandler = {
            activity, success, items, error in
                if success == true {
                    // Run Save Function
                    self.save(memedImage)

                    // Enable Cancel Button as Array Count is at Least One
                    self.cancelButton.enabled == true

                    // Dismiss ActivityViewController
                    self.dismissViewControllerAnimated(true, completion: nil)
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
        }
        // Present activityViewController
        presentViewController(activityViewController, animated: true, completion: nil)
    }

    @IBAction func cancelMemeCreation(sender: AnyObject) {
        // Exit Editor if There are Entries in the Array
        if memes.count != 0 {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    // MARK: - Create Meme
    func generateMemedImage() -> UIImage {
        // Hide Toolbar and Navbar
        navbar.hidden = true
        toolbar.hidden = true

        // Create Image Context
        UIGraphicsBeginImageContext(view.frame.size)
        // Draw the View on Screen Within the Image Context View
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        // Generate Memed Image
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        // End Image Context
        UIGraphicsEndImageContext()

        // Show Toolbar and Navbar
        navbar.hidden = false
        if meme == nil{
            toolbar.hidden = false
        }

        // Return Meme
        return memedImage
    }

    func save (memedImage: UIImage?){
        // Save Image in Meme Struct
        let meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, originalImage: imagePickerView.image, memedImage: memedImage)

        // Add Meme to Array
        addMeme(meme)
    }
}

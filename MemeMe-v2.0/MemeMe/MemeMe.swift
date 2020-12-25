//
//  MemeMe.swift
//  MemeMe
//
//  Created by Roshan Ravi on 8/19/15.
//  Copyright (c) 2015 Roshan Ravi. All rights reserved.
//

import UIKit

// Meme Struct
public struct Meme {
    var topText:String?
    var bottomText:String?
    var originalImage: UIImage?
    var memedImage: UIImage!
}

// Get Data From App Delegate
func getAppDelegate() -> AppDelegate {
    let object = UIApplication.sharedApplication().delegate
    let appDelegate = object as! AppDelegate
    return appDelegate
}

// Get Memes from AppDelegate
func getMemes() -> [Meme]{
    // Connect to AppDelegate
    let appDelegate = getAppDelegate()
    // Return Memes
    return appDelegate.memes
}

// Append Meme to Array
func addMeme(meme: Meme){
    // Connect to AppDelegate
    let appDelegate = getAppDelegate()
    // Save Meme Struct in Array of Saved Memes
    appDelegate.memes.append(meme)
}

// Reset Array
func setMemes(memes: [Meme]) {
    // Connect to AppDelegate
    let appDelegate = getAppDelegate()
    // Reset Array
    appDelegate.memes = memes
}

// Open Editor
func editMemes(controller: UIViewController, meme: Meme) {
    // Configure Meme Editor
    let memeEditorViewController = controller.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
    // Transfer Meme Object
    memeEditorViewController.meme = meme

    // Present Editor
    controller.navigationController?.presentViewController(memeEditorViewController, animated: true, completion: nil)
}

// Remove Meme From Array
func removeMemes(controller: UIViewController, index: Int) -> [Meme]{
    // Get Meme
    var memes = getMemes()
    memes.removeAtIndex(index)
    // Set Memes
    setMemes(memes)
    // If there are no Mems, Redirect to the Editor
    if memes.count == 0 {
        showEditor(controller)
    }

    // Return Current Array of Memes
    return memes
}
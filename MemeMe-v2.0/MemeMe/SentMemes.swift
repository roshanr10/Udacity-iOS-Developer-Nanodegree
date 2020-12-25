//
//  SentMemes.swift
//  MemeMe
//
//  Created by Roshan Ravi on 8/21/15.
//  Copyright (c) 2015 Roshan Ravi. All rights reserved.
//

import UIKit

func showEditor(controller: UIViewController) {
    // Configure Editor
    let memeEditorViewController = controller.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController

    // Present Editor
    controller.navigationController?.presentViewController(memeEditorViewController, animated: true, completion: nil)
}

func showDetail(controller: UIViewController, index: Int) {
    // Configure Detail View
    let detailController = controller.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
    // Get Memes
    let memes = getMemes()
    // Set Meme
    detailController.meme = memes[index]

    // Present Detail View
    controller.navigationController?.pushViewController(detailController, animated: true)
}

func verify(controller: UIViewController) {
    // Get Memes
    let memes = getMemes()

    // Verify if Memes Array Has Records; If not, show editor
    if memes.count == 0 {
        showEditor(controller)
    }
}
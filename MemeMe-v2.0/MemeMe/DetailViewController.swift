//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Roshan Ravi on 8/21/15.
//  Copyright (c) 2015 Roshan Ravi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var meme: Meme!

    @IBOutlet weak var imageView: UIImageView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Show Image
        imageView.image = meme.memedImage

        // Create and Add Edit Button
        var button = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: Selector("editMeme:"))
        self.navigationItem.rightBarButtonItem = button
    }

    @IBAction func editMeme(sender: AnyObject) {
        editMemes(self, meme)
    }
}

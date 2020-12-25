//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Roshan Ravi on 8/21/15.
//  Copyright (c) 2015 Roshan Ravi. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    var memes: [Meme]!

    override func viewDidLoad() {
        // Set rowHeight for Cells
        self.tableView.rowHeight = 100
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Get Memes
        memes = getMemes()
        verify(self)

        // Reload Data
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get Reusable Cell
        let cell = tableView.dequeueReusableCellWithIdentifier("sentMemesTableCell", forIndexPath: indexPath) as! UITableViewCell

        // Set memedImage
        cell.imageView?.image = memes[indexPath.row].memedImage

        // Set textLabel
        if let textLabel = cell.textLabel {
            textLabel.text = memes[indexPath.row].topText! + "..." + memes[indexPath.row].bottomText!
        }

        // Return the Cell
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Show Detail View
        showDetail(self, indexPath.row)
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the Data Source
            memes = removeMemes(self, indexPath.row)

            // Remove Row from Table
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}

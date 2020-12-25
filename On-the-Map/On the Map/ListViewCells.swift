//
//  ListViewCells.swift
//  On the Map
//
//  Created by Roshan Ravi on 5/16/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit

extension ListViewController {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return dataSource.studentLocations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        
        // Set textLabel
        if let textLabel = cell.textLabel {
            textLabel.text = dataSource.studentLocations[indexPath.row].firstName + " " + dataSource.studentLocations[indexPath.row].lastName
        }
        
        if let subtitle = cell.detailTextLabel {
            subtitle.text = dataSource.studentLocations[indexPath.row].mediaURL
        }
        
        // Return the Cell
        return cell
    }
}

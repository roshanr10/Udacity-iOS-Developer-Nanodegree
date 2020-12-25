//
//  Pin+CoreDataProperties.swift
//  Virtual Tourist
//
//  Created by Roshan Ravi on 5/24/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Pin {

    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var page: NSNumber?
    @NSManaged var photos: NSSet?

}

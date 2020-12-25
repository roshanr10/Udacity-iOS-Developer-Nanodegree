//
//  PhotoAlbumViewController.swift
//  Virtual Tourist
//
//  Created by Roshan Ravi on 5/21/16.
//  Copyright © 2016 Roshan Ravi. All rights reserved.
//

import UIKit
import CoreData

class PhotoAlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!

    var latitude: NSNumber = 0.0
    var longitude: NSNumber = 0.0
    
    var photos: [Photo] = []
    var pin: [Pin] = []
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName("Pin", inManagedObjectContext: CoreDataStack.sharedInstance().managedObjectContext)
        fetchRequest.predicate = NSPredicate(format: "latitude = %@ AND longitude = %@", argumentArray: [latitude, longitude])
        var results = [Pin]()
        do {
            results = try CoreDataStack.sharedInstance().managedObjectContext.executeFetchRequest(fetchRequest) as! [Pin]
            self.pin = results
        } catch {
            print(error)
        }
        FlickrClient.sharedInstance().getPhotos(pin[0], updateHandler: updateHandler)
    }

    @IBAction func newCollection(sender: AnyObject) {
        FlickrClient.sharedInstance().newPhotos(pin[0], updateHandler: updateHandler)
    }
    
    func updateHandler (error: NSError?) -> Void{
        if(error != nil){
            NSOperationQueue.mainQueue().addOperationWithBlock {
                let alert = UIAlertController(title: "Error", message: "There was an error loading pictures.", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        } else {
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FlickrClient.sharedInstance().photosCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PhotoCell
        
        var image = UIImage();
        
        if FlickrClient.sharedInstance().photos.indices ~= indexPath.row {
            image = UIImage(data: FlickrClient.sharedInstance().photos[indexPath.row].photo!)!
        } else {
            // Thumbnail Image, Slightly Inset - Based off Of Link Below
            // stackoverflow.com/questions/6496441/creating-a-uiimage-from-a-uicolor-to-use-as-a-background-image-for-uibutton
            let rect = CGRect(x: 0, y: 0, width: 85, height: 85)
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()
            CGContextSetFillColorWithColor(context, UIColor.darkGrayColor().CGColor)
            CGContextFillRect(context, rect)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        cell.imageView.image = image
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        FlickrClient.sharedInstance().removePhoto(indexPath.row)
        self.collectionView.reloadData()
    }
}
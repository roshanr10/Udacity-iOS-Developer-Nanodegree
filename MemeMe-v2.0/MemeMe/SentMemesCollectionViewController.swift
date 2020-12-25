//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Roshan Ravi on 8/21/15.
//  Copyright (c) 2015 Roshan Ravi. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure Flow Layout for the CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let numberOfItemsInaARow = 4
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        let dimension = self.view.frame.size.width / CGFloat(numberOfItemsInaARow)
        layout.itemSize = CGSize(width: dimension, height: dimension)
        self.collectionView?.setCollectionViewLayout(layout, animated: false)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Get Memes
        memes = getMemes()
        verify(self)

        // Reload Data
        self.collectionView!.reloadData()
    }

    // MARK: - Collection view data source

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> sentMemesCollectionCell {
        // Get Reusable Cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("sentMemesCollectionCell", forIndexPath: indexPath) as! sentMemesCollectionCell

        // Set Cell Image
        cell.memedImage?.image = memes[indexPath.row].memedImage

        // Return the Cell
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Show Detail View
        showDetail(self, indexPath.row)
    }
}

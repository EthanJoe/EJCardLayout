//
//  ViewController.swift
//  TestBridge
//
//  Created by ZhouYiChen on 3/28/15.
//  Copyright (c) 2015 ZhouYiChen. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, SearchViewControllerDelegate, UICollectionViewDataSource_Draggable {

    var items =  NSMutableArray()
    var searchViewController: SearchViewController?
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.collectionView?.setPresenting(true, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGrayColor()
        // Do any additional setup after loading the view, typically from a nib.
        self.items = NSMutableArray(capacity: 20)
        for i in 0...20 {
            items.addObject("Cell \(i)")
        }
        self.searchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SearchViewController") as? SearchViewController
        
        self.searchViewController?.delegate = self
        self.collectionView?.backgroundView = self.searchViewController?.view
                
        var dropOnToDeleteView: UIImageView = UIImageView(image: UIImage(named: "trashcan"), highlightedImage: (UIImage(named: "trashcan_red")))
        dropOnToDeleteView.center = CGPointMake(50, 300)
        self.collectionView?.dropOnToDeleteView = dropOnToDeleteView
        
        var dragUpToDeleteConfirmView: UIImageView = UIImageView(image: UIImage(named: "trashcan"), highlightedImage: (UIImage(named:"trashcan_red")))
        self.collectionView?.dragUpToDeleteConfirmView = dragUpToDeleteConfirmView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UICollectionViewDatasource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: CardCell = collectionView.dequeueReusableCellWithReuseIdentifier("card", forIndexPath: indexPath) as! CardCell
        cell.titleLabel.text = items[indexPath.item] as? String
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, imageForDraggingItemAtIndexPath indexPath: NSIndexPath!) -> UIImage! {
    
        var cell: UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        var size: CGSize = cell.bounds.size
        size.height = 72.0
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        var context: CGContextRef = UIGraphicsGetCurrentContext()
        cell.layer.renderInContext(context)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func collectionView(collectionView: UICollectionView!, transformForDraggingItemAtIndexPath indexPath: NSIndexPath!, duration: UnsafeMutablePointer<NSTimeInterval>) -> CGAffineTransform {
        return CGAffineTransformMakeScale(1.05, 1.05)
    }
    
    func collectionView(collectionView: UICollectionView!, canMoveItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView!, moveItemAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
        var thing: NSString = items[fromIndexPath.item] as! NSString
        self.items.removeObjectAtIndex(fromIndexPath.item)
        self.items.insertObject(thing, atIndex: toIndexPath.item)
    }
    
    func collectionView(collectionView: UICollectionView!, didMoveItemAtIndexPath indexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
        
    }
    
    func collectionView(collectionView: UICollectionView!, canDeleteItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView!, deleteItemAtIndexPath indexPath: NSIndexPath!) {
        
        self.items.removeObjectAtIndex(indexPath.item)
    }

    
    // SearchCell
    
    func searchControllerWillBeginSearch(controller: SearchViewController) {
        if((self.collectionView?.presenting) == nil) {
            self.collectionView?.setPresenting(true, animated: true, completion: nil)
        }
    }
    
    func searchControllerWillEndSearch(controller: SearchViewController) {
        if((self.collectionView?.presenting) != nil) {
            self.collectionView?.setPresenting(false, animated: true, completion: nil)
        }
    }
    

    @IBAction func flip(sender: UIButton) {
        let indexPath: AnyObject? = self.collectionView?.indexPathsForSelectedItems().first
        var cell = self.collectionView?.cellForItemAtIndexPath(indexPath as! NSIndexPath) as! CardCell
        if (sender == cell.infoButton) {
            cell.flipTransitionWithOptions(UIViewAnimationOptions.TransitionFlipFromLeft, halfway: {(finished: Bool) -> Void in
                cell.infoButton.hidden = true
                cell.doneButton.hidden = false
                }, completion: nil)
        }
        if (sender == cell.doneButton) {
            cell.flipTransitionWithOptions(UIViewAnimationOptions.TransitionFlipFromLeft, halfway: {(finished: Bool) -> Void in
                cell.infoButton.hidden = false
                cell.doneButton.hidden = true
                }, completion: nil)
        }
    }
}
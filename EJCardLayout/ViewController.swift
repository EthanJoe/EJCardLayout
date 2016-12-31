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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView?.setPresenting(true, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray
        // Do any additional setup after loading the view, typically from a nib.
        self.items = NSMutableArray(capacity: 20)
        for i in 0...20 {
            items.add("Cell \(i)")
        }
        self.searchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        
        self.searchViewController?.delegate = self
        self.collectionView?.backgroundView = self.searchViewController?.view
                
        let dropOnToDeleteView: UIImageView = UIImageView(image: UIImage(named: "trashcan"), highlightedImage: (UIImage(named: "trashcan_red")))
        dropOnToDeleteView.center = CGPoint(x: 50, y: 300)
        self.collectionView?.dropOnToDeleteView = dropOnToDeleteView
        
        let dragUpToDeleteConfirmView: UIImageView = UIImageView(image: UIImage(named: "trashcan"), highlightedImage: (UIImage(named:"trashcan_red")))
        self.collectionView?.dragUpToDeleteConfirmView = dragUpToDeleteConfirmView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UICollectionViewDatasource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath) as! CardCell
        cell.titleLabel.text = items[indexPath.item] as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView!, imageForDraggingItemAt indexPath: IndexPath!) -> UIImage! {
    
        let cell: UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        var size: CGSize = cell.bounds.size
        size.height = 72.0
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        cell.layer.render(in: context)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func collectionView(_ collectionView: UICollectionView!, transformForDraggingItemAt indexPath: IndexPath!, duration: UnsafeMutablePointer<TimeInterval>) -> CGAffineTransform {
        return CGAffineTransform(scaleX: 1.05, y: 1.05)
    }
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let thing: NSString = items[fromIndexPath.item] as! NSString
        self.items.removeObject(at: fromIndexPath.item)
        self.items.insert(thing, at: toIndexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView!, didMoveItemAt indexPath: IndexPath!, to toIndexPath: IndexPath!) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView!, canDeleteItemAt indexPath: IndexPath!) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView!, deleteItemAt indexPath: IndexPath!) {
        
        self.items.removeObject(at: indexPath.item)
    }

    
    // SearchCell
    
    func searchControllerWillBeginSearch(_ controller: SearchViewController) {
        if((self.collectionView?.presenting) == nil) {
            self.collectionView?.setPresenting(true, animated: true, completion: nil)
        }
    }
    
    func searchControllerWillEndSearch(_ controller: SearchViewController) {
        if((self.collectionView?.presenting) != nil) {
            self.collectionView?.setPresenting(false, animated: true, completion: nil)
        }
    }
    

    @IBAction func flip(_ sender: UIButton) {
        let indexPath: AnyObject? = self.collectionView?.indexPathsForSelectedItems!.first as AnyObject?
        let cell = self.collectionView?.cellForItem(at: indexPath as! IndexPath) as! CardCell
        if (sender == cell.infoButton) {
            cell.flipTransitionWithOptions(UIViewAnimationOptions.transitionFlipFromLeft, halfway: {(finished: Bool) -> Void in
                cell.infoButton.isHidden = true
                cell.doneButton.isHidden = false
                }, completion: nil)
        }
        if (sender == cell.doneButton) {
            cell.flipTransitionWithOptions(UIViewAnimationOptions.transitionFlipFromLeft, halfway: {(finished: Bool) -> Void in
                cell.infoButton.isHidden = false
                cell.doneButton.isHidden = true
                }, completion: nil)
        }
    }
}

//
//  CardCell.swift
//  TestBridge
//
//  Created by ZhouYiChen on 3/30/15.
//  Copyright (c) 2015 ZhouYiChen. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    var shadowWidth: CGFloat?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.bounds
        if(shadowWidth != bounds.size.width) {
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.blackColor().CGColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSizeMake(0, 0)
            self.layer.cornerRadius = 5.0
            self.layer.shadowPath = UIBezierPath(rect: bounds).CGPath
            shadowWidth = bounds.size.width
        }
    }

    func flipTransitionWithOptions(options:UIViewAnimationOptions, halfway:((finished: Bool) -> Void)?, completion:((finished: Bool) -> Void)?) {
        var degree: CGFloat!
        if(options == UIViewAnimationOptions.TransitionFlipFromRight){
            degree = CGFloat(-M_PI_2)
        } else {
            degree = CGFloat(M_PI_2)
        }
        let duration: CGFloat = 0.4
        let distanceZ: CGFloat = 2000
        let translationZ: CGFloat = self.frame.width / 2
        let scaleXY: CGFloat = (distanceZ - translationZ) / distanceZ
        
        var rotationAndPerspectiveTransform: CATransform3D = CATransform3DIdentity
        rotationAndPerspectiveTransform.m34 = 1.0 / (-distanceZ)
        rotationAndPerspectiveTransform = CATransform3DTranslate(rotationAndPerspectiveTransform, 0, 0, translationZ)
        rotationAndPerspectiveTransform = CATransform3DScale(rotationAndPerspectiveTransform, scaleXY, scaleXY, 1.0)
        layer.transform = rotationAndPerspectiveTransform
        
        UIView.animateWithDuration(NSTimeInterval(duration / 2), animations: {self.layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, degree, 0.0, 1.0, 0.0)}, completion: {(finished: Bool) -> Void in
            if (halfway != nil) {
                halfway!(finished: finished)
            }
            self.layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, -degree, 0.0, 1.0, 0.0)
            UIView.animateWithDuration(NSTimeInterval(duration / 2), animations: {self.layer.transform = rotationAndPerspectiveTransform}, completion: {(finished: Bool) -> Void in
                    self.layer.transform = CATransform3DIdentity
                    if (completion != nil) {
                        completion!(finished: finished)
                    }
              })
          }
       )
    }
}

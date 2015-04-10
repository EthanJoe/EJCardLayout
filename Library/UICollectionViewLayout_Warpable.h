//
//  Copyright (c) 2013 Luke Scott
//  https://github.com/lukescott/DraggableCollectionView
//  Distributed under MIT license
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LSCollectionViewLayoutHelper;

@protocol UICollectionViewLayout_Warpable <NSObject>
@required

@property (readonly, nonatomic) LSCollectionViewLayoutHelper *layoutHelper;

@optional

- (UICollectionViewScrollDirection)scrollDirection;
- (UICollectionViewScrollDirection)dragDirection;

@end


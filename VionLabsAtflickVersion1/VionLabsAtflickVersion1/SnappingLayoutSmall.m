//
//  SnappingLayoutSmall.m
//  VionLabsAtflickVersion1
//
//  Created by Tomas Nilsson on 9/24/13.
//  Copyright (c) 2013 Niklas Nilsson. All rights reserved.
//

#import "SnappingLayoutSmall.h"

@implementation SnappingLayoutSmall

- (id)init
{
    self = [super init];
    if (self) {
        [self setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        self.itemSize = CGSizeMake(500, 250);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;

        [self.collectionView scrollToItemAtIndexPath:0 atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
    }
    return self;
}



@end

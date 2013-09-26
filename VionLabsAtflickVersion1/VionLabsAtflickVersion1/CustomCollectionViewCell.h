//
//  CustomCollectionViewCell.h
//  VionLabsAtflickVersion1
//
//  Created by Tomas Nilsson on 9/24/13.
//  Copyright (c) 2013 Niklas Nilsson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *view;


+(UINib *)nib;

@end

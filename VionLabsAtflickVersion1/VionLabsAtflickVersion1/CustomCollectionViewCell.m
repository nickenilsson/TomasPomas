//
//  CustomCollectionViewCell.m
//  VionLabsAtflickVersion1
//
//  Created by Tomas Nilsson on 9/24/13.
//  Copyright (c) 2013 Niklas Nilsson. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

+(UINib *)nib
{
    return [UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

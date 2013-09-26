//
//  RootViewController.h
//  VionLabsAtflickVersion1
//
//  Created by Tomas Nilsson on 9/18/13.
//  Copyright (c) 2013 Niklas Nilsson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *menuPlaceholder;
@property (weak, nonatomic) IBOutlet UIView *contentPlaceholder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentConstraintRight;
- (IBAction)panGestureRecognized:(id)sender;
- (IBAction)swipeRightRecognized:(id)sender;
- (IBAction)swipeLeftRecognized:(id)sender;



@end

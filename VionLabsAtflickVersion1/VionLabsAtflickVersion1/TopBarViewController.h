//
//  TopBarViewController.h
//  VionLabsAtflickVersion1
//
//  Created by Tomas Nilsson on 9/18/13.
//  Copyright (c) 2013 Niklas Nilsson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol topBarDelegate <NSObject>

-(void) menuButtonPressedInTopBar;

@end

@interface TopBarViewController : UIViewController

@property (nonatomic, weak) id <topBarDelegate> delegate;

- (IBAction)menuButtonPressed:(id)sender;

@end

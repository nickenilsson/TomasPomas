//
//  TopBarViewController.m
//  VionLabsAtflickVersion1
//
//  Created by Tomas Nilsson on 9/18/13.
//  Copyright (c) 2013 Niklas Nilsson. All rights reserved.
//

#import "TopBarViewController.h"

@interface TopBarViewController ()

@end

@implementation TopBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonPressed:(id)sender {
    
    [self.delegate menuButtonPressedInTopBar];
}
@end

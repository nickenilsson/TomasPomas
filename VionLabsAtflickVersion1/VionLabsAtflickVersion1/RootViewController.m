//
//  RootViewController.m
//  VionLabsAtflickVersion1
//
//  Created by Tomas Nilsson on 9/18/13.
//  Copyright (c) 2013 Niklas Nilsson. All rights reserved.
//

#import "RootViewController.h"
#import "TopBarViewController.h"
#import "ContentViewController.h"
#import "MainMenuViewController.h"

#define MAX_PAN_DISTANCE 400
#define ANIMATION_TIME 0.2


@interface RootViewController () <topBarDelegate, MainMenuDelegate>

@property (nonatomic, strong) TopBarViewController *topBarViewController;
@property (nonatomic, strong) ContentViewController *currentContentViewController;
@property (nonatomic, strong) MainMenuViewController *mainMenuViewController;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSLayoutConstraint *scrollViewTrailing;
@property (nonatomic) BOOL contentIsInSmallState;
@property (nonatomic) BOOL menuIsShowing;

@end

@implementation RootViewController

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
    self.contentIsInSmallState = NO;
    self.menuIsShowing = NO;
    [self.contentPlaceholder setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self addTopBarViewController];
    [self setFrameForTopBar];
    [self addScrollView];
    [self setUpScrollViewFrame];
    [self addContentViewController:[[ContentViewController alloc]init]];
    [self setScrollViewContentSize];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addTopBarViewController
{
    self.topBarViewController = [[TopBarViewController alloc]init];
    [self addChildViewController:self.topBarViewController];
    [self.topBarViewController didMoveToParentViewController:self];
    self.topBarViewController.delegate = self;
    [self.contentPlaceholder addSubview:self.topBarViewController.view];
}
-(void) setFrameForTopBar
{
    NSDictionary *views = @{@"topBar": self.topBarViewController.view};
    
    [self.topBarViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentPlaceholder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[topBar]|" options:0 metrics:nil views:views]];
    [self.contentPlaceholder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topBar(70)]" options:0 metrics:nil views:views]];
}

-(void) addScrollView
{
    self.scrollView = [[UIScrollView alloc] init];
    [self.contentPlaceholder addSubview:self.scrollView];
}
-(void) setUpScrollViewFrame
{
    NSDictionary *views = @{@"scrollView": self.scrollView,
                            @"topBar" : self.topBarViewController.view};
    
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.scrollViewTrailing = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentPlaceholder attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [self.contentPlaceholder addConstraint:self.scrollViewTrailing];
    [self.contentPlaceholder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]" options:0 metrics:nil views:views]];
    [self.contentPlaceholder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topBar][scrollView]|" options:0 metrics:nil views:views]];
}

-(void) addContentViewController:(ContentViewController *)viewController
{
    self.currentContentViewController = viewController;
    [self addChildViewController:self.currentContentViewController];
    [self.currentContentViewController didMoveToParentViewController:self];
    [self.scrollView addSubview:self.currentContentViewController.view];
}

-(void) setScrollViewContentSize
{
    self.scrollView.contentSize = CGSizeMake(self.currentContentViewController.view.bounds.size.width, self.currentContentViewController.view.bounds.size.height);
}	
-(void) addMainMenuViewController
{
    if(self.mainMenuViewController == nil){
        self.mainMenuViewController = [[MainMenuViewController alloc]init];
        [self addChildViewController:self.mainMenuViewController];
        [self.mainMenuViewController didMoveToParentViewController:self];
        self.mainMenuViewController.delegate = self;
        [self.menuPlaceholder addSubview:self.mainMenuViewController.view];
        [self.mainMenuViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.menuPlaceholder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mainMenu]|" options:0 metrics:nil views:@{@"mainMenu": self.mainMenuViewController.view}]];
        [self.menuPlaceholder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainMenu]|" options:0 metrics:nil views:@{@"mainMenu": self.mainMenuViewController.view}]];
    }
}
-(void) menuItemSelectedWithIndex:(NSUInteger)index
{
    NSLog(@"menuItemSelected: %d" , index);
}
-(void) menuButtonPressedInTopBar
{
    if (self.menuIsShowing) {
        [self moveContentPlaceholderToHideMenu];
    }else{
        [self moveContentPlaceholderToShowMenu];
    }
}
-(void) removeMainMenuViewController
{
    if(self.mainMenuViewController != nil){
        [self.mainMenuViewController removeFromParentViewController];
        self.mainMenuViewController = nil;
    }
}

- (IBAction)panGestureRecognized:(id)sender {
    
    if ([sender state] == UIGestureRecognizerStateBegan) {
        [self addMainMenuViewController];
    }
    CGPoint translation = [sender translationInView:self.view];
    CGPoint centerOfScreen = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    CGPoint newCenter = CGPointMake(self.contentPlaceholder.center.x + translation.x, centerOfScreen.y);
    
    if ((newCenter.x - centerOfScreen.x) > MAX_PAN_DISTANCE) {
        newCenter.x = centerOfScreen.x + MAX_PAN_DISTANCE;
    }else if ((newCenter.x - centerOfScreen.x) < 0){
        newCenter.x = centerOfScreen.x;
    }
    
    self.contentPlaceholder.center = newCenter;
    
    if ([sender state] == UIGestureRecognizerStateEnded) {
        CGFloat offset = self.contentPlaceholder.center.x - centerOfScreen.x;
        if (offset > MAX_PAN_DISTANCE / 2) {
            [self moveContentPlaceholderToShowMenu];
        }else{
            [self moveContentPlaceholderToHideMenu];
        }
    }
    
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];

}
-(void) moveContentPlaceholderToShowMenu
{
    [self addMainMenuViewController];
    CGPoint centerOfScreen = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    [UIView animateWithDuration:ANIMATION_TIME delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.contentPlaceholder.center = CGPointMake(centerOfScreen.x + MAX_PAN_DISTANCE, centerOfScreen.y);
    } completion:^(BOOL finished){
        self.menuIsShowing = YES;
    }];
}
-(void) moveContentPlaceholderToHideMenu
{
    CGPoint centerOfScreen = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    [UIView animateWithDuration:ANIMATION_TIME delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.contentPlaceholder.center = CGPointMake(centerOfScreen.x , centerOfScreen.y);
    } completion:^(BOOL finished){
        self.menuIsShowing = NO;
        [self removeMainMenuViewController];
    }];
}

- (IBAction)swipeRightRecognized:(id)sender {
    [self moveContentPlaceholderToShowMenu];
}

- (IBAction)swipeLeftRecognized:(id)sender {
    [self moveContentPlaceholderToHideMenu];
}

@end

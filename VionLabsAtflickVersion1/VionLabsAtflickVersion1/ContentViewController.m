//
//  ContentViewController.m
//  VionLabsAtflickVersion1
//
//  Created by Tomas Nilsson on 9/24/13.
//  Copyright (c) 2013 Niklas Nilsson. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ContentViewController.h"
#import "CustomCollectionViewCell.h"
#import "SnappingLayoutSmall.h"
#import "ArrayDataSource.h"

static NSString * const identifierSmallCell = @"smallCell";
static NSString * const identifierBigCell = @"bigCell";

@interface ContentViewController ()

@property (nonatomic, strong) ArrayDataSource *datasourceCollectionView1;
@property (nonatomic, strong) ArrayDataSource *datasourceCollectionView2;
@property (nonatomic, strong) ArrayDataSource *datasourceCollectionView3;

@property (nonatomic, strong) NSMutableArray *itemsCollectionView1;
@property (nonatomic, strong) NSMutableArray *itemsCollectionView2;
@property (nonatomic, strong) NSMutableArray *itemsCollectionView3;

@end

@implementation ContentViewController 

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
    [self createDataForCollectionViews];
    [self.collectionView1 registerNib:[CustomCollectionViewCell nib] forCellWithReuseIdentifier:identifierSmallCell];
    [self.collectionView2 registerNib:[CustomCollectionViewCell nib] forCellWithReuseIdentifier:identifierSmallCell];
    [self.collectionView3 registerNib:[CustomCollectionViewCell nib] forCellWithReuseIdentifier:identifierBigCell];
    
    CellConfigureBlock cellConfiguration = ^(CustomCollectionViewCell *cell, NSString *item){
        cell.view.layer.masksToBounds = NO;
        cell.view.layer.contentsScale = [UIScreen mainScreen].scale;
        cell.view.layer.shadowOpacity = 0.85f;
        cell.view.layer.shadowRadius = 6.0f;
        cell.view.layer.shadowOffset = CGSizeZero;
        cell.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.view.bounds].CGPath;
        cell.view.layer.shouldRasterize = YES;
        cell.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
        cell.label.text = item;
    };
    
    self.datasourceCollectionView1 = [[ArrayDataSource alloc]initWithItems:self.itemsCollectionView1 cellIdentifier:identifierSmallCell configureCellBlock:cellConfiguration];
    self.collectionView1.delaysContentTouches = NO;
    self.collectionView1.dataSource = self.datasourceCollectionView1;
    
    self.datasourceCollectionView2 = [[ArrayDataSource alloc]initWithItems:self.itemsCollectionView2 cellIdentifier:identifierSmallCell configureCellBlock:cellConfiguration];
    self.collectionView2.dataSource = self.datasourceCollectionView2;
    
    self.datasourceCollectionView3 = [[ArrayDataSource alloc]initWithItems:self.itemsCollectionView3 cellIdentifier:identifierBigCell configureCellBlock:cellConfiguration];
    self.collectionView3.dataSource = self.datasourceCollectionView3;
    
    self.collectionView1.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView2.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView3.decelerationRate = UIScrollViewDecelerationRateFast;
    
}
-(void) createDataForCollectionViews
{
    self.itemsCollectionView1 = [NSMutableArray arrayWithObjects:@"CV1item1",@"CV1item2",@"CV1item3",@"CV1item4",@"CV1item5", nil];
    self.itemsCollectionView2 = [NSMutableArray arrayWithObjects:@"CV2item1",@"CV2item2",@"CV2item3",@"CV2item4",@"CV2item5",@"CV2item5",@"CV2item5",@"CV2item5",@"CV2item5",@"CV2item5",@"CV2item5",@"CV2item5", nil];
    self.itemsCollectionView3 = [NSMutableArray arrayWithObjects:@"CV3item1",@"CV3item2",@"CV3item3",@"CV4item4",@"CV5item5",@"CV2item5",@"CV2item5",@"CV2item5",@"CV2item5",@"CV2item5", nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) animateCollectionViewToSmall
{
    [self.collectionView1 setCollectionViewLayout:[[SnappingLayoutSmall alloc]init] animated:YES];
}
-(void) animateCollectionViewToBig
{

}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"TRYCK");
}
-(void) collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"highlight");
    CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.view.layer.shadowColor = [UIColor blueColor].CGColor;

}
-(void) collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"unhighlight");

    CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.view.layer.shadowColor = [UIColor blackColor].CGColor;

}



@end

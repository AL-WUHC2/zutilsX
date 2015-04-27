//
//  ViewController.m
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ViewController.h"
#import "zutilsX.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    NSDictionary *dimensions = @{zRightMargin : @20,
                                 zWidth : [ZUXDimension dimensionWithBlock:^CGFloat(UIView *relativeView) {
                                     return relativeView.bounds.size.width - 40;
                                 }],
                                 zBottomMargin : @49,
                                 zTopMargin : @20
                                 };
    UIView *subView = [[UIView alloc] initWithRelativeView:self.view
                           autolayoutByDimensionDictionary:dimensions];
    subView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:subView];
    [subView release];
}

@end

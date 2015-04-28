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
    self.view.backgroundColor = [UIColor grayColor];
    NSDictionary *dimensions = @{zLeftMargin : @20,
                                 zWidth : [ZUXDimension dimensionWithBlock:^CGFloat(UIView *superview) {
                                     return superview.bounds.size.width / 2 - 20;
                                 }],
                                 zTopMargin : @20,
                                 zHeight : [ZUXDimension dimensionWithBlock:^CGFloat(UIView *superview) {
                                     return superview.bounds.size.height / 2 - 20;
                                 }]
                                 };
    UIView *subView = [[UIView alloc] initWithAutolayoutDimensionDictionary:dimensions];
    subView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:subView];
    [subView release];
    
    UIView *subView2 = [[UIView alloc] init];
    subView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:subView2];
    subView2.zWidth = [ZUXDimension dimensionWithBlock:^CGFloat(UIView *superview) {
        return superview.bounds.size.width / 2 - 20;
    }];
    subView2.zRightMargin = @20;
    subView2.zHeight = [ZUXDimension dimensionWithBlock:^CGFloat(UIView *superview) {
        return superview.bounds.size.height / 2 - 49;
    }];
    subView2.zBottomMargin = @49;
    [subView2 release];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2 animations:^{
            self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2);
        }];
    });
}

@end

//
//  ViewController.m
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ViewController.h"
#import "zutilsX.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    NSDictionary *transforms = @{
                                 zLeftMargin : @20
                                 ,zWidth : @"${bounds.size.width} - 20"
                                 ,zRightMargin : @20
                                 ,zTopMargin : @20
                                 ,zHeight : [ZUXTransform transformWithBlock:^CGFloat(UIView *superview) {
                                     return superview.bounds.size.height + 60;
                                 }]
                                 ,zBottomMargin : @-20
                                 };
    ZUXView *subView = [[ZUXView alloc] initWithTransformDictionary:transforms];
    subView.backgroundColor = [UIColor darkGrayColor];
    subView.tag = 1111;
    [self.view addSubview:subView];
    [subView release];
    
    ZUXView *subView2 = [[ZUXView alloc] init];
    subView2.backgroundColor = [UIColor lightGrayColor];
    subView2.tag = 2222;
    [self.view addSubview:subView2];
    subView2.zWidth = [ZUXTransform transformWithBlock:^CGFloat(UIView *superview) {
        return superview.bounds.size.width / 2 - 30;
    }];
    subView2.zRightMargin = @20;
    subView2.zHeight = [NSExpression expressionWithParametricFormat:@"bounds.#size.height / 2 - 59"];
    subView2.zBottomMargin = @49;
    [subView2 release];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2 animations:^{
            self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2);
        }];
    });
}

- (void)dealloc {
    ZUX_SUPER_DEALLOC;
}

@end

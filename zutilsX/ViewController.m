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
    
    UIControl *content = [[UIControl alloc] init];
    content.frame = self.view.bounds;
    [content addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 240)];
    v1.backgroundColor = [UIColor redColor];
    [content addSubview:v1];
    [v1 release];
    
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(160, 0, 160, 240)];
    v2.backgroundColor = [UIColor greenColor];
    [content addSubview:v2];
    [v2 release];
    
    UIView *v3 = [[UIView alloc] initWithFrame:CGRectMake(0, 240, 160, 240)];
    v3.backgroundColor = [UIColor blueColor];
    [content addSubview:v3];
    [v3 release];
    
    [self.view addSubview:content];
    [content zuxAnimate:ZUXAnimationMake(ZUXAnimateShrink|ZUXAnimateExpand, ZUXAnimateUp, 3, 0)];
    [content release];
}

- (void)dealloc {
    [super dealloc];
}

- (void)touch:(id)sender {
    [sender zuxAnimate:ZUXAnimationMake(ZUXAnimateOut|ZUXAnimateSlide|ZUXAnimateShrink, ZUXAnimateDown, 3, 0)];
}

@end

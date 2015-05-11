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
    content.backgroundColor = [UIColor whiteColor];
    content.frame = CGRectInset(self.view.bounds, 60, 60);
    [content setBorderWidth:1 forState:UIControlStateHighlighted];
    [content setBorderColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.view addSubview:content];
    [content release];
}

- (void)dealloc {
    [super dealloc];
}

@end

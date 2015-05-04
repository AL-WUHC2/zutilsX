//
//  ZUXControl.m
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXControl.h"

@implementation ZUXControl

- (id)init {
    if (self = [super init]) [self zuxInitial];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) [self zuxInitial];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) [self zuxInitial];
    return self;
}

- (void)dealloc {
    [_backgroundImage release];
    [super dealloc];
}

- (void)zuxInitial {
    self.backgroundColor = [UIColor clearColor];
    [self addTarget:self action:@selector(zuxTouchUpInsideEvent:)
   forControlEvents:UIControlEventTouchUpInside];
}

- (void)zuxTouchUpInsideEvent:(id)sender {
    self.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{ self.enabled = YES; });
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_backgroundImage) [_backgroundImage drawInRect:rect];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    [backgroundImage retain];
    [_backgroundImage release];
    _backgroundImage = backgroundImage;
    [self setNeedsDisplay];
}

@end

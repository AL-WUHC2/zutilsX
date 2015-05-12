//
//  ZUXView.m
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXView.h"

@implementation ZUXView

- (ZUX_INSTANCETYPE)init {
    if (self = [super init]) [self zuxInitial];
    return self;
}

- (ZUX_INSTANCETYPE)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) [self zuxInitial];
    return self;
}

- (ZUX_INSTANCETYPE)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) [self zuxInitial];
    return self;
}

- (void)dealloc {
    ZUX_RELEASE(_backgroundImage);
    ZUX_SUPER_DEALLOC;
}

- (void)zuxInitial {
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_backgroundImage) [_backgroundImage drawInRect:rect];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    if ([_backgroundImage isEqual:backgroundImage]) return;
    
    ZUX_RELEASE(_backgroundImage);
    _backgroundImage = ZUX_RETAIN(backgroundImage);
    [self setNeedsDisplay];
}

@end

//
//  ZUXPageControl.m
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXPageControl.h"
#import "UIImage+ZUX.h"

@interface ZUXPageControl () {
    UIImage *_pageIndicatorImage;
    UIImage *_currentPageIndicatorImage;
}

@end

@implementation ZUXPageControl

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (int i = 0; i < [self.subviews count]; i++) {
        UIImageView *dot = [self.subviews objectAtIndex:i];
        if ([dot isKindOfClass:[UIImageView class]]) {
            if (i == self.currentPage && _currentPageIndicatorColor) {
                dot.image = _currentPageIndicatorImage;
            } else if (_pageIndicatorColor) {
                dot.image = _pageIndicatorImage;
            }
        } else {
            if (i == self.currentPage && _currentPageIndicatorColor) {
                dot.backgroundColor = _currentPageIndicatorColor;
            } else if (_pageIndicatorColor) {
                dot.backgroundColor = _pageIndicatorColor;
            }
        }
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    [super setCurrentPage:currentPage];
    [self setNeedsLayout];
}

- (void)dealloc {
    [_pageIndicatorColor release];
    [_currentPageIndicatorColor release];
    [_pageIndicatorImage release];
    [_currentPageIndicatorImage release];
    [super dealloc];
}

- (void)setPageIndicatorColor:(UIColor *)pageIndicatorColor {
    [pageIndicatorColor retain];
    [_pageIndicatorColor release];
    _pageIndicatorColor = pageIndicatorColor;
    
    [_pageIndicatorImage release];
    _pageIndicatorImage = [[UIImage imageEllipseWithColor:_pageIndicatorColor
                                                     size:CGSizeMake(20, 20)] retain];
}

- (void)setCurrentPageIndicatorColor:(UIColor *)currentPageIndicatorColor {
    [currentPageIndicatorColor retain];
    [_currentPageIndicatorColor release];
    _currentPageIndicatorColor = currentPageIndicatorColor;
    
    [_currentPageIndicatorImage release];
    _currentPageIndicatorImage = [[UIImage imageEllipseWithColor:_currentPageIndicatorColor
                                                            size:CGSizeMake(20, 20)] retain];
}

@end

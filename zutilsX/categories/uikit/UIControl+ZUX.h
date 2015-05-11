//
//  UIControl+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-11.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (ZUX)

- (void)setBorderWidth:(CGFloat)width forState:(UIControlState)state;
- (CGFloat)borderWidthForState:(UIControlState)state;

- (void)setBorderColor:(UIColor *)color forState:(UIControlState)state;
- (UIColor *)borderColorForState:(UIControlState)state;

- (void)setShadowColor:(UIColor *)color forState:(UIControlState)state;
- (UIColor *)shadowColorForState:(UIControlState)state;

- (void)setShadowOpacity:(float)opacity forState:(UIControlState)state;
- (float)shadowOpacityForState:(UIControlState)state;

- (void)setShadowOffset:(CGSize)offset forState:(UIControlState)state;
- (CGSize)shadowOffsetForState:(UIControlState)state;

- (void)setShadowSize:(CGFloat)size forState:(UIControlState)state;
- (CGFloat)shadowSizeForState:(UIControlState)state;

@end

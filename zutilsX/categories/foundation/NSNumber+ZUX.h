//
//  NSNumber+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "zconstant.h"

@interface NSNumber (ZUX)

+ (ZUX_INSTANCETYPE)numberWithCGFloat:(CGFloat)value;

- (ZUX_INSTANCETYPE)initWithCGFloat:(CGFloat)value;

- (CGFloat)cgfloatValue;

@end

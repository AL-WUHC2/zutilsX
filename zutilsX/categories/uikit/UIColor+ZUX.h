//
//  UIColor+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZUX)

// Convenience methods for creating autoreleased colors with integer between 0 and 255
+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;

// Convenience methods for creating autoreleased colors with integer between 0 and 255
+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha;

// Convenience methods for creating autoreleased colors with HEX String like "ff3344"
+ (UIColor *)colorWithRGBHexString:(NSString *)hexString;

// Convenience methods for creating autoreleased colors with HEX String like "ff3344ff"
+ (UIColor *)colorWithRGBAHexString:(NSString *)hexString;

@end

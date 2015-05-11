//
//  UIImage+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZUX)

+ (UIImage *)imageRectWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageGradientRectWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor
                                   direction:(CGVector)direction size:(CGSize)size;

+ (UIImage *)imageGradientRectWithColors:(NSArray *)colors locations:(NSArray *)locations
                               direction:(CGVector)direction size:(CGSize)size;

+ (UIImage *)imageEllipseWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageForCurrentDeviceNamed:(NSString *)name;

@end

//
//  UIView+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zconstant.h"

@interface UIView (ZUX)

// Clip to Bounds.
@property BOOL      maskToBounds;

// Corner.
@property CGFloat   cornerRadius;

// Border.
@property CGFloat   borderWidth;
@property UIColor*  borderColor;

// Shadow
@property UIColor*  shadowColor;
@property float     shadowOpacity;
@property CGSize    shadowOffset;
@property CGFloat   shadowSize;

@end // UIView (ZUX) end

ZUX_EXTERN NSString *const zLeftMargin;
ZUX_EXTERN NSString *const zWidth;
ZUX_EXTERN NSString *const zRightMargin;
ZUX_EXTERN NSString *const zTopMargin;
ZUX_EXTERN NSString *const zHeight;
ZUX_EXTERN NSString *const zBottomMargin;

@interface UIView (ZUXAutoLayout)

@property (copy, nonatomic) NSDictionary *zTransforms; // animatable.

@property (copy, nonatomic) id zLeftMargin; // animatable.
@property (copy, nonatomic) id zWidth; // animatable.
@property (copy, nonatomic) id zRightMargin; // animatable.
@property (copy, nonatomic) id zTopMargin; // animatable.
@property (copy, nonatomic) id zHeight; // animatable.
@property (copy, nonatomic) id zBottomMargin; // animatable.

- (ZUX_INSTANCETYPE)initWithTransformDictionary:(NSDictionary *)transforms;

@end // UIView (ZUXAutoLayout) end

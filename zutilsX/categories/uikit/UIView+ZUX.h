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

@property (nonatomic, copy) NSDictionary *zTransforms; // animatable.

@property (nonatomic, copy) id zLeftMargin; // animatable.
@property (nonatomic, copy) id zWidth; // animatable.
@property (nonatomic, copy) id zRightMargin; // animatable.
@property (nonatomic, copy) id zTopMargin; // animatable.
@property (nonatomic, copy) id zHeight; // animatable.
@property (nonatomic, copy) id zBottomMargin; // animatable.

- (ZUX_INSTANCETYPE)initWithTransformDictionary:(NSDictionary *)transforms;

@end // UIView (ZUXAutoLayout) end

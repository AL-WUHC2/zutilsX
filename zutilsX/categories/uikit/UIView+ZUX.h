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

- (ZUX_INSTANCETYPE)initWithRelativeView:(UIView *)view autolayoutByDimensionDictionary:(NSDictionary *)dimensions;

@end // UIView (ZUXAutoLayout) end

#if NS_BLOCKS_AVAILABLE
typedef CGFloat (^ZUXDimensionBlock)(UIView *relativeView);
#endif

@interface ZUXDimension : NSObject

@property (readonly, nonatomic) ZUXDimensionBlock block;

+ (id)dimensionWithBlock:(ZUXDimensionBlock)block;

- (id)initWithBlock:(ZUXDimensionBlock)block;

@end // ZUXDimension end

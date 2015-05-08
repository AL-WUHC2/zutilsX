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

typedef NS_OPTIONS(NSUInteger, ZUXAnimateType) {
    ZUXAnimateMove      = 1 <<  0, // animate by adjust self translate-transform
    ZUXAnimateFade      = 1 <<  1, // animate by adjust self alpha
    ZUXAnimateSlide     = 1 <<  2, // animate by adjust layer mask frame
    ZUXAnimateExpand    = 1 <<  3, // animate by adjust self scale-transform
    ZUXAnimateShrink    = 1 <<  4, // animate by adjust self scale-transform, expand and shrink at same time effect nothing
    
    ZUXAnimateIn        = 0 <<  8, // animate to current state, default
    ZUXAnimateOut       = 1 <<  8, // animate from current state
    
    // relative setting effective only when ZUXAnimateMove.
    ZUXAnimateBySelf    = 0 <<  9, // animate relative by self, default
    ZUXAnimateByWindow  = 1 <<  9, // animate relative by current window
};

// ZUXAnimateExpand/ZUXAnimateShrink parameter, at least 1
ZUX_EXTERN CGFloat ZUXAnimateZoomRatio;

// relative setting effective only when ZUXAnimateMove/ZUXAnimateSlide.
typedef NS_OPTIONS(NSUInteger, ZUXAnimateDirection) {
    ZUXAnimateNone      =       0, // default
    ZUXAnimateUp        = 1 <<  0,
    ZUXAnimateLeft      = 1 <<  1,
    ZUXAnimateDown      = 1 <<  2,
    ZUXAnimateRight     = 1 <<  3,
};

typedef struct ZUXAnimation {
    ZUXAnimateType type;
    ZUXAnimateDirection direction;
    NSTimeInterval duration, delay;
} ZUXAnimation;

ZUX_INLINE ZUXAnimation
ZUXAnimationMake(ZUXAnimateType type, ZUXAnimateDirection direction, NSTimeInterval duration, NSTimeInterval delay) {
    ZUXAnimation animation;
    animation.type      = type;
    animation.direction = direction;
    animation.duration  = duration;
    animation.delay     = delay;
    return animation;
}

ZUX_INLINE ZUXAnimation
ZUXImmediateAnimationMake(ZUXAnimateType type, ZUXAnimateDirection direction, NSTimeInterval duration) {
    return ZUXAnimationMake(type, direction, duration, 0);
}

@interface UIView (ZUXAnimate)

- (void)zuxAnimate:(ZUXAnimation)animation;

- (void)zuxAnimate:(ZUXAnimation)animation completion:(void (^)())completion;

@end // UIView (ZUXAnimate) end

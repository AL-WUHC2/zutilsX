//
//  ZUXTransform.h
//  zutilsX
//
//  Created by Char Aznable on 15-4-29.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zconstant.h"

#if NS_BLOCKS_AVAILABLE
typedef CGFloat (^ZUXTransformBlock)(UIView *superview);
#endif

@interface ZUXTransform : NSObject <NSCopying>

@property (readonly, nonatomic) ZUXTransformBlock block;

+ (ZUX_INSTANCETYPE)transformWithBlock:(ZUXTransformBlock)block;

- (ZUX_INSTANCETYPE)initWithBlock:(ZUXTransformBlock)block;

+ (ZUXTransform *)fullWidthTransform;
+ (ZUXTransform *)fullHeightTransform;

+ (ZUXTransform *)halfWidthTransform;
+ (ZUXTransform *)halfHeightTransform;

+ (ZUXTransform *)aThirdWidthTransform;
+ (ZUXTransform *)aThirdHeightTransform;

+ (ZUXTransform *)quarterWidthTransform;
+ (ZUXTransform *)quarterHeightTransform;

@end

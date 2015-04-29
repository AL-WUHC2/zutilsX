//
//  ZUXTransform.m
//  zutilsX
//
//  Created by Char Aznable on 15-4-29.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXTransform.h"

@implementation ZUXTransform

+ (ZUX_INSTANCETYPE)transformWithBlock:(ZUXTransformBlock)block {
    return [[[self alloc] initWithBlock:block] autorelease];
}

- (ZUX_INSTANCETYPE)init {
    if (self = [super init]) _block = nil;
    return self;
}

- (ZUX_INSTANCETYPE)initWithBlock:(ZUXTransformBlock)block {
    if (self = [super init]) _block = Block_copy(block);
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] allocWithZone:zone] initWithBlock:_block];
}

- (void)dealloc {
    if (_block) Block_release(_block);
    [super dealloc];
}

#pragma mark - Some Convenience Transform.

+ (ZUXTransform *)nilTransform {
    return [[[self alloc] init] autorelease];
}

+ (ZUXTransform *)fullWidthTransform {
    return [self transformWithBlock:^CGFloat(UIView *superview) {
        return superview.bounds.size.width;
    }];
}

+ (ZUXTransform *)fullHeightTransform {
    return [self transformWithBlock:^CGFloat(UIView *superview) {
        return superview.bounds.size.height;
    }];
}

+ (ZUXTransform *)halfWidthTransform {
    return [self transformWithBlock:^CGFloat(UIView *superview) {
        return superview.bounds.size.width / 2;
    }];
}

+ (ZUXTransform *)halfHeightTransform {
    return [self transformWithBlock:^CGFloat(UIView *superview) {
        return superview.bounds.size.height / 2;
    }];
}

+ (ZUXTransform *)aThirdWidthTransform {
    return [self transformWithBlock:^CGFloat(UIView *superview) {
        return superview.bounds.size.width / 3;
    }];
}

+ (ZUXTransform *)aThirdHeightTransform {
    return [self transformWithBlock:^CGFloat(UIView *superview) {
        return superview.bounds.size.height / 3;
    }];
}

+ (ZUXTransform *)quarterWidthTransform {
    return [self transformWithBlock:^CGFloat(UIView *superview) {
        return superview.bounds.size.width / 4;
    }];
}

+ (ZUXTransform *)quarterHeightTransform {
    return [self transformWithBlock:^CGFloat(UIView *superview) {
        return superview.bounds.size.height / 4;
    }];
}

@end

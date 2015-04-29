//
//  UIView+ZUX.m
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "UIView+ZUX.h"
#import "NSObject+ZUX.h"
#import "NSNumber+ZUX.h"
#import "NSDictionary+ZUX.h"
#import "ZUXTransform.h"
#import <objc/runtime.h>

@implementation UIView (ZUX)

- (BOOL)maskToBounds {
    return self.layer.masksToBounds;
}

- (void)setMaskToBounds:(BOOL)maskToBounds {
    self.layer.masksToBounds = maskToBounds;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (float)shadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)setShadowOpacity:(float)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}

- (CGSize)shadowOffset {
    return self.layer.shadowOffset;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (CGFloat)shadowSize {
    return self.layer.shadowRadius;
}

- (void)setShadowSize:(CGFloat)shadowSize {
    self.layer.shadowRadius = shadowSize;
}

@end // UIView (ZUX) end

NSString *const zLayoutTransformsDictionaryKey  = @"ZLayoutTransformsDictionaryKey";

NSString *const zLayoutKVOContext               = @"ZLayoutKVOContext";
NSString *const zTransformsKVOKey               = @"zTransforms";
NSString *const zLeftMarginKVOKey               = @"ZLeftMargin";
NSString *const zWidthKVOKey                    = @"ZWidth";
NSString *const zRightMarginKVOKey              = @"ZRightMargin";
NSString *const zTopMarginKVOKey                = @"ZTopMargin";
NSString *const zHeightKVOKey                   = @"ZHeight";
NSString *const zBottomMarginKVOKey             = @"ZBottomMargin";
NSString *const zSuperviewFrameKVOKey           = @"frame";
NSString *const zSuperviewBoundsKVOKey          = @"bounds";

NSString *const zLeftMargin                     = @"ZLeftMargin";
NSString *const zWidth                          = @"ZWidth";
NSString *const zRightMargin                    = @"ZRightMargin";
NSString *const zTopMargin                      = @"ZTopMargin";
NSString *const zHeight                         = @"ZHeight";
NSString *const zBottomMargin                   = @"ZBottomMargin";

@implementation UIView (ZUXAutoLayout)

+ (void)load {
    [super load];
    // observe superview change
    [self swizzleOriSelector:@selector(willMoveToSuperview:)
             withNewSelector:@selector(zuxWillMoveToSuperview:)];
    // dealloc with removeObserver
    [self swizzleOriSelector:@selector(dealloc)
             withNewSelector:@selector(zuxDealloc)];
}

- (ZUX_INSTANCETYPE)initWithTransformDictionary:(NSDictionary *)transforms {
    [self init];
    
    [self setZTransforms:transforms];
    [self addObserver:self forKeyPath:zTransformsKVOKey
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
              context:zLayoutKVOContext];
    [self p_AddFrameAndBoundsObserversToView:self.superview];
    
    return self;
}

- (void)zuxWillMoveToSuperview:(UIView *)newSuperview {
    [self zuxWillMoveToSuperview:newSuperview];
    
    [self p_RemoveFrameAndBoundsObserversFromView:self.superview];
    [self p_AddFrameAndBoundsObserversToView:newSuperview];
}

- (void)zuxDealloc {
    [self p_RemoveFrameAndBoundsObserversFromView:self.superview];
    [self removeObserver:self forKeyPath:zTransformsKVOKey
                 context:zLayoutKVOContext];
    [self setZTransforms:nil];
    
    [self zuxDealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (![zLayoutKVOContext isEqual:context]) [super observeValueForKeyPath:keyPath ofObject:object
                                                                     change:change context:context];
    
    NSDictionary *transforms = objc_getAssociatedObject(self, zLayoutTransformsDictionaryKey);
    if (!self.superview || !transforms || transforms.count < 4) return;
    
    if (([self.superview isEqual:object] && [@[zSuperviewFrameKVOKey, zSuperviewBoundsKVOKey] containsObject:keyPath]) ||
        ([self isEqual:object] && [zTransformsKVOKey isEqualToString:keyPath]) ||
        ([transforms isEqual:object] && [@[zLeftMarginKVOKey, zWidthKVOKey, zRightMarginKVOKey,
                                           zTopMarginKVOKey, zHeightKVOKey, zBottomMarginKVOKey] containsObject:keyPath])) {
        self.frame = rectTransformFromSuperView(self.superview, transforms);
    }
}

- (NSDictionary *)zTransforms {
    if (!objc_getAssociatedObject(self, zLayoutTransformsDictionaryKey)) {
        [self setZTransforms:@{}];
    }
    return objc_getAssociatedObject(self, zLayoutTransformsDictionaryKey);
}

- (void)setZTransforms:(NSDictionary *)zTransforms {
    NSDictionary *oriTransforms = objc_getAssociatedObject(self, zLayoutTransformsDictionaryKey);
    [oriTransforms removeObserver:self forKeyPath:zLeftMarginKVOKey
                          context:zLayoutKVOContext];
    [oriTransforms removeObserver:self forKeyPath:zWidthKVOKey
                          context:zLayoutKVOContext];
    [oriTransforms removeObserver:self forKeyPath:zRightMarginKVOKey
                          context:zLayoutKVOContext];
    [oriTransforms removeObserver:self forKeyPath:zTopMarginKVOKey
                          context:zLayoutKVOContext];
    [oriTransforms removeObserver:self forKeyPath:zHeightKVOKey
                          context:zLayoutKVOContext];
    [oriTransforms removeObserver:self forKeyPath:zBottomMarginKVOKey
                          context:zLayoutKVOContext];
    
    if (!zTransforms) return;
    
    NSMutableDictionary *transforms = [[zTransforms deepMutableCopy] autorelease];
    objc_setAssociatedObject(self, zLayoutTransformsDictionaryKey, transforms,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [transforms addObserver:self forKeyPath:zLeftMarginKVOKey
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                    context:zLayoutKVOContext];
    [transforms addObserver:self forKeyPath:zWidthKVOKey
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                    context:zLayoutKVOContext];
    [transforms addObserver:self forKeyPath:zRightMarginKVOKey
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                    context:zLayoutKVOContext];
    [transforms addObserver:self forKeyPath:zTopMarginKVOKey
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                    context:zLayoutKVOContext];
    [transforms addObserver:self forKeyPath:zHeightKVOKey
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                    context:zLayoutKVOContext];
    [transforms addObserver:self forKeyPath:zBottomMarginKVOKey
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                    context:zLayoutKVOContext];
}

- (id)zLeftMargin {
    return self.zTransforms[zLeftMargin];
}

- (void)setZLeftMargin:(id)zLeftMarginValue {
    [self p_MutableZTransforms][zLeftMargin] = [[zLeftMarginValue copy] autorelease];
}

- (id)zWidth {
    return self.zTransforms[zWidth];
}

- (void)setZWidth:(id)zWidthValue {
    [self p_MutableZTransforms][zWidth] = [[zWidthValue copy] autorelease];
}

- (id)zRightMargin {
    return self.zTransforms[zRightMargin];
}

- (void)setZRightMargin:(id)zRightMarginValue {
    [self p_MutableZTransforms][zRightMargin] = [[zRightMarginValue copy] autorelease];
}

- (id)zTopMargin {
    return self.zTransforms[zTopMargin];
}

- (void)setZTopMargin:(id)zTopMarginValue {
    [self p_MutableZTransforms][zTopMargin] = [[zTopMarginValue copy] autorelease];
}

- (id)zHeight {
    return self.zTransforms[zHeight];
}

- (void)setZHeight:(id)zHeightValue {
    [self p_MutableZTransforms][zHeight] = [[zHeightValue copy] autorelease];
}

- (id)zBottomMargin {
    return self.zTransforms[zBottomMargin];
}

- (void)setZBottomMargin:(id)zBottomMarginValue {
    [self p_MutableZTransforms][zBottomMargin] = [[zBottomMarginValue copy] autorelease];
}

#pragma mark - Autolayout Implement Methods.

CGFloat transformValue(UIView *superview, id transform) {
    if ([transform isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)transform cgfloatValue];
    } else if ([transform isKindOfClass:[ZUXTransform class]]) {
        ZUXTransformBlock block = [(ZUXTransform *)transform block];
        NSCAssert(block, @"ZUXTransformBlock Undefined.");
        return superview ? block(superview) : 0;
    } else if (transform == nil) {
        return 0;
    }
    NSCAssert(false, @"Transform Type Unrecognized.");
    return 0;
}

void transformOriginAndSize(UIView *superview, CGFloat superviewSize,
                            id marginTransform1, id sizeTransform, id marginTransform2,
                            CGFloat *resultOrigin, CGFloat *resultSize) {
    CGFloat margin1 = transformValue(superview, marginTransform1);
    CGFloat margin2 = transformValue(superview, marginTransform2);
    *resultSize = sizeTransform ? transformValue(superview, sizeTransform) : superviewSize - margin1 - margin2;
    
    if (!marginTransform1) margin1 = superviewSize - *resultSize - margin2;
    if (!marginTransform2) margin2 = superviewSize - *resultSize - margin1;
    // adjust origin:
    // capacity     = SS - m1 - m2;
    // center       = capacity / 2 + m1
    //              = (SS + m1 - m2) / 2;
    // leftCoord    = center - S / 2
    //              = (SS + m1 - m2 - S) / 2;
    *resultOrigin = (superviewSize + margin1 - margin2 - *resultSize) / 2;
}

CGRect rectTransformFromSuperView(UIView *superview, NSDictionary *transforms) {
    NSDictionary *xTransforms = [transforms subDictionaryForKeys:@[zLeftMargin, zWidth, zRightMargin]];
    NSDictionary *yTransforms = [transforms subDictionaryForKeys:@[zTopMargin, zHeight, zBottomMargin]];
    NSCAssert(xTransforms.count > 1 && yTransforms.count > 1, @"Transform parameters not enough.");
    
    CGRect result = CGRectZero;
    transformOriginAndSize(superview, superview.bounds.size.width,
                           xTransforms[zLeftMargin], xTransforms[zWidth], xTransforms[zRightMargin],
                           &result.origin.x, &result.size.width);
    transformOriginAndSize(superview, superview.bounds.size.height,
                           yTransforms[zTopMargin], yTransforms[zHeight], yTransforms[zBottomMargin],
                           &result.origin.y, &result.size.height);
    return result;
}

#pragma mark - Private Methods.

- (NSMutableDictionary *)p_MutableZTransforms {
    return (NSMutableDictionary *)self.zTransforms;
}

- (void)p_AddFrameAndBoundsObserversToView:(UIView *)view {
    [view addObserver:self forKeyPath:zSuperviewFrameKVOKey
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
              context:zLayoutKVOContext];
    [view addObserver:self forKeyPath:zSuperviewBoundsKVOKey
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
              context:zLayoutKVOContext];
}

- (void)p_RemoveFrameAndBoundsObserversFromView:(UIView *)view {
    [view removeObserver:self forKeyPath:zSuperviewFrameKVOKey
                 context:zLayoutKVOContext];
    [view removeObserver:self forKeyPath:zSuperviewBoundsKVOKey
                 context:zLayoutKVOContext];
}

@end // UIView (ZUXAutoLayout) end

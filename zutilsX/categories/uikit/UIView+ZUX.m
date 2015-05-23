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
#import "NSExpression+ZUX.h"
#import "ZUXTransform.h"
#import <objc/runtime.h>

@implementation UIView (ZUX)

#pragma mark - Properties Methods.

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

#pragma mark -

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

- (ZUX_INSTANCETYPE)initWithTransformDictionary:(NSDictionary *)transforms {
    if ([self init]) {
        NSMutableDictionary *zTransforms = ZUX_AUTORELEASE([transforms deepMutableCopy]);
        objc_setAssociatedObject(self, (__bridge const void *)(zLayoutTransformsDictionaryKey),
                                 zTransforms, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self p_AddFrameAndBoundsObserversToView:self.superview];
    }
    return self;
}

#pragma mark - Swizzle & Override Methods.

+ (void)load {
    // observe superview change
    [self swizzleOriSelector:@selector(willMoveToSuperview:)
             withNewSelector:@selector(zuxWillMoveToSuperview:)];
    [self swizzleOriSelector:@selector(didMoveToSuperview)
             withNewSelector:@selector(zuxDidMoveToSuperview)];
#if !IS_ARC
    // dealloc with removeObserver
    [self swizzleOriSelector:@selector(dealloc)
             withNewSelector:@selector(zuxDealloc)];
#endif
}

- (void)zuxWillMoveToSuperview:(UIView *)newSuperview {
    [self zuxWillMoveToSuperview:newSuperview];
    
    if ([self.superview isEqual:newSuperview]) return;
    [self p_RemoveFrameAndBoundsObserversFromView:self.superview];
}

- (void)zuxDidMoveToSuperview {
    [self zuxDidMoveToSuperview];
    
    [self p_AddFrameAndBoundsObserversToView:self.superview];
}

- (void)zuxDealloc {
    [self p_RemoveFrameAndBoundsObserversFromView:self.superview];
    objc_setAssociatedObject(self, (__bridge const void *)(zLayoutTransformsDictionaryKey),
                             nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self zuxDealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (![zLayoutKVOContext isEqual:(__bridge id)(context)]) [super observeValueForKeyPath:keyPath ofObject:object
                                                                     change:change context:context];
    
    if ([object isEqual:self.superview] && [@[zSuperviewFrameKVOKey, zSuperviewBoundsKVOKey] containsObject:keyPath]) {
        if (!self.superview || !self.zTransforms) return;
        self.frame = rectTransformFromSuperView(self.superview, self.zTransforms);
    }
}

- (void)didChangeValueForKey:(NSString *)key {
    if ([@[zTransformsKVOKey, zLeftMarginKVOKey, zWidthKVOKey, zRightMarginKVOKey, zTopMarginKVOKey, zHeightKVOKey, zBottomMarginKVOKey] containsObject:key]) {
        if (!self.superview || !self.zTransforms) return;
        self.frame = rectTransformFromSuperView(self.superview, self.zTransforms);
    }
    [super didChangeValueForKey:key];
}

#pragma mark - Properties Methods.

- (NSDictionary *)zTransforms {
    return objc_getAssociatedObject(self, (__bridge const void *)(zLayoutTransformsDictionaryKey));
}

- (void)setZTransforms:(NSDictionary *)zTransforms {
    NSDictionary *oriTransforms = objc_getAssociatedObject(self, (__bridge const void *)(zLayoutTransformsDictionaryKey));
    if ([oriTransforms isEqualToDictionary:zTransforms]) return;
    
    NSMutableDictionary *transforms = ZUX_AUTORELEASE([zTransforms deepMutableCopy]);
    objc_setAssociatedObject(self, (__bridge const void *)(zLayoutTransformsDictionaryKey),
                             transforms, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)zLeftMargin {
    return self.zTransforms[zLeftMargin];
}

- (void)setZLeftMargin:(id)zLeftMarginValue {
    [self p_SettableZTransforms][zLeftMargin] = ZUX_AUTORELEASE([zLeftMarginValue copy]);
}

- (id)zWidth {
    return self.zTransforms[zWidth];
}

- (void)setZWidth:(id)zWidthValue {
    [self p_SettableZTransforms][zWidth] = ZUX_AUTORELEASE([zWidthValue copy]);
}

- (id)zRightMargin {
    return self.zTransforms[zRightMargin];
}

- (void)setZRightMargin:(id)zRightMarginValue {
    [self p_SettableZTransforms][zRightMargin] = ZUX_AUTORELEASE([zRightMarginValue copy]);
}

- (id)zTopMargin {
    return self.zTransforms[zTopMargin];
}

- (void)setZTopMargin:(id)zTopMarginValue {
    [self p_SettableZTransforms][zTopMargin] = ZUX_AUTORELEASE([zTopMarginValue copy]);
}

- (id)zHeight {
    return self.zTransforms[zHeight];
}

- (void)setZHeight:(id)zHeightValue {
    [self p_SettableZTransforms][zHeight] = ZUX_AUTORELEASE([zHeightValue copy]);
}

- (id)zBottomMargin {
    return self.zTransforms[zBottomMargin];
}

- (void)setZBottomMargin:(id)zBottomMarginValue {
    [self p_SettableZTransforms][zBottomMargin] = ZUX_AUTORELEASE([zBottomMarginValue copy]);
}

#pragma mark - Autolayout Implement Methods.

CGFloat transformValue(UIView *superview, id transform) {
    if ([transform isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)transform cgfloatValue];
    } else if ([transform isKindOfClass:[ZUXTransform class]]) {
        ZUXTransformBlock block = [(ZUXTransform *)transform block];
        return (block && superview) ? block(superview) : 0;
    } else if ([transform isKindOfClass:[NSExpression class]]) {
        id result = [(NSExpression *)transform expressionValueWithObject:superview context:nil];
        return [result respondsToSelector:@selector(cgfloatValue)] ? [result cgfloatValue] : 0;
    } else if ([transform isKindOfClass:[NSString class]]) {
        return transformValue(superview, [NSExpression expressionWithParametricFormat:transform]);
    }
    return 0;
}

void transformOriginAndSize(UIView *superview, CGFloat superviewSize,
                            id marginTransform1, id sizeTransform, id marginTransform2,
                            CGFloat *resultOrigin, CGFloat *resultSize) {
    CGFloat margin1 = transformValue(superview, marginTransform1);
    CGFloat margin2 = transformValue(superview, marginTransform2);
    *resultSize = sizeTransform ? transformValue(superview, sizeTransform) : superviewSize - margin1 - margin2;
    
    if (!marginTransform1 && marginTransform2) margin1 = superviewSize - *resultSize - margin2;
    if (!marginTransform2 && marginTransform1) margin2 = superviewSize - *resultSize - margin1;
    // adjust origin:
    // SS           : superviewSize
    // S            : size
    // m1           : margin1
    // m2           : margin2
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

- (NSMutableDictionary *)p_SettableZTransforms {
    if (!objc_getAssociatedObject(self, (__bridge const void *)(zLayoutTransformsDictionaryKey))) {
        [self setZTransforms:@{}];
    }
    return (NSMutableDictionary *)self.zTransforms;
}

- (void)p_AddFrameAndBoundsObserversToView:(UIView *)view {
    [view addObserver:self forKeyPath:zSuperviewFrameKVOKey
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
              context:(__bridge void *)(zLayoutKVOContext)];
    [view addObserver:self forKeyPath:zSuperviewBoundsKVOKey
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
              context:(__bridge void *)(zLayoutKVOContext)];
}

- (void)p_RemoveFrameAndBoundsObserversFromView:(UIView *)view {
    [view removeObserver:self forKeyPath:zSuperviewFrameKVOKey
                 context:(__bridge void *)(zLayoutKVOContext)];
    [view removeObserver:self forKeyPath:zSuperviewBoundsKVOKey
                 context:(__bridge void *)(zLayoutKVOContext)];
}

@end // UIView (ZUXAutoLayout) end

#pragma mark -

CGFloat ZUXAnimateZoomRatio = 2;

@implementation UIView (ZUXAnimate)

- (void)zuxAnimate:(ZUXAnimation)animation {
    [self zuxAnimate:animation completion:^{}];
}

- (void)zuxAnimate:(ZUXAnimation)animation completion:(void (^)())completion {
    CGAffineTransform selfStartTrans = self.transform;
    CGAffineTransform selfFinalTrans = self.transform;
    CGAffineTransform *selfTrans = &selfStartTrans;
    
    CGFloat selfStartAlpha = self.alpha;
    CGFloat selfFinalAlpha = self.alpha;
    CGFloat *selfAlpha = &selfStartAlpha;
    
    UIView *maskView = nil;
    CGAffineTransform maskStartTrans = CGAffineTransformIdentity;
    CGAffineTransform maskFinalTrans = CGAffineTransformIdentity;
    CGAffineTransform *maskTrans = &maskStartTrans;

    if (hasZUXAnimateType(animation, ZUXAnimateOut)) {
        selfTrans = &selfFinalTrans;
        selfAlpha = &selfFinalAlpha;
        maskTrans = &maskFinalTrans;
    }
    
    if (hasZUXAnimateType(animation, ZUXAnimateMove)) {
        ZUXCGAffineTransformTranslate(selfTrans, ZUXAnimateTranslateVector(self, animation));
    }
    
    if (hasZUXAnimateType(animation, ZUXAnimateFade)) *selfAlpha = 0;
    
    if (hasZUXAnimateType(animation, ZUXAnimateSlide)) {
        maskView = ZUX_AUTORELEASE([[UIView alloc] initWithFrame:self.bounds]);
        maskView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.layer.mask = maskView.layer;
        ZUXCGAffineTransformTranslate(maskTrans, ZUXAnimateTranslateVector(self, animation));
    }
    
    CGFloat scale = 1;
    if (hasZUXAnimateType(animation, ZUXAnimateExpand)) scale /= MAX(ZUXAnimateZoomRatio, 1);
    if (hasZUXAnimateType(animation, ZUXAnimateShrink)) scale *= MAX(ZUXAnimateZoomRatio, 1);
    if (hasZUXAnimateType(animation, ZUXAnimateOut)) scale = 1 / scale;
    ZUXCGAffineTransformScale(selfTrans, scale);
    ZUXCGAffineTransformScale(maskTrans, scale);
    
    self.transform = selfStartTrans;
    self.alpha = selfStartAlpha;
    maskView.transform = maskStartTrans;
    [UIView animateWithDuration:animation.duration delay:animation.delay options:0
                     animations:^{
                         self.transform = selfFinalTrans;
                         self.alpha = selfFinalAlpha;
                         maskView.transform = maskFinalTrans;
                     } completion:^(BOOL finished) { completion(); }];
}

#pragma mark - ZUXAnimate Implement Methods.

bool hasZUXAnimateType(ZUXAnimation animation, ZUXAnimateType type) { return animation.type & type; }

bool hasZUXAnimateDirection(ZUXAnimation animation, ZUXAnimateDirection type) { return animation.direction & type; }

void ZUXCGAffineTransformTranslate(CGAffineTransform *t, CGVector vector) {
    *t = CGAffineTransformTranslate(*t, vector.dx, vector.dy);
}

void ZUXCGAffineTransformScale(CGAffineTransform *t, CGFloat scale) {
    *t = CGAffineTransformScale(*t, scale, scale);
}

CGVector ZUXAnimateTranslateVector(UIView *view, ZUXAnimation animation) {
    CGSize relativeSize = view.frame.size;
    if (hasZUXAnimateType(animation, ZUXAnimateByWindow))
        relativeSize = [UIScreen mainScreen].bounds.size;
    
    int direction = 1;
    if (hasZUXAnimateType(animation, ZUXAnimateOut)) direction = -1;
    
    CGVector vector = CGVectorMake(0, 0);
    if (hasZUXAnimateDirection(animation, ZUXAnimateUp)) vector.dy += direction * relativeSize.height;
    if (hasZUXAnimateDirection(animation, ZUXAnimateLeft)) vector.dx += direction * relativeSize.width;
    if (hasZUXAnimateDirection(animation, ZUXAnimateDown)) vector.dy -= direction * relativeSize.height;
    if (hasZUXAnimateDirection(animation, ZUXAnimateRight)) vector.dx -= direction * relativeSize.width;
    
    return vector;
}

@end // UIView (ZUXAnimate) end

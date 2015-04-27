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

NSString *const zLayoutRelativeViewKey          = @"ZLayoutRelativeViewKey";
NSString *const zLayoutDimensionsDictionaryKey  = @"ZLayoutDimensionsDictionaryKey";

NSString *const zLeftMargin                     = @"ZLeftMargin";
NSString *const zWidth                          = @"ZWidth";
NSString *const zRightMargin                    = @"ZRightMargin";

NSString *const zTopMargin                      = @"ZTopMargin";
NSString *const zHeight                         = @"ZHeight";
NSString *const zBottomMargin                   = @"ZBottomMargin";

CGFloat dimensionValue(UIView *relativeView, id dimension) {
    if ([dimension isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)dimension cgfloatValue];
    } else if ([dimension isKindOfClass:[ZUXDimension class]]) {
        ZUXDimensionBlock block = [(ZUXDimension *)dimension block];
        return block ? block(relativeView) : 0;
    }
    return 0;
}

void calculateOriginAndSize(UIView *relativeView, CGFloat relativeSize,
                            id sizeValue, id marginValue1, id marginValue2,
                            CGFloat *origin, CGFloat *size) {
    CGFloat dimensionSize = dimensionValue(relativeView, sizeValue);
    CGFloat dimensionMargin1 = dimensionValue(relativeView, marginValue1);
    CGFloat dimensionMargin2 = dimensionValue(relativeView, marginValue2);
    *size = sizeValue ? dimensionSize : relativeSize - dimensionMargin1 - dimensionMargin2;
    
    if (!marginValue1) dimensionMargin1 = relativeSize - dimensionSize - dimensionMargin2;
    if (!marginValue2) dimensionMargin2 = relativeSize - dimensionSize - dimensionMargin1;
    *origin = (relativeSize - *size) * dimensionMargin1 / (dimensionMargin1 + dimensionMargin2);
}

CGRect rectRelativeFromViewByDimensionsDictionary(UIView *relativeView, NSDictionary *dimensions) {
    NSDictionary *xDimensions = [dimensions subDictionaryForKeys:@[zLeftMargin, zWidth, zRightMargin]];
    NSDictionary *yDimensions = [dimensions subDictionaryForKeys:@[zTopMargin, zHeight, zBottomMargin]];
    NSCParameterAssert(xDimensions.count > 1 && yDimensions.count > 1);
    CGRect result = CGRectZero;
    calculateOriginAndSize(relativeView, relativeView.bounds.size.width,
                           xDimensions[zWidth], xDimensions[zLeftMargin], xDimensions[zRightMargin],
                           &result.origin.x, &result.size.width);
    calculateOriginAndSize(relativeView, relativeView.bounds.size.height,
                           yDimensions[zHeight], yDimensions[zTopMargin], yDimensions[zBottomMargin],
                           &result.origin.y, &result.size.height);
    return result;
}

@implementation UIView (ZUXAutoLayout)

+ (void)load {
    [super load];
    [self swizzleOriSelector:@selector(zuxDealloc) withNewSelector:@selector(dealloc)];
}

- (ZUX_INSTANCETYPE)initWithRelativeView:(UIView *)view autolayoutByDimensionDictionary:(NSDictionary *)dimensions {
    [self init];
    if (view) {
        objc_setAssociatedObject(self, zLayoutRelativeViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, zLayoutDimensionsDictionaryKey, dimensions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [view addObserver:self forKeyPath:@"bounds"
                  options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
    }
    return self;
}

- (void)zuxDealloc {
    [objc_getAssociatedObject(self, zLayoutRelativeViewKey) removeObserver:self forKeyPath:@"bounds"];
    
    [self zuxDealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UIView *relativeView = objc_getAssociatedObject(self, zLayoutRelativeViewKey);
    if ([relativeView isEqual:object] && [@"bounds" isEqualToString:keyPath]) {
        NSDictionary *dimensions = objc_getAssociatedObject(self, zLayoutDimensionsDictionaryKey);
        self.frame = rectRelativeFromViewByDimensionsDictionary(relativeView, dimensions);
    }
}

@end // UIView (ZUXAutoLayout) end

@implementation ZUXDimension

+ (ZUX_INSTANCETYPE)dimensionWithBlock:(CGFloat (^)(UIView *relativeView))block {
    return [[[self alloc] initWithBlock:block] autorelease];
}

- (ZUX_INSTANCETYPE)init {
    if (self = [super init]) _block = nil;
    return self;
}

- (ZUX_INSTANCETYPE)initWithBlock:(CGFloat (^)(UIView *relativeView))block {
    if (self = [super init]) _block = Block_copy(block);
    return self;
}

- (void)dealloc {
    if (_block) Block_release(_block);
    [super dealloc];
}

@end

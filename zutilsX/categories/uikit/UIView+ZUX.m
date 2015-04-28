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

NSString *const zLayoutDimensionsDictionaryKey  = @"ZLayoutDimensionsDictionaryKey";
NSString *const zLayoutKVOContext               = @"ZLayoutKVOContext";

NSString *const zLeftMargin                     = @"ZLeftMargin";
NSString *const zWidth                          = @"ZWidth";
NSString *const zRightMargin                    = @"ZRightMargin";

NSString *const zTopMargin                      = @"ZTopMargin";
NSString *const zHeight                         = @"ZHeight";
NSString *const zBottomMargin                   = @"ZBottomMargin";

@implementation UIView (ZUXAutoLayout)

+ (void)load {
    [super load];
    [self swizzleOriSelector:@selector(willMoveToSuperview:)
             withNewSelector:@selector(zuxWillMoveToSuperview:)];
    [self swizzleOriSelector:@selector(dealloc)
             withNewSelector:@selector(zuxDealloc)];
}

- (ZUX_INSTANCETYPE)initWithAutolayoutDimensionDictionary:(NSDictionary *)dimensions {
    [self init];
    
    [self setZLayoutDimensionsDictionary:dimensions];
    
    [self.superview addObserver:self forKeyPath:@"frame"
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                        context:zLayoutKVOContext];
    [self.superview addObserver:self forKeyPath:@"bounds"
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                        context:zLayoutKVOContext];
    
    return self;
}

- (void)zuxWillMoveToSuperview:(UIView *)newSuperview {
    [self zuxWillMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:@"frame"
                           context:zLayoutKVOContext];
    [self.superview removeObserver:self forKeyPath:@"bounds"
                           context:zLayoutKVOContext];
    
    [newSuperview addObserver:self forKeyPath:@"frame"
                      options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                      context:zLayoutKVOContext];
    [newSuperview addObserver:self forKeyPath:@"bounds"
                      options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                      context:zLayoutKVOContext];
}

- (void)zuxDealloc {
    [self setZLayoutDimensionsDictionary:nil];
    
    [self.superview removeObserver:self forKeyPath:@"frame"
                           context:zLayoutKVOContext];
    [self.superview removeObserver:self forKeyPath:@"bounds"
                           context:zLayoutKVOContext];
    
    [self zuxDealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (![zLayoutKVOContext isEqual:context]) [super observeValueForKeyPath:keyPath ofObject:object
                                                                     change:change context:context];
    
    NSDictionary *dimensions = objc_getAssociatedObject(self, zLayoutDimensionsDictionaryKey);
    if (!self.superview || !dimensions || dimensions.count < 4) return;
    
    if (([self.superview isEqual:object] && [@[@"frame", @"bounds"] containsObject:keyPath]) ||
        ([dimensions isEqual:object] && [@[@"zLeftMargin", @"zWidth", @"zRightMargin", @"zTopMargin", @"zHeight", @"zBottomMargin"] containsObject:keyPath])) {
        self.frame = rectRelativeFromViewByDimensionsDictionary(self.superview, dimensions);
    }
}

- (NSMutableDictionary *)zLayoutDimensionsDictionary {
    if (!objc_getAssociatedObject(self, zLayoutDimensionsDictionaryKey)) {
        [self setZLayoutDimensionsDictionary:@{}];
    }
    return objc_getAssociatedObject(self, zLayoutDimensionsDictionaryKey);
}

- (void)setZLayoutDimensionsDictionary:(NSDictionary *)newDimensions {
    NSDictionary *oriDimensions = objc_getAssociatedObject(self, zLayoutDimensionsDictionaryKey);
    [oriDimensions removeObserver:self forKeyPath:@"zLeftMargin"
                          context:zLayoutKVOContext];
    [oriDimensions removeObserver:self forKeyPath:@"zWidth"
                          context:zLayoutKVOContext];
    [oriDimensions removeObserver:self forKeyPath:@"zRightMargin"
                          context:zLayoutKVOContext];
    [oriDimensions removeObserver:self forKeyPath:@"zTopMargin"
                          context:zLayoutKVOContext];
    [oriDimensions removeObserver:self forKeyPath:@"zHeight"
                          context:zLayoutKVOContext];
    [oriDimensions removeObserver:self forKeyPath:@"zBottomMargin"
                          context:zLayoutKVOContext];
    
    if (!newDimensions) return;
    
    NSMutableDictionary *mutableDimensions = [NSMutableDictionary dictionaryWithDictionary:newDimensions];
    objc_setAssociatedObject(self, zLayoutDimensionsDictionaryKey, mutableDimensions,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [mutableDimensions addObserver:self forKeyPath:@"zLeftMargin"
                           options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                           context:zLayoutKVOContext];
    [mutableDimensions addObserver:self forKeyPath:@"zWidth"
                           options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                           context:zLayoutKVOContext];
    [mutableDimensions addObserver:self forKeyPath:@"zRightMargin"
                           options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                           context:zLayoutKVOContext];
    [mutableDimensions addObserver:self forKeyPath:@"zTopMargin"
                           options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                           context:zLayoutKVOContext];
    [mutableDimensions addObserver:self forKeyPath:@"zHeight"
                           options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                           context:zLayoutKVOContext];
    [mutableDimensions addObserver:self forKeyPath:@"zBottomMargin"
                           options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                           context:zLayoutKVOContext];
}

- (id)zLeftMargin {
    return [[self zLayoutDimensionsDictionary] objectForKey:zLeftMargin];
}

- (void)setZLeftMargin:(id)zLeftMarginValue {
    [[self zLayoutDimensionsDictionary] setObject:zLeftMarginValue forKey:zLeftMargin];
}

- (id)zWidth {
    return [[self zLayoutDimensionsDictionary] objectForKey:zWidth];
}

- (void)setZWidth:(id)zWidthValue {
    [[self zLayoutDimensionsDictionary] setObject:zWidthValue forKey:zWidth];
}

- (id)zRightMargin {
    return [[self zLayoutDimensionsDictionary] objectForKey:zRightMargin];
}

- (void)setZRightMargin:(id)zRightMarginValue {
    [[self zLayoutDimensionsDictionary] setObject:zRightMarginValue forKey:zRightMargin];
}

- (id)zTopMargin {
    return [[self zLayoutDimensionsDictionary] objectForKey:zTopMargin];
}

- (void)setZTopMargin:(id)zTopMarginValue {
    [[self zLayoutDimensionsDictionary] setObject:zTopMarginValue forKey:zTopMargin];
}

- (id)zHeight {
    return [[self zLayoutDimensionsDictionary] objectForKey:zHeight];
}

- (void)setZHeight:(id)zHeightValue {
    [[self zLayoutDimensionsDictionary] setObject:zHeightValue forKey:zHeight];
}

- (id)zBottomMargin {
    return [[self zLayoutDimensionsDictionary] objectForKey:zBottomMargin];
}

- (void)setZBottomMargin:(id)zBottomMarginValue {
    [[self zLayoutDimensionsDictionary] setObject:zBottomMarginValue forKey:zBottomMargin];
}

#pragma mark - autolayout implement Methods.

CGFloat dimensionValue(UIView *superview, id dimension) {
    if ([dimension isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)dimension cgfloatValue];
    } else if ([dimension isKindOfClass:[ZUXDimension class]]) {
        ZUXDimensionBlock block = [(ZUXDimension *)dimension block];
        return block && superview ? block(superview) : 0;
    }
    return 0;
}

void calculateOriginAndSize(UIView *superview, CGFloat relativeSize,
                            id dimensionSize, id dimensionMargin1, id dimensionMargin2,
                            CGFloat *resultOrigin, CGFloat *resultSize) {
    CGFloat sizeValue = dimensionValue(superview, dimensionSize);
    CGFloat marginValue1 = dimensionValue(superview, dimensionMargin1);
    CGFloat marginValue2 = dimensionValue(superview, dimensionMargin2);
    *resultSize = dimensionSize ? sizeValue : relativeSize - marginValue1 - marginValue2;
    
    if (!dimensionMargin1) marginValue1 = relativeSize - sizeValue - marginValue2;
    if (!dimensionMargin2) marginValue2 = relativeSize - sizeValue - marginValue1;
    *resultOrigin = (relativeSize - *resultSize) * marginValue1 / (marginValue1 + marginValue2);
}

CGRect rectRelativeFromViewByDimensionsDictionary(UIView *superview, NSDictionary *dimensions) {
    NSDictionary *xDimensions = [dimensions subDictionaryForKeys:@[zLeftMargin, zWidth, zRightMargin]];
    NSDictionary *yDimensions = [dimensions subDictionaryForKeys:@[zTopMargin, zHeight, zBottomMargin]];
    NSCParameterAssert(xDimensions.count > 1 && yDimensions.count > 1);
    
    CGRect result = CGRectZero;
    calculateOriginAndSize(superview, superview.bounds.size.width,
                           xDimensions[zWidth], xDimensions[zLeftMargin], xDimensions[zRightMargin],
                           &result.origin.x, &result.size.width);
    calculateOriginAndSize(superview, superview.bounds.size.height,
                           yDimensions[zHeight], yDimensions[zTopMargin], yDimensions[zBottomMargin],
                           &result.origin.y, &result.size.height);
    return result;
}

#pragma mark -

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

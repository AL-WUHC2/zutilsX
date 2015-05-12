//
//  UIControl+ZUX.m
//  zutilsX
//
//  Created by Char Aznable on 15-5-11.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "UIControl+ZUX.h"
#import "NSObject+ZUX.h"
#import "NSNumber+ZUX.h"
#import "NSDictionary+ZUX.h"
#import "UIView+ZUX.h"
#import "zconstant.h"
#import <objc/runtime.h>

@implementation UIControl (ZUX)

#pragma mark - Border Width With UIControlState Methods.

- (void)setBorderWidth:(CGFloat)width forState:(UIControlState)state {
    if(state == UIControlStateNormal) self.borderWidth = width;
    [self zBorderWidths][[self keyForState:state]] = [NSNumber numberWithCGFloat:width];
}

- (CGFloat)borderWidthForState:(UIControlState)state {
    return [[[self zBorderWidths] valueForKey:[self keyForState:state]
                                 defaultValue:[[self zBorderWidths] valueForKey:
                                               [self keyForState:UIControlStateNormal]]]
            cgfloatValue];
}

#pragma mark - Border Color With UIControlState Methods.

- (void)setBorderColor:(UIColor *)color forState:(UIControlState)state {
    if(state == UIControlStateNormal) self.borderColor = color;
    [self zBorderColors][[self keyForState:state]] = color;
}

- (UIColor *)borderColorForState:(UIControlState)state {
    return [[self zBorderColors] valueForKey:[self keyForState:state]
                                defaultValue:[[self zBorderColors] valueForKey:
                                              [self keyForState:UIControlStateNormal]]];
}

#pragma mark - Shadow Color With UIControlState Methods.

- (void)setShadowColor:(UIColor *)color forState:(UIControlState)state {
    if(state == UIControlStateNormal) self.shadowColor = color;
    [self zShadowColors][[self keyForState:state]] = color;
}

- (UIColor *)shadowColorForState:(UIControlState)state {
    return [[self zShadowColors] valueForKey:[self keyForState:state]
                                defaultValue:[[self zShadowColors] valueForKey:
                                              [self keyForState:UIControlStateNormal]]];
}

#pragma mark - Shadow Opacity With UIControlState Methods.

- (void)setShadowOpacity:(float)opacity forState:(UIControlState)state {
    if(state == UIControlStateNormal) self.shadowOpacity = opacity;
    [self zShadowOpacities][[self keyForState:state]] = [NSNumber numberWithFloat:opacity];
}

- (float)shadowOpacityForState:(UIControlState)state {
    return [[[self zShadowOpacities] valueForKey:[self keyForState:state]
                                    defaultValue:[[self zShadowOpacities] valueForKey:
                                                  [self keyForState:UIControlStateNormal]]]
            floatValue];
}

#pragma mark - Shadow Offset With UIControlState Methods.

- (void)setShadowOffset:(CGSize)offset forState:(UIControlState)state {
    if(state == UIControlStateNormal) self.shadowOffset = offset;
    [self zShadowOffsets][[self keyForState:state]] = [NSValue valueWithCGSize:offset];
}

- (CGSize)shadowOffsetForState:(UIControlState)state {
    return [[[self zShadowOffsets] valueForKey:[self keyForState:state]
                                  defaultValue:[[self zShadowOffsets] valueForKey:
                                                [self keyForState:UIControlStateNormal]]]
            CGSizeValue];
}

#pragma mark - Shadow Size With UIControlState Methods.

- (void)setShadowSize:(CGFloat)size forState:(UIControlState)state {
    if(state == UIControlStateNormal) self.shadowSize = size;
    [self zShadowSizes][[self keyForState:state]] = [NSNumber numberWithCGFloat:size];
}

- (CGFloat)shadowSizeForState:(UIControlState)state {
    return [[[self zShadowSizes] valueForKey:[self keyForState:state]
                                defaultValue:[[self zShadowSizes] valueForKey:
                                              [self keyForState:UIControlStateNormal]]]
            cgfloatValue];
}

#pragma mark - Swizzle Methods.
   
+ (void)load {
    [super load];
    // init
    [self swizzleOriSelector:@selector(init)
             withNewSelector:@selector(zuxInit)];
#if !IS_ARC
    // dealloc
    [self swizzleOriSelector:@selector(dealloc)
             withNewSelector:@selector(zuxDealloc)];
#endif
    // state
    [self swizzleOriSelector:@selector(setHighlighted:)
             withNewSelector:@selector(zuxSetHighlighted:)];
    [self swizzleOriSelector:@selector(setSelected:)
             withNewSelector:@selector(zuxSetSelected:)];
    [self swizzleOriSelector:@selector(setEnabled:)
             withNewSelector:@selector(zuxSetEnabled:)];
}

- (ZUX_INSTANCETYPE)zuxInit {
    [self p_SetPropertyWithValue:[NSMutableDictionary dictionary] forAssociateKey:zBorderWidthsKey];
    [self p_SetPropertyWithValue:[NSMutableDictionary dictionary] forAssociateKey:zBorderColorsKey];
    
    [self p_SetPropertyWithValue:[NSMutableDictionary dictionary] forAssociateKey:zShadowColorsKey];
    [self p_SetPropertyWithValue:[NSMutableDictionary dictionary] forAssociateKey:zShadowOpacitiesKey];
    [self p_SetPropertyWithValue:[NSMutableDictionary dictionary] forAssociateKey:zShadowOffsetsKey];
    [self p_SetPropertyWithValue:[NSMutableDictionary dictionary] forAssociateKey:zShadowSizesKey];
    
    return [self zuxInit];
}

- (void)zuxDealloc {
    [self p_SetPropertyWithValue:[NSMutableDictionary dictionary] forAssociateKey:nil];
    [self p_SetPropertyWithValue:[NSMutableDictionary dictionary] forAssociateKey:nil];
    
    [self p_SetPropertyWithValue:[NSMutableDictionary dictionary] forAssociateKey:nil];
    [self p_SetPropertyWithValue:[NSMutableDictionary dictionary] forAssociateKey:nil];
    [self p_SetPropertyWithValue:[NSMutableDictionary dictionary] forAssociateKey:nil];
    [self p_SetPropertyWithValue:[NSMutableDictionary dictionary] forAssociateKey:nil];
    
    [self zuxDealloc];
}

- (void)zuxSetHighlighted:(BOOL)highlighted {
    [self zuxSetHighlighted:highlighted];
    UIControlState state = highlighted ? UIControlStateHighlighted : [self isSelected] ? UIControlStateSelected : UIControlStateNormal;
    
    self.borderWidth    = [self borderWidthForState:state];
    self.borderColor    = [self borderColorForState:state];
    
    self.shadowColor    = [self shadowColorForState:state];
    self.shadowOpacity  = [self shadowOpacityForState:state];
    self.shadowOffset   = [self shadowOffsetForState:state];
    self.shadowSize     = [self shadowSizeForState:state];
}

- (void)zuxSetSelected:(BOOL)selected {
    [self zuxSetSelected:selected];
    UIControlState state = selected ? UIControlStateSelected : UIControlStateNormal;
    
    self.borderWidth    = [self borderWidthForState:state];
    self.borderColor    = [self borderColorForState:state];
    
    self.shadowColor    = [self shadowColorForState:state];
    self.shadowOpacity  = [self shadowOpacityForState:state];
    self.shadowOffset   = [self shadowOffsetForState:state];
    self.shadowSize     = [self shadowSizeForState:state];
}

- (void)zuxSetEnabled:(BOOL)enabled {
    [self zuxSetEnabled:enabled];
    UIControlState state = enabled ? UIControlStateNormal : UIControlStateDisabled;
    
    self.borderWidth    = [self borderWidthForState:state];
    self.borderColor    = [self borderColorForState:state];
    
    self.shadowColor    = [self shadowColorForState:state];
    self.shadowOpacity  = [self shadowOpacityForState:state];
    self.shadowOffset   = [self shadowOffsetForState:state];
    self.shadowSize     = [self shadowSizeForState:state];
}

#pragma mark - Associated Value Methods.

NSString *const zBorderWidthsKey    = @"zBorderWidths";
NSString *const zBorderColorsKey    = @"zBorderColors";

NSString *const zShadowColorsKey    = @"zShadowColors";
NSString *const zShadowOpacitiesKey = @"zShadowOpacities";
NSString *const zShadowOffsetsKey   = @"zShadowOffsets";
NSString *const zShadowSizesKey     = @"zShadowSizes";

- (NSMutableDictionary *)zBorderWidths {
    return [self p_PropertyForAssociateKey:zBorderWidthsKey];
}

- (NSMutableDictionary *)zBorderColors {
    return [self p_PropertyForAssociateKey:zBorderColorsKey];
}

- (NSMutableDictionary *)zShadowColors {
    return [self p_PropertyForAssociateKey:zShadowColorsKey];
}

- (NSMutableDictionary *)zShadowOpacities {
    return [self p_PropertyForAssociateKey:zShadowOpacitiesKey];
}

- (NSMutableDictionary *)zShadowOffsets {
    return [self p_PropertyForAssociateKey:zShadowOffsetsKey];
}

- (NSMutableDictionary *)zShadowSizes {
    return [self p_PropertyForAssociateKey:zShadowSizesKey];
}

#pragma mark - Private Methods.

- (NSString *)keyForState:(UIControlState)state {
    return [NSString stringWithFormat:@"%d", (unsigned int)state];
}

- (id)p_PropertyForAssociateKey:(NSString *)key {
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}

- (void)p_SetPropertyWithValue:(id)value forAssociateKey:(NSString *)key {
    id originalValue = objc_getAssociatedObject(self, (__bridge const void *)(key));
    if ([value isEqual:originalValue]) return;
    
    objc_setAssociatedObject(self, (__bridge const void *)(key), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

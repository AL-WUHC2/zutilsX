//
//  NSNull+ZUX.m
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "NSNull+ZUX.h"

@implementation NSNull (ZUX)

+ (BOOL)isNull:(id)obj {
    return obj == nil || [obj isEqual:[self null]];
}

+ (BOOL)isNotNull:(id)obj {
    return obj != nil && ![obj isEqual:[self null]];
}

@end

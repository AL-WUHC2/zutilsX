//
//  NSArray+ZUX.m
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "NSArray+ZUX.h"
#import "NSNull+ZUX.h"

@implementation NSArray (ZUX)

- (NSMutableArray *)deepMutableCopy {
    return (NSMutableArray *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFArrayRef)self, kCFPropertyListMutableContainers);
}

- (id)objectAtIndex:(NSUInteger)index defaultValue:(id)defaultValue {
    return index >= [self count] || [NSNull isNull:[self objectAtIndex:index]] ? defaultValue : [self objectAtIndex:index];
}

@end

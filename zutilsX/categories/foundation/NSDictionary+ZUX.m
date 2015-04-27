//
//  NSDictionary+ZUX.m
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "NSDictionary+ZUX.h"
#import "NSNull+ZUX.h"

@implementation NSDictionary (ZUX)

- (NSMutableDictionary *)deepMutableCopy {
    return (NSMutableDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFDictionaryRef)self, kCFPropertyListMutableContainers);
}

- (id)valueForKey:(NSString *)key defaultValue:(id)defaultValue {
    return [NSNull isNull:[self valueForKey:key]] ? defaultValue : [self valueForKey:key];
}

- (NSDictionary *)subDictionaryForKeys:(NSArray *)keys {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([keys containsObject:key]) [dict setValue:obj forKey:key];
    }];
    return [[dict copy] autorelease];
}

@end

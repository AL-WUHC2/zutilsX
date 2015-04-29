//
//  NSDictionary+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ZUX)

- (NSDictionary *)deepCopy NS_RETURNS_RETAINED;

- (NSMutableDictionary *)deepMutableCopy NS_RETURNS_RETAINED;

- (id)valueForKey:(NSString *)key defaultValue:(id)defaultValue;

- (NSDictionary *)subDictionaryForKeys:(NSArray *)keys;

@end

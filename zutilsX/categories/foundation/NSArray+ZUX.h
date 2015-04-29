//
//  NSArray+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ZUX)

- (NSArray *)deepCopy NS_RETURNS_RETAINED;

- (NSMutableArray *)deepMutableCopy NS_RETURNS_RETAINED;

- (id)objectAtIndex:(NSUInteger)index defaultValue:(id)defaultValue;

@end

//
//  NSString+ZUX.m
//  zutilsX
//
//  Created by Char Aznable on 15-4-30.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "NSString+ZUX.h"

@implementation NSString (ZUX)

#pragma mark - Empty Methods.

- (BOOL)isEmpty {
    return [self length] == 0;
}

- (BOOL)isNotEmpty {
    return [self length] != 0;
}

#pragma mark - Equal Methods.

- (BOOL)isCaseInsensitiveEqual:(id)object {
    if (object == nil) return NO;
    return NSOrderedSame == [self compare:[object description] options:NSCaseInsensitiveSearch];
}

- (BOOL)isCaseInsensitiveEqualToString:(NSString *)aString {
    return NSOrderedSame == [self compare:aString options:NSCaseInsensitiveSearch];
}

#pragma mark - Index Methods.

- (NSUInteger)indexOfString:(NSString *)aString {
    return [self rangeOfString:aString].location;
}

- (NSUInteger)indexCaseInsensitiveOfString:(NSString *)aString {
    return [self rangeOfString:aString options:NSCaseInsensitiveSearch].location;
}

- (NSUInteger)indexOfString:(NSString *)aString fromIndex:(NSUInteger)startPos {
    return [[self substringFromIndex:startPos] rangeOfString:aString].location;
}

- (NSUInteger)indexCaseInsensitiveOfString:(NSString *)aString fromIndex:(NSUInteger)startPos {
    return [[self substringFromIndex:startPos] rangeOfString:aString options:NSCaseInsensitiveSearch].location;
}

@end

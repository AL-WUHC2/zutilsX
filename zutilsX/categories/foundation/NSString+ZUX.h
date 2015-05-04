//
//  NSString+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-4-30.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZUX)

- (BOOL)isEmpty;

- (BOOL)isNotEmpty;

- (BOOL)isCaseInsensitiveEqual:(id)object;

- (BOOL)isCaseInsensitiveEqualToString:(NSString *)aString;

- (NSUInteger)indexOfString:(NSString *)aString;

- (NSUInteger)indexCaseInsensitiveOfString:(NSString *)aString;

- (NSUInteger)indexOfString:(NSString *)aString fromIndex:(NSUInteger)startPos;

- (NSUInteger)indexCaseInsensitiveOfString:(NSString *)aString fromIndex:(NSUInteger)startPos;

@end

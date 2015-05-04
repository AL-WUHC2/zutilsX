//
//  NSString+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-4-30.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zconstant.h"

@interface NSString (ZUX)

- (BOOL)isEmpty;

- (BOOL)isNotEmpty;

- (NSString *)trim;

- (NSString *)trimToNil;

- (BOOL)isCaseInsensitiveEqual:(id)object;

- (BOOL)isCaseInsensitiveEqualToString:(NSString *)aString;

- (NSComparisonResult)compareToVersionString:(NSString *)version;

- (NSUInteger)indexOfString:(NSString *)aString;

- (NSUInteger)indexCaseInsensitiveOfString:(NSString *)aString;

- (NSUInteger)indexOfString:(NSString *)aString fromIndex:(NSUInteger)startPos;

- (NSUInteger)indexCaseInsensitiveOfString:(NSString *)aString fromIndex:(NSUInteger)startPos;

+ (ZUX_INSTANCETYPE)stringWithArray:(NSArray *)array;

+ (ZUX_INSTANCETYPE)stringWithArray:(NSArray *)array separator:(NSString *)separatorString;

- (NSString *)appendWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

- (NSString *)stringByEscapingForURLQuery;

- (NSString *)stringByUnescapingFromURLQuery;

- (NSString *)MD5Sum;

- (NSString *)SHA1Sum;

- (NSString *)base64EncodedString;

+ (NSString *)stringWithBase64String:(NSString *)base64String;

+ (NSString *)replaceUnicodeToUTF8:(NSString *)aUnicodeString;

+ (NSString *)replaceUTF8ToUnicode:(NSString *)aUTF8String;

- (NSString *)parametricStringWithObject:(id)object;

@end

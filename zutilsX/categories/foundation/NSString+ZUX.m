//
//  NSString+ZUX.m
//  zutilsX
//
//  Created by Char Aznable on 15-4-30.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "NSString+ZUX.h"
#import "NSData+ZUX.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (ZUX)

#pragma mark - Empty Methods.

- (BOOL)isEmpty {
    return [self length] == 0;
}

- (BOOL)isNotEmpty {
    return [self length] != 0;
}

#pragma Trim Methods.

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimToNil {
    NSString *str = [self trim];
    return [str isEmpty] ? nil : str;
}

#pragma mark - Compare Methods.

- (BOOL)isCaseInsensitiveEqual:(id)object {
    if (object == nil) return NO;
    return NSOrderedSame == [self compare:[object description] options:NSCaseInsensitiveSearch];
}

- (BOOL)isCaseInsensitiveEqualToString:(NSString *)aString {
    return NSOrderedSame == [self compare:aString options:NSCaseInsensitiveSearch];
}

- (NSComparisonResult)compareToVersionString:(NSString *)version {
    // Break version into fields (separated by '.')
    NSMutableArray *leftFields  = [NSMutableArray arrayWithArray:[self  componentsSeparatedByString:@"."]];
    NSMutableArray *rightFields = [NSMutableArray arrayWithArray:[version componentsSeparatedByString:@"."]];
    
    // Implict ".0" in case version doesn't have the same number of '.'
    if ([leftFields count] < [rightFields count]) {
        while ([leftFields count] != [rightFields count]) {
            [leftFields addObject:@"0"];
        }
    } else if ([leftFields count] > [rightFields count]) {
        while ([leftFields count] != [rightFields count]) {
            [rightFields addObject:@"0"];
        }
    }
    
    // Do a numeric comparison on each field
    for (NSUInteger i = 0; i < [leftFields count]; i++) {
        NSComparisonResult result = [[leftFields objectAtIndex:i] compare:[rightFields objectAtIndex:i] options:NSNumericSearch];
        if (result != NSOrderedSame) {
            return result;
        }
    }
    
    return NSOrderedSame;
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

#pragma mark - Contain Methods.

- (BOOL)containsString:(NSString *)aString {
    return [self indexOfString:aString] != NSNotFound;
}

- (BOOL)containsCaseInsensitiveString:(NSString *)aString {
    return [self indexCaseInsensitiveOfString:aString] != NSNotFound;
}

#pragma mark - Split Methods.

- (NSArray *)arrayBySplitsWithString:(NSString *)separatorString {
    return [self componentsSeparatedByString:separatorString];
}

#pragma mark - Append Methods.

+ (ZUX_INSTANCETYPE)stringWithArray:(NSArray *)array {
    return [self stringWithArray:array separator:@""];
}

+ (ZUX_INSTANCETYPE)stringWithArray:(NSArray *)array separator:(NSString *)separatorString {
    if (!array) return @"";
    
    NSMutableString *result = [[[NSMutableString alloc] init] autorelease];
    for (int i = 0; i < [array count]; i++) {
        [result appendString:[[array objectAtIndex:i] description]];
        if (i + 1 < [array count]) [result appendString:separatorString];
    }
    return [[result copy] autorelease];
}

- (NSString *)appendWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION {
    NSMutableArray *temp = [[[NSMutableArray alloc] initWithObjects:self, nil] autorelease];
    
    if (firstObj) {
        id arg = firstObj;
        va_list argvs;
        
        va_start(argvs, firstObj);
        do {
            [temp addObject:arg];
        } while ((arg = va_arg(argvs, id)));
        va_end(argvs);
    }
    
    return [NSString stringWithArray:temp];
}

#pragma mark - Replace Methods.

- (NSString *)stringByReplacingString:(NSString *)searchString withString:(NSString *)replacement {
    return [self stringByReplacingOccurrencesOfString:searchString withString:replacement
                                              options:0 range:NSMakeRange(0, self.length)];
}

- (NSString *)stringByCaseInsensitiveReplacingString:(NSString *)searchString withString:(NSString *)replacement {
    return [self stringByReplacingOccurrencesOfString:searchString withString:replacement
                                              options:NSCaseInsensitiveSearch range:NSMakeRange(0, self.length)];
}

#pragma mark - Escape/Unescape Methods.

- (NSString *)stringByEscapingForURLQuery {
    static CFStringRef toEscape = CFSTR(":/=,!$&'()*+;[]@#?% ");
    return [(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                (__bridge CFStringRef)self,
                                                                NULL,
                                                                toEscape,
                                                                kCFStringEncodingUTF8) autorelease];
}


- (NSString *)stringByUnescapingFromURLQuery {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - Encode/Decode Methods.

- (NSString *)MD5Sum {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5(cstr, (unsigned int)strlen(cstr), digest);
    NSMutableString *ms = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", digest[i]];
    }
    return [[ms copy] autorelease];
}

- (NSString *)SHA1Sum {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
    CC_SHA1(cstr, (unsigned int)strlen(cstr), digest);
    NSMutableString *ms = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", digest[i]];
    }
    return [[ms copy] autorelease];
}

- (NSString *)base64EncodedString  {
    if ([self length] == 0) {
        return nil;
    }
    
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}

+ (NSString *)stringWithBase64String:(NSString *)base64String {
    return [[[NSString alloc] initWithData:[NSData dataWithBase64String:base64String]
                                  encoding:NSUTF8StringEncoding] autorelease];
}

+ (NSString *)replaceUnicodeToUTF8:(NSString *)aUnicodeString {
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

+ (NSString *)replaceUTF8ToUnicode:(NSString *)aUTF8String {
    NSUInteger length = [aUTF8String length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0; i < length; i++) {
        unichar _char = [aUTF8String characterAtIndex:i];
        
        //判断是否为英文和数字
        if (_char <= '9' && _char >= '0') {
            [s appendFormat:@"%@",[aUTF8String substringWithRange:NSMakeRange(i, 1)]];
        } else if (_char >= 'a' && _char <= 'z') {
            [s appendFormat:@"%@",[aUTF8String substringWithRange:NSMakeRange(i, 1)]];
        } else if (_char >= 'A' && _char <= 'Z') {
            [s appendFormat:@"%@",[aUTF8String substringWithRange:NSMakeRange(i, 1)]];
        } else {
            [s appendFormat:@"\\u%x",[aUTF8String characterAtIndex:i]];
        }
    }
    return s;
}

#pragma mark - Parametric builder.

- (NSString *)parametricStringWithObject:(id)object {
    NSMutableString *result = [[[NSMutableString alloc] init] autorelease];
    NSUInteger start = 0, end = [self indexOfString:@"${" fromIndex:start];
    while (end != NSNotFound) {
        [result appendString:[self substringWithRange:NSMakeRange(start, end)]];
        start += end + 2;
        end = [self indexOfString:@"}" fromIndex:start];
        if (end == NSNotFound) break;
        NSString *value = [object valueForKey:[self substringWithRange:NSMakeRange(start, end)]];
        [result appendString:value?:@""];
        start += end + 1;
        end = [self indexOfString:@"${" fromIndex:start];
    }
    if (start < [self length])
        [result appendString:[self substringWithRange:NSMakeRange(start, [self length])]];
    return [[result copy] autorelease];
}

@end

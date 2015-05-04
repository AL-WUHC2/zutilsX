//
//  NSExpression+ZUX.m
//  zutilsX
//
//  Created by Char Aznable on 15-4-30.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "NSExpression+ZUX.h"
#import "NSString+ZUX.h"

@implementation NSExpression (ZUX)

+ (NSArray *)keywordsArrayInExpressionFormat {
    return @[@"AND", @"OR", @"IN", @"NOT", @"ALL", @"ANY", @"SOME", @"NONE", @"LIKE", @"CASEINSENSITIVE", @"CI", @"MATCHES", @"CONTAINS", @"BEGINSWITH", @"ENDSWITH", @"BETWEEN", @"NULL", @"NIL", @"SELF", @"TRUE", @"YES", @"FALSE", @"NO", @"FIRST", @"LAST", @"SIZE", @"ANYKEY", @"SUBQUERY", @"CAST", @"TRUEPREDICATE", @"FALSEPREDICATE"];
}

NSString *const zParametricPrefix   = @"${";
NSString *const zParametricSuffix   = @"}";
NSString *const zKeyPathPlaceholder = @"%K";

+ (NSExpression *)expressionWithParametricFormat:(NSString *)parametricFormat {
    NSMutableString *expressionFormat = [NSMutableString string];
    NSMutableArray *arguments = [NSMutableArray array];
    NSUInteger start = 0, end = [parametricFormat indexOfString:zParametricPrefix fromIndex:start];
    while (end != NSNotFound) {
        [expressionFormat appendString:[parametricFormat substringWithRange:NSMakeRange(start, end)]];
        start += end + 2;
        end = [parametricFormat indexOfString:zParametricSuffix fromIndex:start];
        if (end == NSNotFound) break;
        [arguments addObject:[parametricFormat substringWithRange:NSMakeRange(start, end)]];
        [expressionFormat appendString:zKeyPathPlaceholder];
        start += end + 1;
        end = [parametricFormat indexOfString:zParametricPrefix fromIndex:start];
    }
    if (start < [parametricFormat length])
        [expressionFormat appendString:[parametricFormat substringFromIndex:start]];
    
    return [self expressionWithFormat:expressionFormat argumentArray:arguments];
}

@end

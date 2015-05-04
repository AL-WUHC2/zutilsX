//
//  NSExpression+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-4-30.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSExpression (ZUX)

/*
 * NSExpression keywords Array. Use in ExpressionFormat with prefix: # .
 */
+ (NSArray *)keywordsArrayInExpressionFormat;

/*
 * Expression that format parametric keyPath with %K.
 * For example:
 * parametricFormat - @"...${keyPath}..."
 * result           - [NSExpression expressionWithFormat:@"...%K...", @"keyPath"]
 */
+ (NSExpression *)expressionWithParametricFormat:(NSString *)parametricFormat;

@end

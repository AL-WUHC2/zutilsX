//
//  NSCoder+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-15.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSCoder (ZUX)

- (void)encodeCGFloat:(CGFloat)realv forKey:(NSString *)key;

- (CGFloat)decodeCGFloatForKey:(NSString *)key;

@end

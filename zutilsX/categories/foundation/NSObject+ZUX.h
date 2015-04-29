//
//  NSObject+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZUX)

+ (void)swizzleOriSelector:(SEL)oriSelector withNewSelector:(SEL)newSelector;

@end

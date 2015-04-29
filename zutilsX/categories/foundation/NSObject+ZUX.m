//
//  NSObject+ZUX.m
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "NSObject+ZUX.h"
#import <objc/runtime.h>

@implementation NSObject (ZUX)

+ (void)swizzleOriSelector:(SEL)oriSelector withNewSelector:(SEL)newSelector {
    Class clazz = [self class];
    Method oriMethod = class_getInstanceMethod(clazz, oriSelector);
    Method newMethod = class_getInstanceMethod(clazz, newSelector);
    
    if(class_addMethod(clazz, oriSelector,
                       method_getImplementation(newMethod),
                       method_getTypeEncoding(newMethod))) {
        class_replaceMethod(clazz, newSelector,
                            method_getImplementation(oriMethod),
                            method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

@end

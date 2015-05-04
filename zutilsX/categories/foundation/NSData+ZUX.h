//
//  NSData+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ZUX)

- (NSString *)base64EncodedString;

+ (NSData *)dataWithBase64String:(NSString *)base64String;

@end

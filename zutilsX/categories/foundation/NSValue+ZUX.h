//
//  NSValue+ZUX.h
//  zutilsX
//
//  Created by Char Aznable on 15-4-30.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSValue (ZUX)

- (id)valueForKey:(NSString *)key;

- (id)valueForKeyPath:(NSString *)keyPath;

@end

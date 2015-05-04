//
//  UILabel+ZUX.m
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "UILabel+ZUX.h"

@implementation UILabel (ZUX)

- (CGSize)sizeThatConstraintToSize:(CGSize)size {
    return [self.text sizeWithFont:self.font
                 constrainedToSize:size
                     lineBreakMode:self.lineBreakMode];
}

@end

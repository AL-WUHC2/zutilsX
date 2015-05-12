//
//  ZUXControl.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zconstant.h"

extern float ZUXMinOperationInterval;

@interface ZUXControl : UIControl

@property (nonatomic, ZUX_STRONG) UIImage *backgroundImage;

- (void)zuxInitial;

@end

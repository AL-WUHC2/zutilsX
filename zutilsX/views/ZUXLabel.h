//
//  ZUXLabel.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZUXLabel : UILabel

@property (nonatomic, retain) UIImage *backgroundImage;

@property (nonatomic, assign) CGFloat linesSpacing;

- (void)zuxInitial;

@end
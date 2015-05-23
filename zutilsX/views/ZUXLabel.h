//
//  ZUXLabel.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zconstant.h"

@protocol ZUXLabelDataSource;

// ZUXLabel
@interface ZUXLabel : UILabel

@property (nonatomic, ZUX_WEAK) id<ZUXLabelDataSource> dataSource;

@property (nonatomic, assign, getter=canCopy) BOOL canCopy;

@property (nonatomic, ZUX_STRONG) UIImage *backgroundImage;

@property (nonatomic, assign) CGFloat linesSpacing;

- (void)zuxInitial;

@end

// ZUXLabelDataSource
@protocol ZUXLabelDataSource <NSObject>

@optional

- (CGPoint)menuLocationInLabel:(ZUXLabel *)view;

@end

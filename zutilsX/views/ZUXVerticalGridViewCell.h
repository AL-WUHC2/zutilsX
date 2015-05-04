//
//  ZUXVerticalGridViewCell.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXView.h"
#import "zconstant.h"

@interface ZUXVerticalGridViewCell : ZUXView

@property (assign, nonatomic, getter=isSelected) BOOL selected;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end

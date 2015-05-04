//
//  ZUXVerticalGridView.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUXVerticalGridViewCell.h"

@class ZUXVerticalGridView;

// DataSource
@protocol ZUXVerticalGridViewDataSource <NSObject>

@required

- (NSUInteger)numberOfCellsInGridView:(ZUXVerticalGridView *)view;

- (ZUXVerticalGridViewCell *)gridView:(ZUXVerticalGridView *)view cellForIndex:(NSUInteger)index;

- (NSUInteger)gridView:(ZUXVerticalGridView *)view widthUnitForIndex:(NSUInteger)index;

@end

// Delegate
@protocol ZUXVerticalGridViewDelegate <NSObject, UIScrollViewDelegate>

@optional

- (void)gridView:(ZUXVerticalGridView *)view willSelectCellAtIndex:(NSUInteger)index;

- (void)gridView:(ZUXVerticalGridView *)view didSelectCellAtIndex:(NSUInteger)index;

- (void)gridView:(ZUXVerticalGridView *)view willDeselectCellAtIndex:(NSUInteger)index;

- (void)gridView:(ZUXVerticalGridView *)view didDeselectCellAtIndex:(NSUInteger)index;

@end

@interface ZUXVerticalGridView : UIScrollView

@property (assign, nonatomic) id<ZUXVerticalGridViewDataSource> dataSource;

@property (assign, nonatomic) id<ZUXVerticalGridViewDelegate> delegate;

@property (assign, nonatomic) NSUInteger rowCount;

@property (assign, nonatomic) NSUInteger columnCount;

- (void)zuxInitial;

- (ZUXVerticalGridViewCell *)cellForIndex:(NSUInteger)index;

- (NSUInteger)indexForCell:(ZUXVerticalGridViewCell *)cell;

- (void)selectCellAtIndex:(NSUInteger)index animated:(BOOL)animated;

- (void)deselectCellAtIndex:(NSUInteger)index animated:(BOOL)animated;

- (void)reload;

@end

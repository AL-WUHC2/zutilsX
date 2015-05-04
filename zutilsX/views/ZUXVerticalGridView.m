//
//  ZUXVerticalGridView.m
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXVerticalGridView.h"
#import "ZUXVerticalGridViewCell.h"
#import "ZUXVerticalGridViewCellInternal.h"
#import "zconstant.h"
#import "NSArray+ZUX.h"
#import "UIView+ZUX.h"

@interface ZUXVerticalGridView () {
    NSMutableArray *_gridCells;
}

@end

@implementation ZUXVerticalGridView

- (ZUX_INSTANCETYPE)init {
    if (self = [super init]) [self zuxInitial];
    return self;
}

- (ZUX_INSTANCETYPE)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) [self zuxInitial];
    return self;
}

- (ZUX_INSTANCETYPE)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) [self zuxInitial];
    return self;
}

- (void)zuxInitial {
    _gridCells = [[NSMutableArray alloc] init];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_gridCells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(ZUXVerticalGridViewCell *)obj removeFromSuperview];
    }];
    [_gridCells removeAllObjects];
    
    if ([_dataSource respondsToSelector:@selector(numberOfCellsInGridView:)] &&
        [_dataSource respondsToSelector:@selector(gridView:cellForIndex:)] &&
        [_dataSource respondsToSelector:@selector(gridView:widthUnitForIndex:)] &&
        _rowCount > 0 && _columnCount > 0) {
        
        CGFloat width = self.bounds.size.width, height = self.bounds.size.height;
        CGFloat gridWidth = width / _columnCount, gridHeight = height / _rowCount;
        CGFloat x = 0, y = 0;
        NSUInteger cellsCount = [_dataSource numberOfCellsInGridView:self];
        for (int index = 0; index < cellsCount; index++) {
            ZUXVerticalGridViewCell *cell = [_dataSource gridView:self cellForIndex:index];
            NSUInteger cellWidthUnit = [_dataSource gridView:self widthUnitForIndex:index];
            
            CGFloat cellWidth = cellWidthUnit * gridWidth;
            if (x + cellWidth > width && x > 0) { x = 0; y += gridHeight; }
            cell.zTransforms = @{zLeftMargin : @(x), zTopMargin : @(y), zWidth : @(cellWidth),
                                 zHeight : @(gridHeight)};
            x += cellWidth;
            
            cell.index = index;
            cell.gridView = self;
            [_gridCells addObject:cell];
            [self addSubview:cell];
        }
        
        self.contentSize = CGSizeMake(width, y + gridHeight);
    }
}

- (void)dealloc {
    _dataSource = nil;
    
    [_gridCells removeAllObjects];
    [_gridCells release];
    
    [super dealloc];
}

#pragma mark - Accessing Cells.

- (ZUXVerticalGridViewCell *)cellForIndex:(NSUInteger)index {
    return [_gridCells objectAtIndex:index defaultValue:nil];
}


- (NSUInteger)indexForCell:(ZUXVerticalGridViewCell *)cell {
    return cell.index;
}

#pragma mark - Managing Selections.

- (void)selectCellAtIndex:(NSUInteger)index animated:(BOOL)animated {
    if ([self.delegate respondsToSelector:@selector(gridView:willSelectCellAtIndex:)]) {
        [self.delegate gridView:self willSelectCellAtIndex:index];
    }
    
    [[self cellForIndex:index] setSelected:YES animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(gridView:didSelectCellAtIndex:)]) {
        [self.delegate gridView:self didSelectCellAtIndex:index];
    }
}


- (void)deselectCellAtIndex:(NSUInteger)index animated:(BOOL)animated {
    if ([self.delegate respondsToSelector:@selector(gridView:willDeselectCellAtIndex:)]) {
        [self.delegate gridView:self willDeselectCellAtIndex:index];
    }
    
    [[self cellForIndex:index] setSelected:NO animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(gridView:didDeselectCellAtIndex:)]) {
        [self.delegate gridView:self didDeselectCellAtIndex:index];
    }
}

#pragma mark - Reloading.

- (void)reload {
    [self setNeedsLayout];
}

@end

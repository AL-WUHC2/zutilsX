//
//  ViewController.m
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ViewController.h"
#import "zutilsX.h"

@interface ViewController () <ZUXVerticalGridViewDataSource, ZUXVerticalGridViewDelegate> {
    NSArray *colorArray;
    NSArray *widthArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    colorArray = [@[[UIColor blackColor], [UIColor whiteColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor yellowColor]] retain];
    widthArray = [@[@2, @2, @1, @2, @1, @3] retain];
    
    ZUXVerticalGridView *grid = [[ZUXVerticalGridView alloc] init];
    grid.frame = self.view.bounds;
    grid.dataSource = self;
    grid.delegate = self;
    grid.rowCount = 3;
    grid.columnCount = 4;
    [self.view addSubview:grid];
    [grid release];
}

- (void)dealloc {
    [colorArray release];
    [widthArray release];
    [super dealloc];
}

#pragma mark - ZUXVerticalGridViewDataSource

- (NSUInteger)numberOfCellsInGridView:(ZUXVerticalGridView *)view {
    return [colorArray count];
}

- (ZUXVerticalGridViewCell *)gridView:(ZUXVerticalGridView *)view cellForIndex:(NSUInteger)index {
    ZUXVerticalGridViewCell *cell = [[[ZUXVerticalGridViewCell alloc] init] autorelease];
    cell.backgroundColor = colorArray[index];
    return cell;
}

- (NSUInteger)gridView:(ZUXVerticalGridView *)view widthUnitForIndex:(NSUInteger)index {
    return [widthArray[index] unsignedIntegerValue];
}

#pragma mark - ZUXVerticalGridViewDelegate

- (void)gridView:(ZUXVerticalGridView *)view didSelectCellAtIndex:(NSUInteger)index {
    NSLog(@"SELECT %@", colorArray[index]);
}

- (void)gridView:(ZUXVerticalGridView *)view didDeselectCellAtIndex:(NSUInteger)index {
    NSLog(@"DESELECT %@", colorArray[index]);
}

@end

//
//  ZUXRefreshView.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXView.h"

typedef NS_ENUM(NSInteger, ZUXRefreshState) {
    ZUXRefreshNormal,
    ZUXRefreshPulling,
    ZUXRefreshLoading,
};

typedef NS_ENUM(NSInteger, ZUXRefreshPullDirection) {
    ZUXRefreshPullDown,
    ZUXRefreshPullUp,
    ZUXRefreshPullRight,
    ZUXRefreshPullLeft,
};

@class ZUXRefreshView;

// Delegate
@protocol ZUXRefreshViewDelegate <NSObject>

@optional

- (BOOL)refreshViewIsLoading:(ZUXRefreshView *)view;

- (void)refreshViewStartLoad:(ZUXRefreshView *)view;

@end

// ZUXRefreshView
@interface ZUXRefreshView : ZUXView

@property (nonatomic, assign) id<ZUXRefreshViewDelegate> delegate;

@property (nonatomic, assign) ZUXRefreshState state;

@property (nonatomic, assign) ZUXRefreshPullDirection direction;

@property (nonatomic, assign) CGFloat defaultPadding;

@property (nonatomic, assign) CGFloat pullingMargin;

@property (nonatomic, assign) CGFloat loadingMargin;

- (void)didScrollView:(UIScrollView *)scrollView;

- (void)didEndDragging:(UIScrollView *)scrollView;

- (void)didFinishedLoading:(UIScrollView *)scrollView;

- (void)setRefreshState:(ZUXRefreshState)state;

@end

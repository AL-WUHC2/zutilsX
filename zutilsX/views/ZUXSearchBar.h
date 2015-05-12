//
//  ZUXSearchBar.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-12.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXView.h"
#import "zconstant.h"

@protocol ZUXSearchBarDelegate;

// ZUXSearchBar
@interface ZUXSearchBar : ZUXView

@property (nonatomic, ZUX_WEAK) id<ZUXSearchBarDelegate> delegate;

@property (nonatomic, copy) UIColor *maskBackgroundColor; // default [UIColor clearColor]

@property (nonatomic, ZUX_STRONG) UITextField *searchTextField;

@property (nonatomic, copy) NSString *searchText;

@end

// ZUXSearchBarDelegate
@protocol ZUXSearchBarDelegate <NSObject>

@optional

- (void)searchBarDidBeginInput:(ZUXSearchBar *)bar;

- (void)searchBarDidEndInput:(ZUXSearchBar *)bar;

- (void)searchBar:(ZUXSearchBar *)bar searchWithText:(NSString *)searchText editEnded:(BOOL)ended;

@end

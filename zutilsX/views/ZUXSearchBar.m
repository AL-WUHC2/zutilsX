//
//  ZUXSearchBar.m
//  zutilsX
//
//  Created by Char Aznable on 15-5-12.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXSearchBar.h"
#import "ZUXControl.h"
#import "UIView+ZUX.h"

CGSize searchBarTextFieldDefaultSize = {300, 30};

@interface ZUXSearchBar () <UITextFieldDelegate> {
    ZUXControl *_mask;
}

@end

@implementation ZUXSearchBar

@dynamic maskBackgroundColor;

@dynamic searchText;

- (void)zuxInitial {
    [super zuxInitial];
    self.backgroundColor = [UIColor lightGrayColor];
    
    _searchTextField = [[UITextField alloc] initWithFrame:
                        CGRectMake(0, 0, searchBarTextFieldDefaultSize.width,
                                   searchBarTextFieldDefaultSize.height)];
    _searchTextField.font = [UIFont systemFontOfSize:searchBarTextFieldDefaultSize.height / 2];
    _searchTextField.textColor = [UIColor blackColor];
    [_searchTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _searchTextField.placeholder = @"请输入搜索内容";
    _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTextField.returnKeyType = UIReturnKeySearch;
    _searchTextField.delegate = self;
    [self addSubview:_searchTextField];
    
    _mask = [[ZUXControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_mask addTarget:self action:@selector(maskTouched:)
    forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(searchTextFieldTextDidChange:)
     name:UITextFieldTextDidChangeNotification object:_searchTextField];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([self isEqual:_searchTextField.superview]) {
        _searchTextField.center = CGPointMake(self.bounds.size.width / 2,
                                              self.bounds.size.height / 2);
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]
     removeObserver:self name:UITextFieldTextDidChangeNotification
     object:_searchTextField];
    _delegate = nil;
    
    ZUX_RELEASE(_searchTextField);
    ZUX_RELEASE(_mask);
    ZUX_SUPER_DEALLOC;
}

- (void)setSearchTextField:(UITextField *)searchTextField {
    if ([_searchTextField isEqual:searchTextField]) return;
    
    [_searchTextField.superview addSubview:searchTextField];
    [_searchTextField removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self name:UITextFieldTextDidChangeNotification
     object:_searchTextField];
    ZUX_RELEASE(_searchTextField);
    _searchTextField = ZUX_RETAIN(searchTextField);
    _searchTextField.delegate = self;
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(searchTextFieldTextDidChange:)
     name:UITextFieldTextDidChangeNotification object:_searchTextField];
}

- (UIColor *)maskBackgroundColor {
    return _mask.backgroundColor;
}

- (void)setMaskBackgroundColor:(UIColor *)maskBackgroundColor {
    _mask.backgroundColor = maskBackgroundColor;
}

- (NSString *)searchText {
    return _searchTextField.text;
}

- (void)setSearchText:(NSString *)searchText {
    _searchTextField.text = searchText;
}

#pragma mark - User Event

- (void)maskTouched:(id)sender {
    if (![sender isEqual:_mask]) return;
    
    [_searchTextField resignFirstResponder];
    [self addSubview:_searchTextField];
    _searchTextField.center = [_mask convertPoint:_searchTextField.center toView:self];
    [_mask zuxAnimate:ZUXAnimationMake(ZUXAnimateOut|ZUXAnimateFade, ZUXAnimateNone, 0.1, 0)
           completion:^{ [_mask removeFromSuperview]; }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [[UIApplication sharedApplication].keyWindow addSubview:_mask];
    [_mask addSubview:_searchTextField];
    _searchTextField.center = [self convertPoint:_searchTextField.center toView:_mask];
    
    if (![_delegate respondsToSelector:@selector(searchBarDidBeginInput:)]) return;
    [_delegate searchBarDidBeginInput:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (![_delegate respondsToSelector:@selector(searchBarDidEndInput:)]) return;
    [_delegate searchBarDidEndInput:self];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (![_delegate respondsToSelector:@selector(searchBar:searchWithText:editEnded:)]) return YES;
    
    if ([string isEqualToString:@"\n"]) {
        [_delegate searchBar:self searchWithText:_searchTextField.text editEnded:YES];
        [self maskTouched:_searchTextField.superview];
        return NO;
    }
    return YES;
}

#pragma mark - UITextFieldTextDidChangeNotification

- (void)searchTextFieldTextDidChange:(NSNotification *)notification {
    UITextField *textField = (UITextField *)notification.object;
    if (textField.markedTextRange) return;
    if (![_delegate respondsToSelector:@selector(searchBar:searchWithText:editEnded:)]) return;
    [_delegate searchBar:self searchWithText:textField.text editEnded:NO];
}

@end

//
//  ZUXRefreshView.m
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXRefreshView.h"

@implementation ZUXRefreshView

- (void)zuxInitial {
    [super zuxInitial];
    self.state = ZUXRefreshNormal;
    self.direction = ZUXRefreshPullDown;
    self.defaultPadding = 0;
    self.pullingMargin = 60;
    self.loadingMargin = 66;
}

- (void)dealloc {
    _delegate = nil;
    ZUX_SUPER_DEALLOC;
}

- (void)setState:(ZUXRefreshState)state {
    [self setRefreshState:state];
    _state = state;
}

- (void)setRefreshState:(ZUXRefreshState)state {
    // default do NOTHING, overrides
}

- (void)didScrollView:(UIScrollView *)scrollView {
    if (_state == ZUXRefreshLoading) {
        [self p_UpdateInsetsWhenLoadingInScrollView:scrollView];
        
    } else if (scrollView.isDragging) {
        BOOL _loading = NO;
        if ([_delegate respondsToSelector:@selector(refreshViewIsLoading:)]) {
            _loading = [_delegate refreshViewIsLoading:self];
        }
        
        CGFloat pullingOffset = [self p_PullingOffsetInScrollView:scrollView];
        if (_state == ZUXRefreshPulling && !_loading && pullingOffset < _pullingMargin && pullingOffset > 0) {
            self.state = ZUXRefreshNormal;
        } else if (_state == ZUXRefreshNormal && !_loading && pullingOffset >= _pullingMargin) {
            self.state = ZUXRefreshPulling;
        }
        
        [self p_ResetInsetsInScrollView:scrollView];
    }
}

- (void)didEndDragging:(UIScrollView *)scrollView {
    BOOL _loading = NO;
    if ([_delegate respondsToSelector:@selector(refreshViewIsLoading:)]) {
        _loading = [_delegate refreshViewIsLoading:self];
    }
    
    CGFloat pullingOffset = [self p_PullingOffsetInScrollView:scrollView];
    if (pullingOffset >= _pullingMargin && !_loading) {
        if ([_delegate respondsToSelector:@selector(refreshViewStartLoad:)]) {
            [_delegate refreshViewStartLoad:self];
        }
        
        self.state = ZUXRefreshLoading;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [self p_UpdateInsetsWhenLoadingInScrollView:scrollView];
        [UIView commitAnimations];
    }
}

- (void)didFinishedLoading:(UIScrollView *)scrollView {
    self.state = ZUXRefreshNormal;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self p_ResetInsetsInScrollView:scrollView];
    [UIView commitAnimations];
}

#pragma mark - Private Methods

- (CGFloat)p_PullingOffsetInScrollView:(UIScrollView *)scrollView {
    switch (_direction) {
        case ZUXRefreshPullDown: return -scrollView.contentOffset.y-_defaultPadding;
        case ZUXRefreshPullUp: return scrollView.contentOffset.y+scrollView.frame.size.height
            -MAX(scrollView.contentSize.height+scrollView.contentInset.top+_defaultPadding,
                 scrollView.frame.size.height)
            +scrollView.contentInset.top-_defaultPadding;
        case ZUXRefreshPullRight: return -scrollView.contentOffset.x-_defaultPadding;
        case ZUXRefreshPullLeft: return scrollView.contentOffset.x+scrollView.frame.size.width
            -MAX(scrollView.contentSize.width+scrollView.contentInset.left+_defaultPadding,
                 scrollView.frame.size.width)
            +scrollView.contentInset.left-_defaultPadding;
        default: return 0;
    }
}

- (void)p_UpdateInsetsWhenLoadingInScrollView:(UIScrollView *)scrollView {
    CGFloat offset = MIN(_loadingMargin, MAX([self p_PullingOffsetInScrollView:scrollView], 0));
    UIEdgeInsets insets = scrollView.contentInset;
    CGFloat blank = 0;
    switch (_direction) {
        case ZUXRefreshPullDown:
            insets.top = _defaultPadding + offset;
            break;
        case ZUXRefreshPullUp:
            blank = MAX(scrollView.frame.size.height-scrollView.contentSize.height, 0);
            insets.bottom = _defaultPadding + offset + blank;
            break;
        case ZUXRefreshPullRight:
            insets.left = _defaultPadding + offset;
            break;
        case ZUXRefreshPullLeft:
            blank = MAX(scrollView.frame.size.width-scrollView.contentSize.width, 0);
            insets.right = _defaultPadding + offset + blank;
            break;
        default: break;
    }
    scrollView.contentInset = insets;
}

- (void)p_ResetInsetsInScrollView:(UIScrollView *)scrollView {
    UIEdgeInsets insets = scrollView.contentInset;
    switch (_direction) {
        case ZUXRefreshPullDown:
            if (insets.top != _defaultPadding) {
                insets.top = _defaultPadding;
                scrollView.contentInset = insets;
            }
            break;
        case ZUXRefreshPullUp:
            if (insets.bottom != _defaultPadding) {
                insets.bottom = _defaultPadding;
                scrollView.contentInset = insets;
            }
            break;
        case ZUXRefreshPullRight:
            if (insets.left != _defaultPadding) {
                insets.left = _defaultPadding;
                scrollView.contentInset = insets;
            }
            break;
        case ZUXRefreshPullLeft:
            if (insets.right != _defaultPadding) {
                insets.right = _defaultPadding;
                scrollView.contentInset = insets;
            }
            break;
        default: return;
    }
}

@end

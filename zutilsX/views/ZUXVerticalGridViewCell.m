//
//  ZUXVerticalGridViewCell.m
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXVerticalGridViewCell.h"
#import "ZUXVerticalGridView.h"
#import "ZUXVerticalGridViewCellInternal.h"

@implementation ZUXVerticalGridViewCell

- (void)dealloc {
    _gridView = nil;
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    _selected = selected;
    
    void (^changes)(void) = ^{
        for (UIView *view in [self subviews]) {
            if ([view respondsToSelector:@selector(setSelected:)]) {
                [(UIControl *)view setSelected:_selected];
            }
        }
    };
    
    if (animated) {
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                         animations:changes completion:nil];
    } else {
        changes();
    }
}

- (void)setSelected:(BOOL)selected {
    [self setSelected:selected animated:YES];
}

#pragma mark - Touch Responder.

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(self.bounds, [[touches anyObject] locationInView:self])) {
        if (self.isSelected) {
            [self.gridView deselectCellAtIndex:self.index animated:YES];
        } else {
            self.userInteractionEnabled = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),
                           dispatch_get_main_queue(), ^{ self.userInteractionEnabled = YES; });
            [self.gridView selectCellAtIndex:self.index animated:YES];
        }
    }
}

@end

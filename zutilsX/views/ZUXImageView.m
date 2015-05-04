//
//  ZUXImageView.m
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXImageView.h"

@implementation ZUXImageView

- (id)init {
    if (self = [super init]) [self zuxInitial];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) [self zuxInitial];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) [self zuxInitial];
    return self;
}

- (id)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) [self zuxInitial];
    return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    if (self = [super initWithImage:image highlightedImage:highlightedImage]) [self zuxInitial];
    return self;
}

- (void)dealloc {
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    _delegate = nil;
    [super dealloc];
}

- (void)zuxInitial {
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[[UILongPressGestureRecognizer alloc]
                                 initWithTarget:self action:@selector(longPress:)] autorelease]];
}

- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer  {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [gestureRecognizer.view becomeFirstResponder];
        
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        menuController.menuItems = @[[[[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(zuxCopy:)] autorelease],
                                     [[[UIMenuItem alloc] initWithTitle:@"保存" action:@selector(zuxSave:)] autorelease]];
        
        if ([_delegate respondsToSelector:@selector(menuLocationInImageView:)]) {
            [menuController setTargetRect:[_delegate menuLocationInImageView:self]
                                   inView:gestureRecognizer.view];
        } else {
            CGPoint location = [gestureRecognizer locationInView:gestureRecognizer.view];
            [menuController setTargetRect:CGRectMake(location.x, location.y, 0, 0)
                                   inView:gestureRecognizer.view];
        }
        [menuController setMenuVisible:YES animated:YES];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return ((_canCopy && action == @selector(zuxCopy:)) ||
            (_canSave && action == @selector(zuxSave:)));
}

- (void)zuxCopy:(id)sender {
    if (!self.image) return;
    [UIPasteboard generalPasteboard].image = self.image;
}

- (void)zuxSave:(id)sender {
    if (!self.image) return;
    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error && [_delegate respondsToSelector:@selector(saveImageFailedInImageView:withError:)]) {
        [_delegate saveImageFailedInImageView:self withError:error];
    } else if ([_delegate respondsToSelector:@selector(saveImageSuccessInImageView:)]) {
        [_delegate saveImageSuccessInImageView:self];
    }
}

@end

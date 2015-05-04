//
//  ZUXImageView.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZUXImageView;

@protocol ZUXImageViewDelegate <NSObject>

@optional

- (CGRect)menuLocationInImageView:(ZUXImageView *)view;

- (void)saveImageSuccessInImageView:(ZUXImageView *)view;

- (void)saveImageFailedInImageView:(ZUXImageView *)view withError:(NSError *)error;

@end

@interface ZUXImageView : UIImageView

@property (nonatomic, assign) id<ZUXImageViewDelegate> delegate;

@property (nonatomic, assign, getter=canCopy) BOOL canCopy;

@property (nonatomic, assign, getter=canSave) BOOL canSave;

- (void)zuxInitial;

@end

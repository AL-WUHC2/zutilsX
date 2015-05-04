//
//  UIView+MBProgressHUD.h
//  msgo
//
//  Created by Char Aznable on 15-4-21.
//  Copyright (c) 2015年 com.ai. All rights reserved.
//

#import "MBProgressHUD.h"

/**
 * MBProgressHUD for CURRENT view.
 */
@interface UIView (MBProgressHUD)

@property (MB_STRONG) UIFont* hudLabelFont;

@property (MB_STRONG) UIFont* hudDetailsLabelFont;

/**
 * Finds the top-most HUD subview and returns it.
 * If there is no HUD subview, add one and returns it.
 * Created invisible HUD with:
 *   square:YES
 *   animationType:MBProgressHUDAnimationFade
 *   removeFromSuperViewOnHide:YES
 */
- (MBProgressHUD *)mbProgressHUD;

- (void)showIndeterminateHUDWithText:(NSString *)text;

- (void)showTextHUDWithText:(NSString *)text hideAfterDelay:(NSTimeInterval)delay;

- (void)showTextHUDWithText:(NSString *)text detailText:(NSString *)detailText hideAfterDelay:(NSTimeInterval)delay;

- (void)hideHUD:(BOOL)animated;

@end

/**
 * MBProgressHUD RECURSIVE in current view and its subviews.
 */
@interface UIView (RecursiveMBProgressHUD)

@property (MB_STRONG) UIFont* recursiveHudLabelFont;

@property (MB_STRONG) UIFont* recursiveHudDetailsLabelFont;

/**
 * Finds the top-most HUD subview RECURSIVE in subviews and returns it.
 * If there is no HUD subview, return nil.
 */
- (MBProgressHUD *)recursiveMBProgressHUD;

- (void)showIndeterminateRecursiveHUDWithText:(NSString *)text;

- (void)showTextRecursiveHUDWithText:(NSString *)text hideAfterDelay:(NSTimeInterval)delay;

- (void)showTextRecursiveHUDWithText:(NSString *)text detailText:(NSString *)detailText hideAfterDelay:(NSTimeInterval)delay;

- (void)hideRecursiveHUD:(BOOL)animated;

@end

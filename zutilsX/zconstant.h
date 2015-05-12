//
//  zconstant.h
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#ifndef zutilsX_zconstant_h
#define zutilsX_zconstant_h

#ifdef __cplusplus
# define ZUX_EXTERN        extern "C" __attribute__((visibility ("default")))
#else
# define ZUX_EXTERN            extern __attribute__((visibility ("default")))
#endif

#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
# define ZUX_INLINE        static inline
#elif defined(__cplusplus)
# define ZUX_INLINE        static inline
#elif defined(__GNUC__)
# define ZUX_INLINE        static __inline__
#else
# define ZUX_INLINE        static
#endif

#if __has_feature(objc_instancetype)
# define ZUX_INSTANCETYPE  instancetype
#else
# define ZUX_INSTANCETYPE  id
#endif

#define IS_ARC __has_feature(objc_arc)

#if IS_ARC
# define ZUX_STRONG strong
#else
# define ZUX_STRONG retain
#endif

#if __has_feature(objc_arc_weak)
# define ZUX_WEAK weak
#elif IS_ARC
# define ZUX_WEAK unsafe_unretained
#else
# define ZUX_WEAK assign
#endif

#if IS_ARC
# define ZUX_AUTORELEASE(exp) exp
#else
# define ZUX_AUTORELEASE(exp) [exp autorelease]
#endif

#if IS_ARC
# define ZUX_RELEASE(exp)
#else
# define ZUX_RELEASE(exp) [exp release]
#endif

#if IS_ARC
# define ZUX_RETAIN(exp) exp
#else
# define ZUX_RETAIN(exp) [exp retain]
#endif

#if IS_ARC
# define ZUX_SUPER_DEALLOC
#else
# define ZUX_SUPER_DEALLOC [super dealloc]
#endif

#if IS_ARC
# define ZUX_BLOCK_COPY(exp) exp
#else
# define ZUX_BLOCK_COPY(exp) _Block_copy(exp)
#endif

#if IS_ARC
# define ZUX_BLOCK_RELEASE(exp)
#else
# define ZUX_BLOCK_RELEASE(exp) _Block_release(exp)
#endif

#define IS_IPHONE4          ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE5          ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE6          ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE6P         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define DeviceScale         (IS_IPHONE6P ? 1.29375 : (IS_IPHONE6 ? 1.171875 : 1.0))

#define IOS6_OR_LATER       ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending)
#define IOS7_OR_LATER       ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define IOS8_OR_LATER       ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)

#define statusBarHeight     (IOS7_OR_LATER ? 20 : 0)
#define statusBarFix        (IOS7_OR_LATER ? 0 : 20)

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000

#define ZUXTextAlignmentLeft            NSTextAlignmentLeft
#define ZUXTextAlignmentCenter          NSTextAlignmentCenter
#define ZUXTextAlignmentRight           NSTextAlignmentRight

#define ZUXLineBreakByWordWrapping      NSLineBreakByWordWrapping
#define ZUXLineBreakByCharWrapping      NSLineBreakByCharWrapping
#define ZUXLineBreakByClipping          NSLineBreakByClipping
#define ZUXLineBreakByTruncatingHead    NSLineBreakByTruncatingHead
#define ZUXLineBreakByTruncatingTail    NSLineBreakByTruncatingTail
#define ZUXLineBreakByTruncatingMiddle  NSLineBreakByTruncatingMiddle

#define ZUXForegroundColorAttributeName NSForegroundColorAttributeName
#define ZUXFontAttributeName            NSFontAttributeName

#else

#define ZUXTextAlignmentLeft            UITextAlignmentLeft
#define ZUXTextAlignmentCenter          UITextAlignmentCenter
#define ZUXTextAlignmentRight           UITextAlignmentRight

#define ZUXLineBreakByWordWrapping      UILineBreakModeWordWrap
#define ZUXLineBreakByCharWrapping      UILineBreakModeCharacterWrap
#define ZUXLineBreakByClipping          UILineBreakModeClip
#define ZUXLineBreakByTruncatingHead    UILineBreakModeHeadTruncation
#define ZUXLineBreakByTruncatingTail    UILineBreakModeTailTruncation
#define ZUXLineBreakByTruncatingMiddle  UILineBreakModeMiddleTruncation

#define ZUXForegroundColorAttributeName UITextAttributeTextColor
#define ZUXFontAttributeName            UITextAttributeFont

#endif

#define appIdentifier       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define appVersion          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#endif

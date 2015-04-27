//
//  zconstant.h
//  zutilsX
//
//  Created by Char Aznable on 15-4-27.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#ifndef zutilsX_zconstant_h
#define zutilsX_zconstant_h

#ifndef ZUX_EXTERN
#ifdef __cplusplus
#define ZUX_EXTERN          extern "C" __attribute__((visibility ("default")))
#else
#define ZUX_EXTERN              extern __attribute__((visibility ("default")))
#endif
#endif

#ifndef ZUX_STATIC_INLINE
#define ZUX_STATIC_INLINE	static inline
#endif

#ifndef ZUX_INSTANCETYPE
#if __has_feature(objc_instancetype)
#define ZUX_INSTANCETYPE    instancetype
#else
#define ZUX_INSTANCETYPE    id
#endif
#endif

#endif

//
//  ZUXGeometry.h
//  zutilsX
//
//  Created by Char Aznable on 15-5-23.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#ifndef zutilsX_ZUXGeometry_h
#define zutilsX_ZUXGeometry_h

#import <CoreGraphics/CoreGraphics.h>
#import "zconstant.h"

ZUX_INLINE CGRect
ZUX_CGRectMake(CGPoint origin, CGSize size) {
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}

#endif

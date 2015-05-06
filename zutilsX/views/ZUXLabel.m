//
//  ZUXLabel.m
//  zutilsX
//
//  Created by Char Aznable on 15-5-4.
//  Copyright (c) 2015年 org.cuc.n3. All rights reserved.
//

#import "ZUXLabel.h"
#import "zconstant.h"
#import "UILabel+ZUX.h"
#import <CoreText/CoreText.h>

static inline CTTextAlignment CTTextAlignmentFromZUXLinesSpacingLabel(ZUXLabel *label) {
    switch (label.textAlignment) {
        case ZUXTextAlignmentLeft: return kCTLeftTextAlignment;
        case ZUXTextAlignmentCenter: return kCTCenterTextAlignment;
        case ZUXTextAlignmentRight: return kCTRightTextAlignment;
        default: return kCTNaturalTextAlignment;
    }
}

static inline NSDictionary * NSAttributedStringAttributesFromZUXLinesSpacingLabel(ZUXLabel *label) {
    NSMutableDictionary *mutableAttributes = [NSMutableDictionary dictionary];
    
    if ([NSMutableParagraphStyle class]) {
        mutableAttributes[(NSString *)kCTFontAttributeName] = label.font;
        mutableAttributes[(NSString *)kCTForegroundColorAttributeName] = label.textColor;
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = label.textAlignment;
        paragraphStyle.lineSpacing = label.linesSpacing;
        
        mutableAttributes[(NSString *)kCTParagraphStyleAttributeName] = paragraphStyle;
        [paragraphStyle release];
    } else {
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)label.font.fontName, label.font.pointSize, NULL);
        mutableAttributes[(NSString *)kCTFontAttributeName] = (__bridge id)font;
        CFRelease(font);
        
        mutableAttributes[(NSString *)kCTForegroundColorAttributeName] = (id)label.textColor.CGColor;
        
        CTTextAlignment alignment = CTTextAlignmentFromZUXLinesSpacingLabel(label);
        CGFloat lineSpacing = label.linesSpacing;
        
        CTParagraphStyleSetting paragraphStyles[] = {
            {.spec = kCTParagraphStyleSpecifierAlignment,
                .valueSize = sizeof(CTTextAlignment),
                .value = (const void *)&alignment},
            {.spec = kCTParagraphStyleSpecifierLineSpacing,
                .valueSize = sizeof(CGFloat),
                .value = (const void *)&lineSpacing}
        };
        CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(paragraphStyles, 2);
        mutableAttributes[(NSString *)kCTParagraphStyleAttributeName] = (__bridge id)paragraphStyle;
        CFRelease(paragraphStyle);
    }
    return [NSDictionary dictionaryWithDictionary:mutableAttributes];
}

@implementation ZUXLabel

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

- (void)dealloc {
    [_backgroundImage release];
    [super dealloc];
}

- (void)zuxInitial {
    self.backgroundColor = [UIColor clearColor];
    _linesSpacing = 0;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_backgroundImage) [_backgroundImage drawInRect:rect];
}

- (void)drawTextInRect:(CGRect)rect {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]
                                                initWithString:self.text?:@""
                                                attributes:NSAttributedStringAttributesFromZUXLinesSpacingLabel(self)];
    CTFramesetterRef fsRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    CTFrameRef frame = CTFramesetterCreateFrame(fsRef, CFRangeMake(0, 0), path, NULL);
    //翻转坐标系统（文本原来是倒的要翻转下）
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    //画出文本
    CTFrameDraw(frame, context);
    UIGraphicsPushContext(context);
    //释放
    CFRelease(frame);
    CFRelease(path);
    CFRelease(fsRef);
    
    [attributedStr release];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    [backgroundImage retain];
    [_backgroundImage release];
    _backgroundImage = backgroundImage;
    [self setNeedsDisplay];
}

- (void)setLinesSpacing:(CGFloat)linesSpacing {
    _linesSpacing = linesSpacing;
    [self setNeedsDisplay];
}

- (CGSize)sizeThatConstraintToSize:(CGSize)size {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]
                                                initWithString:self.text?:@""
                                                attributes:NSAttributedStringAttributesFromZUXLinesSpacingLabel(self)];
    CTFramesetterRef fsRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
    CTFrameRef frame = CTFramesetterCreateFrame(fsRef, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    CFRelease(fsRef);
    [attributedStr release];
    
    NSUInteger lineCount = [(NSArray *)CTFrameGetLines(frame) count];
    CFRelease(frame);
    CGSize originalSize = [super sizeThatConstraintToSize:size];
    originalSize.height += (MAX(1, lineCount) - 1) * _linesSpacing;
    return originalSize;
}
@end

//
//  UIChannelLabel.m
//  douban-fm
//
//  Created by vampirekiss on 12-10-24.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import "UIChannelLabel.h"

@implementation UIChannelLabel {
    
@private
    
    CATextLayer *_textLayer;
    
    UIFont *_font;
    
}

@synthesize verticalTextAlignment = _verticalTextAlignment;
@synthesize fontSize = _fontSize;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _textLayer = [CATextLayer layer];
        
        _textLayer.frame = self.bounds;
        
        _textLayer.contentsScale = [[UIScreen mainScreen] scale];
        
        _textLayer.rasterizationScale = [[UIScreen mainScreen] scale];
        
        _textLayer.shadowOpacity = 1.0f;
        
        _textLayer.shadowRadius = 1.0f;
        
        _textLayer.shadowColor = [[UIColor colorWithRed:64.f/255 green:61.f/255 blue:55.f/255 alpha:1.0f] CGColor];
        
        _textLayer.shadowOffset = CGSizeMake(2.5f, 2.5f);
        
        [self.layer addSublayer:_textLayer];
        
    }
    
    return self;
}

- (NSString *)text {
    
    return _textLayer.string;
    
}

- (void)setText:(NSString *)text {
    
    _textLayer.string = text;

}

- (UIFont *)font {
    
    return _font;
    
}

- (void)setFont:(UIFont *)font {
    
    CFStringRef fontNameRef = (__bridge_retained CFStringRef)font.fontName;
    
    CTFontRef fontRef = CTFontCreateWithName(fontNameRef, font.pointSize, NULL);
    _textLayer.font = fontRef;
    _textLayer.fontSize = font.pointSize;
    
    CFRelease(fontRef);
    CFRelease(fontNameRef);
    
    _font = font;
    _fontSize = font.pointSize;
    
    [self setNeedsDisplay];
    
}

- (CGFloat)fontSize {
    
    return _fontSize;

}

- (void)setFontSize:(CGFloat)fontSize {
    
    UIFont *font = [UIFont fontWithName:_font.fontName size:fontSize];
    
    [self setFont: font];
    
    [self setNeedsDisplay];
    
}

- (void)setTextAlignment:(UITextAlignment)textAlignment {
    
    NSString *alignMode = nil;
    
    switch (textAlignment) {
            
        case UITextAlignmentCenter:
            alignMode = kCAAlignmentCenter;
            break;
            
        case UITextAlignmentLeft:
            alignMode = kCAAlignmentLeft;
            break;
            
        case UITextAlignmentRight:
            alignMode = kCAAlignmentRight;
            break;
        
        default:
            break;
    }
    
    if (alignMode != nil) {
        _textLayer.alignmentMode = alignMode;
    }
    
    [super setTextAlignment:textAlignment];
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
    _textLayer.frame = self.bounds;
    
    [self setNeedsDisplay];
}


- (void)setVerticalTextAlignment:(AUITextVerticalAlignment)verticalTextAlignment {
    
    _verticalTextAlignment = verticalTextAlignment;
    
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
    
    CGSize stringSize = [self.text sizeWithFont:self.font
                              constrainedToSize:self.bounds.size
                                  lineBreakMode:self.lineBreakMode];
    
    CGRect newLayerFrame = self.layer.bounds;
    
    newLayerFrame.size.height = stringSize.height;
    
    switch (_verticalTextAlignment) {
            
        case AUITextVerticalAlignmentCenter:
            newLayerFrame.origin.y = (self.bounds.size.height - stringSize.height) / 2;
            break;
            
        case AUITextVerticalAlignmentTop:
            newLayerFrame.origin.y = 0;
            break;
            
        case AUITextVerticalAlignmentBottom:
            newLayerFrame.origin.y = (self.bounds.size.height - stringSize.height);
            break;
            
        default:
            break;
            
    }
    
    _textLayer.frame = newLayerFrame;
    
    [self setNeedsDisplay];
    
}
@end

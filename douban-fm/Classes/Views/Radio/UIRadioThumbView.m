//
//  UIRadioThumbView.m
//  douban-fm
//
//  Created by vampirekiss on 12-11-6.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import "UIRadioThumbView.h"

@interface UIRadioThumbView ()

- (void)setReflectImage;

@end


@implementation UIRadioThumbView {
    
@private
    
    UIImageView *_imageView;
    
    CALayer *_reflectLayer;
    
}

@synthesize image = _image;

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self addSubview:_imageView];
        
    }
    
    return self;
}


- (void)setImage:(UIImage *)image {
    
    [self setImage:image reflected:YES];
    
}

- (void)setImage:(UIImage *)image reflected:(BOOL)reflected {
  
    _image = image;
    
    _imageView.image = image;
    
    if (reflected) {
        [self setReflectImage];
    }

}

- (void)setReflectImage {
    
    
    if (!_reflectLayer) {
        
        _reflectLayer = [CALayer layer];
        
        CGRect frame = self.bounds;
        float offsetY = 7.f;
        frame.origin.y = frame.size.height - offsetY;
        frame.size.height = 30.f;
        
        _reflectLayer.frame = frame;
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        
        [gradientLayer setBounds:_reflectLayer.frame];
        
        [gradientLayer setPosition:CGPointMake(_reflectLayer.bounds.size.width / 2, _reflectLayer.bounds.size.height / 2)];
        
        [gradientLayer setStartPoint:CGPointMake(0.5, 0.0)];
        [gradientLayer setEndPoint:CGPointMake(0.5, 1.0)];
        
        [gradientLayer setColors:[NSArray arrayWithObjects:
                                  (id)[[UIColor clearColor] CGColor],
                                  (id)[[UIColor blackColor] CGColor], nil]];
        
        
        [_reflectLayer setMask:gradientLayer];
        
        [_reflectLayer setValue:[NSNumber numberWithFloat:180.f] forKeyPath:@"transform.rotation.x"];
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = [[UIColor blackColor]CGColor];
        layer.opacity = 0.5;
        layer.frame = _reflectLayer.bounds;
        [_reflectLayer addSublayer:layer];
        

        [self.layer addSublayer:_reflectLayer];
    }
    
    UIGraphicsBeginImageContext(self.frame.size);
    
    [_image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGRect rect = CGRectMake(0.f, scaledImage.size.height - _reflectLayer.frame.size.height,
                             self.bounds.size.width, 20.0f);
    
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([scaledImage CGImage], rect);
    
    _reflectLayer.contents = (__bridge id)imageRef;
    
    CGImageRelease(imageRef);

}


@end

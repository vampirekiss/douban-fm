//
//  UIRadioLikeButton.m
//  douban-fm
//
//  Created by vampirekiss on 12-11-15.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import "UIRadioLikeButton.h"


@implementation UIRadioLikeButton {
    
@private
    
    UIImageView *_likedImageView;
    
}

@synthesize isLiked = _isLiked;
@synthesize likedImage = _likedImage;

- (void)setLikedImage:(UIImage *)likedImage {

    _likedImage = likedImage;
    
    if (!_likedImageView) {
        
        _likedImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        self.clipsToBounds = YES;
        
        _likedImageView.layer.opacity = 0.f;
        
        [self addSubview:_likedImageView];
    }
    
    _likedImageView.image = likedImage;
    
}

- (void)setIsLiked:(BOOL)isLiked {
 
    _isLiked = isLiked;
    
    if (!_likedImage) {
        return;
    }
    

    if (isLiked) {
        
        _likedImageView.layer.opacity = 1.f;
        
        
    } else {
        
        [UIView animateWithDuration:1.f animations:^{
            
            _likedImageView.layer.opacity = 0.f;
            
        }];
        
    }
    
}




@end

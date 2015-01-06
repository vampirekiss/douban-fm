//
//  UIRadioLikeButton.h
//  douban-fm
//
//  Created by vampirekiss on 12-11-15.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIRadioLikeButton : UIButton


@property (nonatomic) BOOL isLiked;

@property (nonatomic, strong) UIImage *likedImage;


@end

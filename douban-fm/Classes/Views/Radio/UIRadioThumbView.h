//
//  UIRadioThumbView.h
//  douban-fm
//
//  Created by vampirekiss on 12-11-6.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

@interface UIRadioThumbView : UIView

@property (nonatomic, strong) UIImage * image;

- (void)setImage:(UIImage *)image reflected:(BOOL)reflected;

@end

//
//  UICustomBarButtonItem.h
//  douban-fm
//
//  Created by vampirekiss on 12-10-22.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICustomBarButtonItem : NSObject

#define kArrowLeft  0
#define kArrowRight 1

+ (void)initBarButtonBackground:(NSString *)image;

+ (UIBarButtonItem *)createBarButtonItemWithImage:(NSString *)image target:(id)target action:(SEL)action tag:(NSUInteger)tag;


@end

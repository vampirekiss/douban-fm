//
//  UICustomBarButtonItem.m
//  douban-fm
//
//  Created by vampirekiss on 12-10-22.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import "UICustomBarButtonItem.h"

@implementation UICustomBarButtonItem

+ (void)initBarButtonBackground:(NSString *)image {
    
    
    UIImage *buttonBG = [[UIImage imageNamed:image] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    [[UIBarButtonItem appearance] setBackgroundImage:buttonBG forState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    
}

+ (UIBarButtonItem *)createBarButtonItemWithImage:(NSString *)image target:(id)target action:(SEL)action tag:(NSUInteger)tag {
    
    UIBarButtonItem *buttonItem = nil;
    
    UIImage *backButtonImage = [UIImage imageNamed:image];
    
    CGRect frameimg = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    
    UIButton *button = [[UIButton alloc] initWithFrame:frameimg];
    
    [button setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setTag:tag];
    
    buttonItem =[[UIBarButtonItem alloc] initWithCustomView:button];

    return buttonItem;
}



@end
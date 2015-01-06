//
//  UIChannelLabel.h
//  douban-fm
//
//  Created by vampirekiss on 12-10-24.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

typedef enum {
    AUITextVerticalAlignmentCenter = 0,
    AUITextVerticalAlignmentTop = 1,
    AUITextVerticalAlignmentBottom = 2
} AUITextVerticalAlignment;

@interface UIChannelLabel : UILabel

@property (nonatomic) AUITextVerticalAlignment verticalTextAlignment;

@property (nonatomic) CGFloat fontSize;

@end

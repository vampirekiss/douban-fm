//
//  UIChannelPickerView.h
//  douban-fm
//
//  Created by lau string on 12-10-24.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIChannelLabel.h"

@protocol UIChannelPickerViewDelegate;
@protocol UIChannelPickerViewDataSource;

@interface UIChannelPickerView : UIView <UIScrollViewDelegate>

@property(strong, nonatomic) UIFont *itemFont;

@property(strong, nonatomic) UIFont *selectedItemFont;

@property(strong, nonatomic) UIColor *itemColor;

@property(strong, nonatomic) UIImage *splitImage;

@property(nonatomic) NSUInteger selectedIndex;

@property(nonatomic) UIEdgeInsets insets;

@property(weak, nonatomic) id <UIChannelPickerViewDelegate> delegate;

@property(weak, nonatomic) id <UIChannelPickerViewDataSource> dataSource;

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;

- (void)reloadData;

@end


@protocol UIChannelPickerViewDelegate <NSObject>

- (void)pickerViewDidSelectItem:(NSUInteger) index;

@end

@protocol UIChannelPickerViewDataSource <NSObject>

- (NSUInteger)pickerViewNumberOfPickItems;

- (NSString *)pickerViewTitleForPickItem:(NSUInteger) index;

@end
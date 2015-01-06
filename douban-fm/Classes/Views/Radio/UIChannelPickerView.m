//
//  UIChannelPickerView.m
//  douban-fm
//
//  Created by lau string on 12-10-24.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import "UIChannelPickerView.h"


#define kFadelength 80.0f

@interface UIChannelPickerView ()

- (void)setUp;

- (void)layoutTitleViews;

@end

@implementation UIChannelPickerView {
@private
    
    UIScrollView *_scrollView;
    
    NSInteger _itemCount;
    
    NSMutableArray *_titleViews;

}

@synthesize itemFont = _itemFont;

@synthesize selectedItemFont = _selectedItemFont;

@synthesize splitImage = _splitImage;

@synthesize itemColor = _itemColor;

@synthesize insets = _insets;

@synthesize selectedIndex = _selectedIndex;

@synthesize dataSource = _dataSource;

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
        
    if (self) {
        
        [self setUp];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.bounds, _insets)];
        _scrollView.clipsToBounds = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        
        [self addSubview:_scrollView];
        
        CAGradientLayer *fadeLayer = [CAGradientLayer layer];
        
        fadeLayer.startPoint = CGPointMake(0.0, CGRectGetMidY(self.frame));
        fadeLayer.endPoint = CGPointMake(1.0, CGRectGetMidY(self.frame));
        
        fadeLayer.bounds = self.bounds;
        fadeLayer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        fadeLayer.shouldRasterize = YES;
        fadeLayer.rasterizationScale = [UIScreen mainScreen].scale;
        
        NSObject *transparentColor = (NSObject *)[[UIColor clearColor] CGColor];
        NSObject *opaqueColor = (NSObject *)[[UIColor blackColor] CGColor];
        [fadeLayer setColors:[NSArray arrayWithObjects:transparentColor, opaqueColor, opaqueColor, transparentColor, nil]];
        
        CGFloat fadePoint = (CGFloat)kFadelength / self.frame.size.width;
        [fadeLayer setLocations: [NSArray arrayWithObjects:
                                  [NSNumber numberWithDouble: 0.0],
                                  [NSNumber numberWithDouble: fadePoint],
                                  [NSNumber numberWithDouble: 1 - fadePoint],
                                  [NSNumber numberWithDouble: 1.0],
                                  nil]];
        
        
        self.layer.mask = fadeLayer;
        self.clipsToBounds = YES;
    }
    
    return self;
    
}

- (void)setUp {
    
    _itemFont = [UIFont boldSystemFontOfSize:22];
    
    _selectedItemFont = [UIFont boldSystemFontOfSize:22];
    
    _itemColor = [UIColor whiteColor];
    
    _selectedIndex = 0;
    
    _insets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _itemCount = 0;
    
    _titleViews = [[NSMutableArray alloc] init];

}


- (void)setInsets:(UIEdgeInsets)insets {
    
    if (!UIEdgeInsetsEqualToEdgeInsets(_insets, insets)) {
        _insets = insets;
        _scrollView.frame = UIEdgeInsetsInsetRect(self.bounds, insets);
        [self reloadData];
        [_scrollView setNeedsDisplay];
    }
    
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    [self setSelectedIndex:selectedIndex animated:NO];
    
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated {
    
    CGFloat offsetX = selectedIndex * _scrollView.frame.size.width;
    
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:animated];
    
    _selectedIndex = selectedIndex;
    
    if ([_delegate respondsToSelector:@selector(pickerViewDidSelectItem:)]) {
        [_delegate pickerViewDidSelectItem:_selectedIndex ];
    }
    
}

- (void)reloadData {
    
    if ([_dataSource respondsToSelector:@selector(pickerViewNumberOfPickItems)]) {
        _itemCount = [_dataSource pickerViewNumberOfPickItems];
    }
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _itemCount, _scrollView.frame.size.height);

    [self layoutTitleViews];
}


- (void)layoutTitleViews {
    
    int index = 0;
    
    if ([_titleViews count] == 0) {
        
        for (; index < _itemCount; index++) {
            
            UIChannelLabel *label = [[UIChannelLabel alloc]
                                     initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
            
            
            [_titleViews addObject:label];
            [_scrollView addSubview:label];
        }
        
    }
    
    index = 0;
    
    for (UIChannelLabel *label in _titleViews) {
    
        if ([_dataSource respondsToSelector:@selector(pickerViewTitleForPickItem:)]) {
            label.text = [_dataSource pickerViewTitleForPickItem:index];
        }
        
        label.backgroundColor = [UIColor clearColor];
        label.textColor = _itemColor;
        
        CGRect frame = label.frame;
        frame.origin.x = _scrollView.frame.size.width * index;
        label.frame = frame;
        
        label.font = index == _selectedIndex ? _selectedItemFont : _itemFont;

        label.textAlignment = UITextAlignmentCenter;
        label.verticalTextAlignment = AUITextVerticalAlignmentBottom;
        
        index++;
        
    }
    
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if ([self pointInside:point withEvent:event]) {
        return _scrollView;
    }
    
    return [super hitTest:point withEvent:event];
    
}

#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    for (UIChannelLabel *label in _titleViews) {
        
        CGPoint position = label.layer.position;
        
        if (position.x >= scrollView.contentOffset.x) {
            
            if (position.x <= scrollView.contentOffset.x + scrollView.frame.size.width) {
                
                label.font = _selectedItemFont;
                
                continue;
                
            }
            
        }
        
        if (![label.font isEqual: _itemFont]) {
            
            label.font = _itemFont;
            
        }
        
    }

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int index = round(_scrollView.contentOffset.x / _scrollView.frame.size.width);
    
    if (_selectedIndex == index) {
        return;
    }
    
    [self setSelectedIndex:index];
}

@end

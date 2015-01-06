//
//  UIChannelTableViewCell.m
//  douban-fm
//
//  Created by vampirekiss on 12-10-27.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import "UIChannelTableViewCell.h"

@implementation UIChannelTableViewCell {
    
@private
    
    UIImageView *_selectedIcon;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:20.0];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    if (_selectedIcon == nil) {
        
        _selectedIcon = [[UIImageView alloc] initWithFrame:CGRectMake(280, (49 - 27) / 2, 20, 27)];
        _selectedIcon.image = [UIImage imageNamed:@"sel.png"];
        _selectedIcon.hidden = YES;
        
        [self.contentView addSubview:_selectedIcon];
    }
    
        
    _selectedIcon.hidden = !selected;
    
}

- (void)showSelectedState {
    
    
    if (_selectedIcon != nil) {
        _selectedIcon.hidden = NO;
    }
    
}

- (void)hideSelectedState {
    
    
    if (_selectedIcon != nil) {
        _selectedIcon.hidden = YES;
    }
    
}

@end

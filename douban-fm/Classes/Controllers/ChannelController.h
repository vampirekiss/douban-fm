//
//  ChannelController.h
//  douban-fm
//
//  Created by vampirekiss on 12-10-21.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIChannelTableViewCell.h"
#import "FmChannel.h"
#import "FmService.h"

@interface ChannelController : UITableViewController

@property(weak,readonly) NSMutableArray *channels;

@property(weak, nonatomic) UIViewController *radioController;

@property(nonatomic, readonly) NSInteger selectedChannelIndex;

@end

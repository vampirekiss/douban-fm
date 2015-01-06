//
//  AppDelegate.h
//  douban-fm
//
//  Created by vampirekiss on 12-10-21.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworkActivityIndicatorManager.h"

#import "ChannelController.h"
#import "RadioController.h"
#import "SettingController.h"
#import "UICustomBarButtonItem.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

- (void)navBarButtonClick:(id)sender;

@end

//
//  AppDelegate.m
//  douban-fm
//
//  Created by vampirekiss on 12-10-21.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate()

- (void)initControllers;

@end

@implementation AppDelegate {
@private
    RadioController *_radioController;
    ChannelController *_channelController;
    SettingController *_settingController;
}

- (void)initControllers {
    
    
    
    // init navigational controllers
    _radioController = [[RadioController alloc] init];
    _channelController = [[ChannelController alloc] init];
    _settingController = [[SettingController alloc] init];
    
    
    // init navigation controller
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:_channelController];
    [self.navigationController pushViewController:_radioController animated:NO];
    
    
    
    // set global navgigationbar's appearance
    UIImage *navBarImage = [[UIImage imageNamed:@"navBar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0, 80, 0)];
    [[UINavigationBar appearance] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"bt_5.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:[[UIImage imageNamed:@"bt_6.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, -1, 10)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    // set navigation items
    UIBarButtonItem *mainLeftBarButtonItem = [UICustomBarButtonItem createBarButtonItemWithImage:@"bt_22.png" target:self action:@selector(navBarButtonClick:) tag:0];
    
    UIBarButtonItem *mainRightBarButtonItem = [UICustomBarButtonItem createBarButtonItemWithImage:@"bt_11.png" target:self action:@selector(navBarButtonClick:) tag:1];
    
    UIBarButtonItem *channelRightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"正在播放" style:UIBarButtonItemStylePlain target:self action:@selector(navBarButtonClick:)];
    [channelRightBarButtonItem setTag:2];
    
    _radioController.navigationItem.leftBarButtonItem = mainLeftBarButtonItem;
    _radioController.navigationItem.rightBarButtonItem = mainRightBarButtonItem;
    _channelController.navigationItem.rightBarButtonItem = channelRightBarButtonItem;
    
    _channelController.radioController = _radioController;
    
}


- (void)navBarButtonClick:(id)sender {
    
    UIBarButtonItem *button = sender;
    
    switch (button.tag) {
            
        case 0:
            [self.navigationController popToViewController:_channelController animated:YES];
             break;
            
        case 1:
            [self.navigationController pushViewController:_settingController animated:YES];
            break;
            
        case 2:
            [self.navigationController pushViewController:_radioController animated:YES];
            break;
            
        default:
            break;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    
    [self initControllers];
        
    self.window.rootViewController = self.navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

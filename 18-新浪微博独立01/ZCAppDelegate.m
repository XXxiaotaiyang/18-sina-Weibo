//
//  AppDelegate.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/7.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCAppDelegate.h"
#import "ZCHomeViewController.h"
#import "ZCTabBarViewController.h"
#import "ZCMessageViewController.h"
#import "ZCDiscoverViewController.h"
#import "ZCProfileTableViewController.h"

@interface ZCAppDelegate ()

@end

@implementation ZCAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    [UIImage imageNamed:@"tabbar_message_center"];
    // 创建一个tabbarController
    ZCTabBarViewController *tabCol = [[ZCTabBarViewController alloc] init];
    // 主页
    ZCHomeViewController *homeCol = [[ZCHomeViewController alloc] init];
    [self addChildVc:homeCol title:@"首页" normalImage:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    // 信息
    ZCMessageViewController *messageCol = [[ZCMessageViewController alloc] init];
    [self addChildVc:messageCol title:@"信息" normalImage:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    // 发现
    ZCDiscoverViewController *discover = [[ZCDiscoverViewController alloc] init];
    [self addChildVc:discover title:@"发现" normalImage:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    // 我的
    ZCProfileTableViewController *mine = [[ZCProfileTableViewController alloc] init];
    [self addChildVc:mine title:@"我" normalImage:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    

    
    [tabCol addChildViewController:homeCol];
    [tabCol addChildViewController:messageCol];
    [tabCol addChildViewController:discover];
    [tabCol addChildViewController:mine];
    
    self.window.rootViewController = tabCol;
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)addChildVc:(UIViewController *)ChiledVc title:(NSString *)title normalImage:(NSString *)image selectedImage:(NSString *)selectedImage
{
    ChiledVc.view.backgroundColor = kZCRandomColor;
    ChiledVc.tabBarItem.title = title;
    ChiledVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ChiledVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字
    NSMutableDictionary *attbsTitlt = [[NSMutableDictionary alloc] init];
    attbsTitlt[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attbsTitlt[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    
    NSMutableDictionary *selectedtitle = [[NSMutableDictionary alloc] init];
    selectedtitle[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [ChiledVc.tabBarItem setTitleTextAttributes:attbsTitlt forState:UIControlStateNormal];
    [ChiledVc.tabBarItem setTitleTextAttributes:selectedtitle forState:UIControlStateSelected];
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

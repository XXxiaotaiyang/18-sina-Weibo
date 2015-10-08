//
//  ZCTabBarViewController.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/7.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCTabBarViewController.h"
#import "ZCHomeViewController.h"
#import "ZCMessageViewController.h"
#import "ZCDiscoverViewController.h"
#import "ZCProfileTableViewController.h"
#import "ZCNavigationController.h"

@interface ZCTabBarViewController ()

@end

@implementation ZCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    // 主页
    ZCHomeViewController *homeCol = [[ZCHomeViewController alloc] init];

//    ZCNavigationController *navHome = [[ZCNavigationController alloc] initWithRootViewController:homeCol];
    [self addChildVc:homeCol title:@"首页" normalImage:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    // 信息
    ZCMessageViewController *messageCol = [[ZCMessageViewController alloc] init];
    [self addChildVc:messageCol title:@"消息" normalImage:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
//    ZCNavigationController *navMessages = [[ZCNavigationController alloc] initWithRootViewController:messageCol];
    // 发现
    ZCDiscoverViewController *discover = [[ZCDiscoverViewController alloc] init];
    [self addChildVc:discover title:@"发现" normalImage:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
//    ZCNavigationController *navDiscover = [[ZCNavigationController alloc] initWithRootViewController:discover];
    // 我的
    ZCProfileTableViewController *mine = [[ZCProfileTableViewController alloc] init];
    [self addChildVc:mine title:@"我" normalImage:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
//    ZCNavigationController *navMine = [[ZCNavigationController alloc] initWithRootViewController:mine];




//    [self addChildViewController:navHome];
//    [self addChildViewController:navMessages];
//    [self addChildViewController:navDiscover];
//    [self addChildViewController:navMine];

    

}


- (void)addChildVc:(UIViewController *)ChiledVc title:(NSString *)title normalImage:(NSString *)image selectedImage:(NSString *)selectedImage
{
//    ChiledVc.view.backgroundColor = kZCRandomColor;
    
    // 下面两句可以合成一句
//    ChiledVc.title = title;
    ChiledVc.tabBarItem.title = title;  // 设置tabbar的文字
    ChiledVc.navigationItem.title = title; // 设置navigationItem的文字
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
 
    ZCNavigationController *nav = [[ZCNavigationController alloc] initWithRootViewController:ChiledVc];
    
    [self addChildViewController:nav];
    
}



@end

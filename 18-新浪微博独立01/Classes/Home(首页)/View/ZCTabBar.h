//
//  ZCTabBar.h
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/10.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCTabBar;

@protocol ZCTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPullBtn:(ZCTabBar *)pullBtn;

@end

@interface ZCTabBar : UITabBar
@property(nonatomic, weak) id<ZCTabBarDelegate> delegate;
@end

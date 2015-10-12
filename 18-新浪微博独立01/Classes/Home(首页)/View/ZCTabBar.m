//
//  ZCTabBar.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/10.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCTabBar.h"
@interface ZCTabBar()
@property(nonatomic, weak) UIButton *btn;
@end

@implementation ZCTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [[UIButton alloc] init];
        self.btn = btn;
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateSelected];
        btn.size = btn.currentBackgroundImage.size;
        
        [btn addTarget:self action:@selector(pullClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        
    }
    
    return self;
}

- (void)pullClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPullBtn:)]) {
        [self.delegate tabBarDidClickPullBtn:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    
    NSUInteger tabBarCount = 5;
    NSUInteger index = 0;
    CGFloat width = self.width / tabBarCount;
    
    self.btn.centerX = self.width * 0.5;
    self.btn.centerY = self.height * 0.5;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.x = width * index++;
            view.width = width;
            view.y = 0;
            view.height = self.height;
            if (index == 2) {
                index++;
            }
        }
    }
    
}




@end

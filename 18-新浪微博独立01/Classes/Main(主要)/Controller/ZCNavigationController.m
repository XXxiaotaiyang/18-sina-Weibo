//
//  ZCNavigationController.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/8.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCNavigationController.h"

@interface ZCNavigationController ()

@end

@implementation ZCNavigationController

+ (void)initialize
{
    // 设置整个项目的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    textAttributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [item setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    
    NSMutableDictionary *disableTextAttributes = [NSMutableDictionary dictionary];
    disableTextAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    disableTextAttributes[NSForegroundColorAttributeName] = kZCColor(122, 122, 122);
    
    [item setTitleTextAttributes:disableTextAttributes forState:UIControlStateDisabled];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    // 如果大于1就设置上面的navigationItem
    if (self.viewControllers.count > 0) {
    
        // 左边的返回按钮
        UIButton *backBtn = [[UIButton alloc] init];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        
        backBtn.size = backBtn.currentBackgroundImage.size;
        [backBtn addTarget:self action:@selector(backBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        // 右边的按钮
        UIButton *moreBtn = [[UIButton alloc] init];
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];

        
        moreBtn.size = moreBtn.currentBackgroundImage.size;
        
        [moreBtn addTarget:self action:@selector(moreBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        

        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
        
    }
    
    [super pushViewController:viewController animated:animated];
    
}

#pragma mark - 分出来的方法
/**
 *  返回按钮的点击
 */
- (void)backBtnDidClick
{
    [self popViewControllerAnimated:YES];
}

/**
 *  更多按钮的点击
 */
- (void)moreBtnDidClick
{
    // 返回到根控制器
    [self popToRootViewControllerAnimated:YES];
}

@end

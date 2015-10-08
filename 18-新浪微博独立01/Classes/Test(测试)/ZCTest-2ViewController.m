//
//  ZCTest-2ViewController.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/8.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCTest-2ViewController.h"


@interface ZCTest_2ViewController ()

@end

@implementation ZCTest_2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试控制器2";
    
    self.view.backgroundColor = kZCRandomColor;
    
    // 试试自定义了navigation看能不能再自己改一下  能行！！
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试" style:UIBarButtonItemStylePlain target:self action:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

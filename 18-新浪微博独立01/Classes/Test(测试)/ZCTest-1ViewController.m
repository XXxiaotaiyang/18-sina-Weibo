//
//  ZCTest-1ViewController.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/8.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCTest-1ViewController.h"
#import "ZCTest-2ViewController.h"


@interface ZCTest_1ViewController ()

@end

@implementation ZCTest_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kZCRandomColor;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - 代理方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ZCTest_2ViewController *test2 = [[ZCTest_2ViewController alloc] init];
    
    [self.navigationController pushViewController:test2 animated:YES];
}
@end

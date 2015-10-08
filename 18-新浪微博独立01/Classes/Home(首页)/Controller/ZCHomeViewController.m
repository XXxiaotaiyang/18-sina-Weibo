//
//  ZCHomeViewController.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/7.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCHomeViewController.h"

@interface ZCHomeViewController ()

@end

@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *friendBtn = [[UIButton alloc] init] ;
    
    
    UIButton *popBtn = [[UIButton alloc] init];

    self.navigationItem.leftBarButtonItem = [friendBtn itemWithImage:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendDidClick)];
    self.navigationItem.rightBarButtonItem = [popBtn itemWithImage:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" target:self action:@selector(popDidClick)];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 0;
}

#pragma mark - 抽出来的其他方法
- (void)friendDidClick
{
    
}

- (void)popDidClick
{
    
}

@end

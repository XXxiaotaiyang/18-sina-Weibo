//
//  ZCMessageViewController.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/7.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCMessageViewController.h"
#import "ZCTest-1ViewController.h"
#import "ZCTest-2ViewController.h"

@interface ZCMessageViewController ()

@end

@implementation ZCMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test--%ld", indexPath.row];
    
    
    return cell;
}


#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCTest_1ViewController *test1 = [[ZCTest_1ViewController alloc] init];
    
    // 当控制器弹出  隐藏tabbar
    test1.title = @"测试控制1";
    
    test1.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:test1 animated:YES];
}


@end

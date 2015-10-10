//
//  ZCDiscoverViewController.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/7.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCDiscoverViewController.h"
#import "ZCSearchTool.h"

@interface ZCDiscoverViewController ()
@property(nonatomic, weak) UITextField *search;
@end

@implementation ZCDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建搜索框
    ZCSearchTool *searchTool = [ZCSearchTool searchTool];
    self.search = searchTool;
    searchTool.width = 300;
    searchTool.height = 30;
    
    searchTool.placeholder = @"请输入搜索条件";
    searchTool.font = [UIFont systemFontOfSize:13];
    
    // 将搜索框设置成navigationItem的titleView
    self.navigationItem.titleView = searchTool;

   
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    // 取消cell的选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - 代理方法

// 再这个方法中实现点击屏幕空白处  移除键盘
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 移除第一响应者
    [self.search resignFirstResponder];
}







@end

//
//  ZCHomeViewController.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/7.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCHomeViewController.h"
#import "ZCPullDownViewController.h"
#import "ZCPullDownView.h"
#import "ZCButton.h"

@interface ZCHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) ZCPullDownView *pulldown;
@end

@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNavigationItem];
    
    
}

#pragma mark - setup的方法
- (void)setupNavigationItem
{
    
    // 设置navigationItem左右脸变的BarButtonItem的样式
    UIButton *friendBtn = [[UIButton alloc] init] ;
    UIButton *popBtn = [[UIButton alloc] init];
    
    self.navigationItem.leftBarButtonItem = [friendBtn itemWithImage:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendDidClick)];
    self.navigationItem.rightBarButtonItem = [popBtn itemWithImage:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" target:self action:@selector(popDidClick)];
    
    // 设置标题文字的点击样式
    ZCButton *homeBtn = [[ZCButton alloc] init];
//    UIButton *homeBtn = [[UIButton alloc] init];
    [homeBtn setTitle:@"首页测试" forState:UIControlStateNormal];
    [homeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [homeBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [homeBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];

    // 设置为粗体
    [homeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    
    homeBtn.height = 30;
    self.navigationItem.titleView = homeBtn;
    
    // 监听btn按钮的点击
    [homeBtn addTarget:self action:@selector(homeBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];

}




#pragma mark - 抽出来的其他方法
- (void)friendDidClick
{
    
}

- (void)popDidClick
{
    
}

/**
 *  首页按钮被点击
 */
- (void)homeBtnDidClick:(UIButton *)btn
{
    // 创建下啦菜单
  
    ZCPullDownView *pullView = [[ZCPullDownView alloc] init];
    pullView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.6];
//    pullView.width = 180;
//    pullView.height = 300;
    
    // 创建下啦控制器
    ZCPullDownViewController *pullCol = [[ZCPullDownViewController alloc] init];
    pullCol.view.width = 120;
    pullCol.view.height = 180;
    // 将控制器添加到菜单上去
    pullView.contentController = pullCol;
    
    // 将下拉菜单添加到view上去
    // 1.获得最上面的窗口
    [pullView showFrom:btn];
    
  
    

    
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - 代理方法


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 点击空白处移除下拉的这玩意
    [self.pulldown removeFromSuperview];
    
}

@end

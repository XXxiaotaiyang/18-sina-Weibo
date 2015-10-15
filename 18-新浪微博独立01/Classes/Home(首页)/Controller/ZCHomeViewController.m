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
#import "ZCAccountTool.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "UIImageView+WebCache.h"
#import "ZCStatues.h"
#import "ZCUser.h"
#import "MJExtension.h"

@interface ZCHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) ZCPullDownView *pulldown;
@property(nonatomic, weak) ZCButton *homeBtn;

// 定义一个用来存放微博的status
@property(nonatomic, strong) NSMutableArray *statuses;
@end

@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取用户信息
    [self setupUserInfo];
    
    // 加载新微博
    [self loadNewStatus];
    
    // 下来刷新
    [self setupRefresh];
    
    
    
    
    
}

- (void)setupRefresh
{
    UIRefreshControl *reCol = [[UIRefreshControl alloc] init];
    [reCol addTarget:self action:@selector(refreshStatusChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:reCol];
}
/**
 *  下啦刷新功能实现
 */
- (void)refreshStatusChange:(UIRefreshControl *)col
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    ZCAccount *account = [ZCAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最前面的微博（最新的微博，ID最大的微博）
    ZCStatues *firstStatus = [self.statuses firstObject];
    // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
    params[@"since_id"] = firstStatus.idstr;
    
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *newStatuses = [ZCStatues objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];

        [self.statuses insertObjects:newStatuses atIndexes:set];
//        [self.statuses insertObjects:newStatuses atIndexes:set];
        
        


        
        // 刷新表格
        [self.tableView reloadData];
        [col endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [col endRefreshing];
    }];
    

    
    [col endRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置导航栏
    [self setupNavigationItem];
    
   
}

#pragma mark - setup的方法

/**
 *  加载新微博
 */
- (void)loadNewStatus
{
//    https://api.weibo.com/2/statuses/friends_timeline.json
    
    AFHTTPRequestOperationManager *mag = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    ZCAccount *account =  [ZCAccountTool account];
    parameters[@"access_token"] = account.access_token;
    parameters[@"count"] = @30;
    
    
    [mag GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        NSLog(@"到了获取用户的这个地方");
        self.statuses = [ZCStatues objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 刷新一下表格了
        [self.tableView reloadData];
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

- (void)setupUserInfo
{

    
    //    https://api.weibo.com/2/users/show.json
    AFHTTPRequestOperationManager *mag = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    ZCAccount *account =  [ZCAccountTool account];
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;
    
    
    [mag GET:@"https://api.weibo.com/2/users/show.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *name = responseObject[@"name"];
        
        ZCButton *homeBtn = [[ZCButton alloc] init];
        self.homeBtn = homeBtn;
        
        [homeBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];
        [homeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [homeBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        [homeBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
        
        // 设置为粗体
        [homeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        
        homeBtn.height = 30;
        self.navigationItem.titleView = homeBtn;
        
        // 监听btn按钮的点击
        [homeBtn addTarget:self action:@selector(homeBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];

        
        // 存储到沙盒中
        account.name = name;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)setupNavigationItem
{
    
    // 设置navigationItem左右脸变的BarButtonItem的样式
    UIButton *friendBtn = [[UIButton alloc] init] ;
    UIButton *popBtn = [[UIButton alloc] init];
    
    self.navigationItem.leftBarButtonItem = [friendBtn itemWithImage:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendDidClick)];
    self.navigationItem.rightBarButtonItem = [popBtn itemWithImage:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" target:self action:@selector(popDidClick)];
    
    // 设置标题文字的点击样式


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
//    btn.selected = !btn.isSelected;
    
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
    NSLog(@"%lu",(unsigned long)self.statuses.count);
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    // 取出weibo
    ZCStatues *statuses = self.statuses[indexPath.row];
    ZCUser *user = statuses.user;
//    NSString *name = user[@"name"];
    
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = statuses.text;
    
    // 设置图片
    NSString *imageUrl = user.profile_image_url;
    UIImage *placehoder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placehoder];
    
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

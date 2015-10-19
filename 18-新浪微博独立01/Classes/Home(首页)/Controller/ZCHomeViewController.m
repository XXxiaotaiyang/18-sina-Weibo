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
#import "ZCLoadMoreFooter.h"

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
    // 将下啦刷新和刷新集成到一块  刚上来就刷新  这样可以省点代码
//    [self loadNewStatus];
    
    // 下来刷新
    [self setupDownRefresh];
    
    //上啦刷新空间
    [self setupUpRefresh];
    
    // 显示未读消息
//    self.tabBarItem.badgeValue = @"1";
//    int count = 10;
//    NSString *statusC = [NSString stringWithFormat:@"%d", count];
//    if ([statusC isEqualToString:@"0"]) {
//        self.tabBarItem.badgeValue = nil;
//        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    }else{
//        self.tabBarItem.badgeValue = statusC;
//        [UIApplication sharedApplication].applicationIconBadgeNumber = statusC.intValue;
//    }
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setupUnreadeCount) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)setupUnreadeCount
{
//    NSLog(@"setupUnreadeCount");
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    ZCAccount *account = [ZCAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 微博的未读数
        //        int status = [responseObject[@"status"] intValue];
        // 设置提醒数字
        //        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", status];
        
        // @20 --> @"20"
        // NSNumber --> NSString
        // 设置提醒数字(微博的未读数)
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
            self.tabBarItem.badgeValue = nil;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            
            UIApplication *app = [UIApplication sharedApplication];
            // 应用程序右上角数字
            app.applicationIconBadgeNumber = 0;
        } else { // 非0情况
            self.tabBarItem.badgeValue = status;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
            
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            
            UIApplication *app = [UIApplication sharedApplication];
            // 应用程序右上角数字
            app.applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置导航栏
    [self setupNavigationItem];
    
    
}

- (void)setupUpRefresh
{
    ZCLoadMoreFooter *footer = [ZCLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    ZCAccount *account = [ZCAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"count"] = @1;
    // max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    ZCStatues *lastStatus = [self.statuses lastObject];
    // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
    if (lastStatus) {
        long long  maxId = lastStatus.idstr.longLongValue - 1;
        
        params[@"max_id"] = @(maxId);
        
    }
    
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *newArr =[ZCStatues objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        [self.statuses addObjectsFromArray:newArr];
        
        // 刷新表格
        [self.tableView reloadData];
        // 显示数量
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.tableView.tableFooterView.hidden = YES;
    }];

}


- (void)setupDownRefresh
{
    UIRefreshControl *reCol = [[UIRefreshControl alloc] init];
    [reCol addTarget:self action:@selector(refreshStatusChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:reCol];
    
    // 马上进入刷新状态
    [reCol beginRefreshing];
    
    
    // 马上刷新数据
    [self refreshStatusChange:reCol];
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
    if (firstStatus) {
        params[@"since_id"] = firstStatus.idstr;
        
    }
    
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.statuses = [ZCStatues objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        

        
        NSArray *newStatuses = [ZCStatues objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];

        [self.statuses insertObjects:newStatuses atIndexes:set];
//        [self.statuses insertObjects:newStatuses atIndexes:set];
        
        


        
        // 刷新表格
        [self.tableView reloadData];
        // 显示数量
        [self showNewStatusCount:newStatuses.count];
        [col endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [col endRefreshing];
    }];
    

    
    [col endRefreshing];
}

/**
 *  显示刷新了的微博数量
 *
 */
- (void)showNewStatusCount:(NSInteger)count
{
    // 刷新了之后清除那个标号
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    UILabel *statusC = [[UILabel alloc] init];
    statusC.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    statusC.textColor = [UIColor whiteColor];
    statusC.textAlignment = NSTextAlignmentCenter;
    statusC.font = [UIFont systemFontOfSize:13];
    if (count) {
        statusC.text = [NSString stringWithFormat:@"加载了%ld条微博", (long)count];
    }else{
        statusC.text = @"没有新微博产生";
    }
    
    statusC.width = self.view.width;
    statusC.height = 33;
    
    statusC.y = 64 - statusC.height;
    
    self.navigationController.view.backgroundColor = [UIColor redColor];
    [self.navigationController.view insertSubview:statusC belowSubview:self.navigationController.navigationBar];
    //    上面那种插入好点
//    statusC.frame = CGRectMake(0, -33, width, height);
//    [self.navigationController.view addSubview:statusC];
    
    [UIView animateWithDuration:1.0 animations:^{
//        statusC.y += statusC.height;
        statusC.transform = CGAffineTransformMakeTranslation(0, statusC.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear  animations:^{
//            statusC.y -= statusC.height;
            statusC.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [statusC removeFromSuperview];
        }];
    }];
    
    
}



#pragma mark - setup的方法

/**
 *  加载新微博
 */
//- (void)loadNewStatus
//{
////    https://api.weibo.com/2/statuses/friends_timeline.json
//    
//    AFHTTPRequestOperationManager *mag = [AFHTTPRequestOperationManager manager];
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    ZCAccount *account =  [ZCAccountTool account];
//    parameters[@"access_token"] = account.access_token;
//    parameters[@"count"] = @30;
//    
//    
//    [mag GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        self.statuses = [ZCStatues objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        
//        // 刷新一下表格了
//        [self.tableView reloadData];
//        
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//
//}

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

/**
 *  scrollView 滚动了
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableView.tableFooterView.hidden == NO) return;
    
        CGFloat offsetY = self.tableView.contentOffset.y;
        
        
        CGFloat judgeoffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - self.tableView.tableFooterView.height - scrollView.height;
        
        if (offsetY >= judgeoffsetY) { // 最后一个cell完全进入视野范围内
            // 显示footer
            self.tableView.tableFooterView.hidden = NO;
            
            // 加载更多的微博数据
            [self loadMoreStatus];
        }

    
    // 当最后一个cell完全显示在眼前时候 offsetY的值
}


@end

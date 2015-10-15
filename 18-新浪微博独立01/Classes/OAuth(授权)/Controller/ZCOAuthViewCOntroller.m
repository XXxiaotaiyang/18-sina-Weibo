//
//  ZCOAuthViewCOntroller.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/10.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCOAuthViewCOntroller.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "ZCAccount.h"
#import "ZCTabBarViewController.h"
#import "ZCNewFeatureController.h"
#import "ZCAccountTool.h"

@interface ZCOAuthViewCOntroller ()<UIWebViewDelegate>

@end

@implementation ZCOAuthViewCOntroller
- (void)viewDidLoad
{
    // 创建一个web
    
    
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
//    NSLog(@"doc = %@", doc);
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
//    App Key：3109064050
//    App Secret：58bc6bde69bf6cc299711c181dbc22b8
    
    // 用刚才创建的webView加载登录页面  新浪提供
//    OAuth2的authorize接口
//    https://api.weibo.com/oauth2/authorize
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3109064050&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 获得url
    NSString *url = request.URL.absoluteString;
    
    NSLog(@"url - %@", url);
    
    // 判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length!=0) {
        int fromIndex = (int)(range.location + range.length);
        NSString *code = [url substringFromIndex:fromIndex];
        
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
    }
    
    
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    // 获取access_token 的地址
//    https://api.weibo.com/oauth2/access_token
    // 1 请求应用管理者
    AFHTTPRequestOperationManager *magr = [AFHTTPRequestOperationManager manager];
    
    // 拼接请求参数
    
    //    App Key：3109064050
    //    App Secret：58bc6bde69bf6cc299711c181dbc22b8
    
//    必选	类型及范围	说明
//    client_id	true	string	申请应用时分配的AppKey。
//    client_secret	true	string	申请应用时分配的AppSecret。
//    grant_type	true	string	请求的类型，填写authorization_code
//    
//    grant_type为authorization_code时
//    必选	类型及范围	说明
//    code	true	string	调用authorize获得的code值。
//    redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = @"3109064050";
    parameters[@"client_secret"] = @"58bc6bde69bf6cc299711c181dbc22b8";
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = @"http://www.baidu.com";
    
    
    [magr POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        [MBProgressHUD showSuccess:@"获取成功"];
        
//        // 沙盒路径
////        NSString *doc = [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(), @"Documents"];
//        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
//        
//        NSLog(@"%@",path);
//        // 存进沙盒
        ZCAccount *account = [ZCAccount accountWithDict:responseObject];
        
        // 存储帐号信息
        [ZCAccountTool saveAccount:account];
        
//        // 存放自定义对象用 NSKeyedArchiver
//        [NSKeyedArchiver archiveRootObject:account toFile:path];
        
        // 切换窗口的跟控制器
        NSString *key = @"CFBundleVersion";
        // 上一次使用的版本号
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        // 当前的版本号
        
        //[NSBundle mainBundle].infoDictionary  这个是LB中的plist的文件，固定的  不知道就百度哇   哎~
        NSString *curruntVersion = [NSBundle mainBundle].infoDictionary[key];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if ([curruntVersion isEqualToString:lastVersion]) {
            // 版本号相同
            ZCTabBarViewController *tabCol = [[ZCTabBarViewController alloc] init];
            window.rootViewController = tabCol;
        }else{
            ZCNewFeatureController *newF = [[ZCNewFeatureController alloc] init];
            window.rootViewController = newF;
            
            // 然后将当前版本号存到沙盒中
            [[NSUserDefaults standardUserDefaults] setObject:curruntVersion forKey:key];
            
            // 立即生效
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"获取数据失败"];
        NSLog(@"请求失败");
    }];
}
@end

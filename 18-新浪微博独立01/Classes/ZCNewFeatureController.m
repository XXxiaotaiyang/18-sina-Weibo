//
//  ZCNewFeatureController.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/10.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCNewFeatureController.h"
#import "ZCTabBarViewController.h"

// 新特性总共的图片
#define imageCount 4
@implementation ZCNewFeatureController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 创建scrollerView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = kZCRandomColor;
    scrollView.contentSize = CGSizeMake(self.view.width * imageCount, self.view.height);
    // 分页
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    
    [self.view addSubview:scrollView];
    
    CGFloat scrWidth = self.view.width;
    CGFloat scrHeight = self.view.height;
    for (int i = 0 ; i<imageCount; i++) {
        UIImageView *image = [[UIImageView alloc] init];
        image.width = scrWidth;
        image.height = scrHeight;
        image.y = 0;
        image.x = i * scrWidth;
        
        // 设置图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        image.image = [UIImage imageNamed:name];
        [scrollView addSubview:image];
        // 如果是最后一张图片
        if (i == imageCount - 1) {
            
            // 开启交互功能
            image.userInteractionEnabled  = YES;
            
            
            UIButton *shareBtn = [[UIButton alloc] init];
            [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
//            shareBtn.selected = YES;
            [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
            [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
            [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
            [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            shareBtn.width = 200;
            shareBtn.height = 30;
            shareBtn.centerX = image.width * 0.5;
            shareBtn.centerY = image.height * 0.65;

            [image addSubview:shareBtn];
            
            // 点击进入
            UIButton *startBtn = [[UIButton alloc] init];
            
            [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
            [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
            startBtn.size = startBtn.currentBackgroundImage.size;
            startBtn.centerX = shareBtn.centerX;
            startBtn.centerY = image.height * 0.75;
            [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
            [startBtn addTarget:self action:@selector(startStatus) forControlEvents:UIControlEventTouchUpInside];
            
            [image addSubview:startBtn];

        }
    }
}


#pragma mark - 抽出来的其他方法
// checkBox
- (void)shareClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.isSelected;
}

// 开始微博
- (void)startStatus
{
    ZCTabBarViewController *tabCol = [[ZCTabBarViewController alloc] init];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = tabCol;
}
@end

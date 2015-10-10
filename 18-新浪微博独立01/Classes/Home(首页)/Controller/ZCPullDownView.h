//
//  ZCPullDownView.h
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/9.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCPullDownView : UIView
@property(nonatomic, strong) UITableViewController *contentController;

- (void)showFrom:(UIView *)View;
@end

//
//  ZCLoadMoreFooter.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/18.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCLoadMoreFooter.h"

@implementation ZCLoadMoreFooter
+ (instancetype)footer
{
     return [[[NSBundle mainBundle] loadNibNamed:@"ZCLoadMoreFooter" owner:nil options:nil] lastObject];
}
@end

//
//  ZCUser.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/14.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCUser.h"

@implementation ZCUser
- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}
@end

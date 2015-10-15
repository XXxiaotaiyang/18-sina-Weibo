//
//  ZCAccountTool.h
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/12.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZCAccount;

@interface ZCAccountTool : NSObject
/**
 *  存储帐号信息
 *
 */
+ (void)saveAccount:(ZCAccount *)account;

/**
 *  返回帐号模型
 *
 */
+ (ZCAccount *)account;
@end

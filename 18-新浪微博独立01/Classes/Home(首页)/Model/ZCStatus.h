//
//  ZCStatues.h
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/14.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCUser.h"

@interface ZCStatus : NSObject
/**	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;
/**	object	微博作者的用户信息字段 详细*/
@property(nonatomic, strong) ZCUser *user;
/**	string	微博信息内容*/
@property(nonatomic, copy) NSString *text;
/**	string	微博创建时间*/
@property(nonatomic, copy) NSString *created_at;
/**	string	微博来源*/
@property(nonatomic, copy) NSString *source;

// 存放图片地址的数组
@property(nonatomic, strong) NSArray *pic_urls;

/** 被转发的原微博信息字段，当该微博为转发微博时返回 */
@property (nonatomic, strong) ZCStatus *retweeted_status;

/**	int	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;


@end

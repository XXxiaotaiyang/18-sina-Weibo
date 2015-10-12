//
//  ZCAccount.h
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/10.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCAccount : NSObject<NSCoding>
/**
 *  获取的授权后的access_token
 */
@property(nonatomic, copy) NSString *access_token;
/**
 *  access_token的生命周期，单位是秒数。
 */
@property(nonatomic, copy) NSString *expires_in;
/**
 *  当前授权用户的UID。
 */
@property(nonatomic, copy) NSString *uid;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end

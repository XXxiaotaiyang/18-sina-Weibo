//
//  ZCUser.h
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/14.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCUser : NSObject
/**	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;
/**	string	友好显示名称*/
@property(nonatomic, copy) NSString *name;
/**	string	用户头像地址，50×50像素*/
@property(nonatomic, copy) NSString *profile_image_url;
// 注意这个
//@property (nonatomic, assign, getter = isVip) BOOL vip;
///** 会员级别*/
//@property(nonatomic, assign) int *mbrank;

///** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
///** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;
@end

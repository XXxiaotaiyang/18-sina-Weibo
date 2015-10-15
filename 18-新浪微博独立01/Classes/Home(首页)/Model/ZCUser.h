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
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *profile_image_url;
@end

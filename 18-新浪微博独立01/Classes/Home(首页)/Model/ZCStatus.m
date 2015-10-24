//
//  ZCStatues.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/14.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCStatus.h"
#import "MJExtension.h"
#import "ZCPhotos.h"
@implementation ZCStatus
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [ZCPhotos class]};
}
@end

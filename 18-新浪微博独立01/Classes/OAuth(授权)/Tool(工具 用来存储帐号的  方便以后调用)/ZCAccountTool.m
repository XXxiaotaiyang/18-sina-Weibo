//
//  ZCAccountTool.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/12.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCAccountTool.h"
#import "ZCAccount.h"

#define path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
@interface ZCAccountTool ()


@end

@implementation ZCAccountTool

+ (void)saveAccount:(ZCAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:path];

}

+ (ZCAccount *)account
{
    ZCAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return account;
    
}

@end

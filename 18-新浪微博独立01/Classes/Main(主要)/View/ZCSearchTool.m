//
//  ZCSearchTool.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/9.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCSearchTool.h"

@implementation ZCSearchTool

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        // 创建一个搜索的图像
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        
        searchIcon.contentMode = UIViewContentModeCenter;
        
        self.leftView = searchIcon;
        
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return self;
}


+ (instancetype)searchTool
{
    return [[self alloc] init];
}


@end

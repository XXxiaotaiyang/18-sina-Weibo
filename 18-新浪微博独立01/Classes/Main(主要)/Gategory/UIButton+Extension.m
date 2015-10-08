//
//  UIButton+Extension.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/8.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)targer action:(SEL)selector 
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [btn addTarget:targer action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentBackgroundImage.size;
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end

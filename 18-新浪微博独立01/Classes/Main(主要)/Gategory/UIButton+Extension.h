//
//  UIButton+Extension.h
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/8.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
- (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)targer action:(SEL)selector;
@end

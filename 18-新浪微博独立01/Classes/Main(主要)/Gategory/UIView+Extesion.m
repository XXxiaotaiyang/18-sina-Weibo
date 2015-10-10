//
//  UIView+Extesion.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/8.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "UIView+Extesion.h"

@implementation UIView (Extesion)
- (CGSize)size
{
    return self.frame.size;
}


- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height
{
    return self.frame.size.height;
}




- (void)setCentenX:(CGFloat)centenX
{
    CGPoint centenr = self.center;
    centenr.x = centenX;
    self.center = centenr;
}

- (void)setX:(CGFloat)x
{
    CGRect fram= self.frame;
    fram.origin.x = x;
    self.frame = fram;
    
}

- (CGFloat)centenX
{
    return self.center.x;
}

- (void)setCentenY:(CGFloat)centenY
{
    CGPoint centenr = self.center;
    centenr.y = centenY;
    self.center = centenr;
}

- (CGFloat)centenY
{
    return self.center.y;
}


- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect fram= self.frame;
    fram.origin.y = y;
    self.frame = fram;
    
}

- (CGFloat)y
{
    return self.frame.origin.y;
}
@end

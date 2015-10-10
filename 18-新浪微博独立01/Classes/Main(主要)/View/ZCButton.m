//
//  ZCButton.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/10.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCButton.h"
@interface ZCButton ()
@property(nonatomic, strong) UIFont *myFont;
@property(nonatomic, assign) CGRect title;
@end

@implementation ZCButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
    }
    
    return self;
}



- (void)setup
{
    self.myFont = [UIFont boldSystemFontOfSize:17];
    
    self.titleLabel.font = self.myFont;
    
    // 设置按钮状态为不拉伸
    self.imageView.contentMode = UIViewContentModeCenter;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    //
    
    CGFloat titleH = contentRect.size.height;

    NSString *currentTitle = self.currentTitle;
    
    // 定义一个无边界
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    // 定义一个字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = self.myFont;
    
    // 计算文字的宽度
    CGRect  title = [currentTitle boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    CGFloat titleW = title.size.width;
    
    self.title = title;
    
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    
    CGFloat imageW = 16;
    
    CGFloat imageH = contentRect.size.height;
    
    //    CGFloat imageX =  contentRect.size.width - imageW;
    CGFloat imageX =  self.title.size.width + 5;
    
    //    NSLog(@"contentRect.size.width = %f", contentRect.size.width);
    //
    //    NSLog(@"iamgeW = %f", imageW);
    //
    //    NSLog(@"imageX = %f", imageX);
    //
    return CGRectMake(imageX, imageY, imageW, imageH);

}
@end

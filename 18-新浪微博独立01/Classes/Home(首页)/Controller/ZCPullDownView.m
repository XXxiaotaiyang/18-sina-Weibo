//
//  ZCPullDownView.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/9.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCPullDownView.h"

@interface ZCPullDownView ()
@property(nonatomic, strong) UIView *contenView;
@property(nonatomic, weak) UIImageView *imageView;


@end

@implementation ZCPullDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (void)setContentController:(UITableViewController *)contentController
{
    _contentController = contentController;
    
    self.contenView = contentController.view;
}

- (void)setContenView:(UIView *)contenView
{
    _contenView = contenView;

    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"popover_background"];


    contenView.x = 10;
    contenView.y = 15;
    self.imageView.width = contenView.width + 20 ;
    self.imageView.height = contenView.height + 25;

    [imageView addSubview:self.contenView];
    [self addSubview:imageView];

    
}

- (void)showFrom:(UIView *)View
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = window.bounds;
    [window addSubview:self];

    CGRect newFram = [View convertRect:View.bounds toView:window];

    self.imageView.y = CGRectGetMaxY(newFram);
    self.imageView.centenX = newFram.origin.x + newFram.size.width / 2;


    [window addSubview:self];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
@end

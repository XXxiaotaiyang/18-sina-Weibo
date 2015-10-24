//
//  ZCStatusFrame.h
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/20.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kZCStatusCellNameFont [UIFont systemFontOfSize:15]
#define kZCStatusCellTimeFont [UIFont systemFontOfSize:12]
#define kZCStatusCellSourceFont [UIFont systemFontOfSize:12]
#define kZCStatusCellContentFont [UIFont systemFontOfSize:12]
@class ZCStatus;
@interface ZCStatusFrame : NSObject

@property(nonatomic, strong) ZCStatus *status;

/** 原创微博*/
@property(nonatomic, assign) CGRect originalViewF;
/** 头像*/
@property(nonatomic, assign) CGRect iconViewF;
/** 用户名*/
@property(nonatomic, assign) CGRect nameLabelF;
/** 会员图标*/
@property(nonatomic, assign) CGRect vipViewF;
/** 时间*/
@property(nonatomic, assign) CGRect timeLabelF;
/** 来源*/
@property(nonatomic, assign) CGRect sourceLabelF;

/** 正文*/
@property(nonatomic, assign) CGRect contenLabelF;

/** 配图*/
@property(nonatomic, assign) CGRect photoViewF;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotoViewF;

/** 工具条*/
@property(nonatomic, assign) CGRect toolBarF;

///** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end

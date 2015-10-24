//
//  ZCStatusFrame.m
//  18-新浪微博独立01
//
//  Created by 闲人 on 15/10/20.
//  Copyright (c) 2015年 闲人. All rights reserved.
//

#import "ZCStatusFrame.h"
#import "ZCUser.h"
#import "ZCStatus.h"

// cell的边框宽度
#define kZCStatusCellBorderW 10


@implementation ZCStatusFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{

    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


- (CGSize)sizeWithText:(NSString *)text font:(UIFont*)font
{

    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}


- (void)setStatus:(ZCStatus *)status
{
    
    _status = status;
    
    ZCUser *user = status.user;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
//    /** 原创微博*/
//    @property(nonatomic, assign) CGRect originalViewF;
    
//    /** 头像*/
//    @property(nonatomic, assign) CGRect iconViewF;
    CGFloat iconWH = 35;
    CGFloat iconX = kZCStatusCellBorderW;
    CGFloat iconY = kZCStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
//    /** 用户名*/
//    @property(nonatomic, assign) CGRect nameLabelF;
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + kZCStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:kZCStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    

    
//    /** 会员图标*/
//    @property(nonatomic, assign) CGRect vipViewF;
    
    if (user.vip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + kZCStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
//    /** 时间*/
//    @property(nonatomic, assign) CGRect timeLabelF;
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + kZCStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at font:kZCStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    
    
//    /** 来源*/
//    @property(nonatomic, assign) CGRect sourceLabelF;
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + kZCStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:kZCStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
//    
//    /** 正文*/
//    @property(nonatomic, assign) CGRect contenLabelF;
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + kZCStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    
    CGSize contentSize = [self sizeWithText:status.text font:kZCStatusCellContentFont maxW:maxW];
    self.contenLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    
    CGFloat originalH = 0;
    if (status.pic_urls.count) { // 有配图
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contenLabelF) + kZCStatusCellBorderW;
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        
        originalH = CGRectGetMaxY(self.photoViewF) + kZCStatusCellBorderW;
    } else { // 没配图
        originalH = CGRectGetMaxY(self.contenLabelF) + kZCStatusCellBorderW;
    }
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    
    /* 被转发微博 */
    if (status.retweeted_status) {
        ZCStatus *retweeted_status = status.retweeted_status;
        ZCUser *retweeted_status_user = retweeted_status.user;
        
        /** 被转发微博正文 */
        CGFloat retweetContentX = kZCStatusCellBorderW;
        CGFloat retweetContentY = kZCStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        CGSize retweetContentSize = [self sizeWithText:retweetContent font:kZCStatusCellContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        
        /** 被转发微博配图 */
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) { // 转发微博有配图
            CGFloat retweetPhotoWH = 100;
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + kZCStatusCellBorderW;
            self.retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
            
            retweetH = CGRectGetMaxY(self.retweetPhotoViewF) + kZCStatusCellBorderW;
        } else { // 转发微博没有配图
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + kZCStatusCellBorderW;
        }
        
        /** 被转发微博整体 */
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        CGFloat toolBarX = 0;
        CGFloat toolBarY = CGRectGetMaxY(self.retweetViewF);
        CGFloat toolBarW = cellW;
        CGFloat toolBarH = 44;
        self.toolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
        
        ;
    } else {
        
        // 如果只有原创微博
        self.toolBarF = CGRectMake(0, CGRectGetMaxY(self.originalViewF), cellW, 35);
        
//        self.cellHeight = CGRectGetMaxY(self.originalViewF);
    }
    
    self.cellHeight = CGRectGetMaxY(self.toolBarF);
    
 
}












@end

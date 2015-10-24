//
//  ZC.h
//  
//
//  Created by 闲人 on 15/10/24.
//
//

#import <UIKit/UIKit.h>
@class ZCStatus;
@interface ZCHomeCellToolBar : UIView
+ (instancetype)toolbar;
@property (nonatomic, strong) ZCStatus *status;
@end

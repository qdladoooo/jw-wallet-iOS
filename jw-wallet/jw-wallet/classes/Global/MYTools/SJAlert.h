//
//  SJAlert.h
//  ShouJinLiCai
//
//  Created by 王冠阳 on 16/5/22.
//  Copyright © 2016年 shoujinwang. All rights reserved.
//  快速创建弹框

#import <Foundation/Foundation.h>

@interface SJAlert : NSObject
/*!
 @method
 @abstract 创建警告框并跳出
 @discussion [SJ_AlertEvent createAlertWithMessage: @"warning infomartion" controller: self];
 @param message 警告信息
 @param viewController  在哪个控制器上显示
 */
+ (void)createAlertWithMessage: (NSString *)message controller: (UIViewController *)viewController;

/*!
 @method
 @abstract 创建灰色自动隐藏的警告框并跳出
 @discussion [SJ_AlertEvent createShadowAlertWithMessage: @"warning infomartion" frame: CGRectZero superView: self.view];
 @param message 警告信息
 @param frame   尺寸坐标
 @param superView   显示的父视图
 */
+ (void)createShadowAlertWithMessage: (NSString *)message frame: (CGRect)frame superView: (UIView *)superView;
/** 
 title :标题
 message: 内容
 actionMessage : 按钮文字
 */
+ (void)creatAlertWithTitle: (NSString *)title  message:(NSString *)message actionMessage:(NSString *)actionMessage ntroller: (UIViewController *)viewController;
@property (nonatomic, strong) UINavigationController *nav;
@end

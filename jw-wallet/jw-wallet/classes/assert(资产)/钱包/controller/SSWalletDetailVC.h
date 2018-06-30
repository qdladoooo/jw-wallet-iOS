//
//  SSWalletDetailVC.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/6.
//  Copyright © 2018年 SHSF. All rights reserved.
//  钱包详情

#import <UIKit/UIKit.h>

@interface SSWalletDetailVC : UIViewController
@property (nonatomic, strong) SSWalletInfo *model;

/**
 元素位置
 */
@property (nonatomic, assign) NSInteger index;
@end

//
//  SSWalletInfo.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/28.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGFMDB.h"
@interface SSWalletInfo : NSObject

/**
 私钥
 */
@property (nonatomic, copy)NSString *privatePassword;

/**
 密码
 */
@property (nonatomic, copy)NSString * walletPassword;

/**
 钱宝名称
 */
@property (nonatomic, copy)NSString * walletName;

/**
 钱宝地址
 */
@property (nonatomic, copy)NSString * walletAdress;

/**
 钱宝余额
 */
@property (nonatomic, copy)NSString * walletBalance;

@end

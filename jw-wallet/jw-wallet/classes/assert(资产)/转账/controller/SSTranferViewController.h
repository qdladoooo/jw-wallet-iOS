//
//  SSTranferViewController.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/28.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSTranferViewController : SSBaseViewController

/**
 扫描二维码获取地址
 */
@property(nonatomic,copy) NSString *jump_URL;
/**
 资产ID
 */
@property (nonatomic, strong) NSString *AssetID;
/**
 账户ID
 */
@property (nonatomic, strong) NSString *AccountID;
@end

 //
// Created by Cool on 2018/8/15.
// Copyright (c) 2018 Cool. All rights reserved.
//

#import <Foundation/Foundation.h>


static int const LOOKUP_ACCOUNT_NAMES_ID = 3300;//AccountInfo
static int const GET_ACCOUNT_BALANCES_ID = 3301;//AccountBalances
static int const GET_ASSETS_ID = 3302;//AssetsInfo
static int const GET_ACCOUNTS_ID = 3303;//AccountInfo

static int const LOGIN_ID = 3304;//AccountObserveUpdate
static int const DATABASE_ID = 3305;//AccountObserveUpdate
static int const SET_SUBSCRIBE_CALLBACK_ID = 3306;//AccountObserveUpdate
static int const CANCEL_ALL_SUBSCRIPTIONS_ID = 3307;//AccountObserveUpdate
static int const GET_FULL_ACCOUNTS_ID = 3308;//AccountObserveUpdate

@interface RequestUtils : NSObject


/**
 * 1.根据账号名获取账号ID
 **/
+ (NSString *)lookup_account_names:(NSString *)names;

+ (NSString *)lookup_account_names:(int)id1 names:(NSString *)names;

/**
 * 2.根据账号id获取账号余额
 */
+ (NSString *)get_account_balances:(NSString *)ids;

+ (NSString *)get_account_balances:(int)id1 ids:(NSString *)ids;

/**
 *  3根据ID获取资产信息
 * @param ids
 * @return
 */
+ (NSString *)get_assets:(NSString *)ids;

+ (NSString *)get_assets:(int)id1 ids:(NSString *)ids;

/**
 * 4.获取账号信息
 * @param ids
 * @return
 */
+ (NSString *)get_accounts:(NSString *)ids;

+ (NSString *)get_accounts:(int)id1 ids:(NSString *)ids;

// 5.监控账户更新
/**
5.1登陆
 * @param ids
 * @return
 */
+ (NSString *)login;

+ (NSString *)login:(int)id;

/**
 * 5.2 连接数据库
 * @return
 */
+ (NSString *)database;

+ (NSString *)database:(int)id;

/**
 * 5.3订阅账户更新回调
 * @return
 */
+ (NSString *)set_subscribe_callback;

+ (NSString *)set_subscribe_callback:(int)id;

/**
 * 5.4取消账户更新回调
 * @return
 */
+ (NSString *)cancel_all_subscriptions;

+ (NSString *)cancel_all_subscriptions:(int)id;
/**
 * 5.5取消账户更新回调
 * @return
 */
+ (NSString *)get_full_accounts:(NSString *)ids;

+ (NSString *)get_full_accounts:(int)id1 ids:(NSString *)ids;
@end

//
//  DefineRequest.h


#ifndef DefineRequest_h
#define DefineRequest_h

// 0生产 1开发
#define DEVELOPMENT  1
//列表一页请求数量
#define REQUEST_MIN_PAGE_NUM 10
//连接超时时间
#define RequestTimeOut 30

#if DEVELOPMENT //***************开发版本*************

//****************测试环境***********

//****************开发环境(个人服务器)************
//**************** http 接口 ****************
#define BaseURLString  @"http://faucet.testnet.gref.io/index.php"
//**************** websocket 接口 ****************
#define SocketBaseURLString  @"ws://115.28.54.7:11011"
// 官方接口 ws://127.0.0.1:8090
#define BiteSharesURL @"wss://bitshares.openledger.info/ws"

#else          //**************生产版本**************
#define BaseURLString  @"http://faucet.testnet.gref.io/index.php"
//**************** websocket 接口 ****************
#define SocketBaseURLString  @"ws://115.28.54.7:11011"

#endif

//****************HTTP接口说明************

// 获取助记词
#define GetHelpWords @"/index/suggest-brain-key"
#define CreatWallet @"/index/create-account"

//**************** websocket接口说明 ************
// 不需要用户权限的api，任何人都可以访问


// 列出所有资产
#define AssetsList @"list_assets"
//"list_assets"
//[start, count]
//
//
//// 查询资产
#define LookForAssets
//"get_objects"
//[dynamicIDS | bitAssetIDS]
//
//
//// 根据地址获取 balance_id 数组
#define get_balance_objects @"get_balance_objects"
//"get_balance_objects"
//[addresses]
//
//
//// 根据 balance_id 获取余额
#define get_vested_balances @"get_vested_balances"
//"get_vested_balances"
//[balance_ids]
//
//
//// 获取交易所状态
#define get_ticker @"get_ticker"
//"get_ticker"
//[second.get("id"), first.get("id")]
//// first、second 来自 getMarketName 的返回值
//const {marketName, first, second} = marketUtils.getMarketName(
//                                                              base,
//                                                              quote
//                                                              );
// 获取三种订单
#define get_call_orders @"get_call_orders"
//"get_call_orders"
//[marketAsset.id, 300]
//
//
#define get_settle_orders @"get_settle_orders"
//"get_settle_orders"
//[marketAsset.id, 300]
//
//
#define get_limit_orders @"get_limit_orders"
//"get_limit_orders"
//[base.get("id"), quote.get("id"), 300]
//
#define get_market_history @"get_market_history"
//"get_market_history"
//[
// base.get("id"),
// quote.get("id"),
// bucketSize,
// startDate.toISOString().slice(0, -5),
// endDate.toISOString().slice(0, -5)
// ]
//
//
#define get_fill_order_history @"get_fill_order_history"
//"get_fill_order_history"
//[
// base.get("id"),
// quote.get("id"),
// 200
// ]
//
//
//// 订阅市场消息
#define subscribe_to_market @"subscribe_to_market"
//"subscribe_to_market"
//[
// subscription.bind(
//                   this,
//                   base.get("id") + "_" + quote.get("id")
//                   ),
// base.get("id"),
// quote.get("id")
// ]
//
//// 取消订阅市场消息
#define unsubscribe_from_market @"unsubscribe_from_market"
//"unsubscribe_from_market"
//[
// subs[subID],
// quote,
// base
// ]
//
//
#define get_market_history_buckets @"get_market_history_buckets"
//"get_market_history_buckets"
//[]
//
//
//// 获取区块
#define get_block @"get_block"
//"get_block"
//[height]
//
//
//// 查看账户
#define lookup_accounts @"lookup_accounts"
//"lookup_accounts"
//[startChar, limit]



#endif /* DefineRequest_h */

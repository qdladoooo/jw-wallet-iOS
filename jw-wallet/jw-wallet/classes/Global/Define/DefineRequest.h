//
//  DefineRequest.h


#ifndef DefineRequest_h
#define DefineRequest_h

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

#else          //**************生产版本**************
#define BaseURLString  @"http://faucet.testnet.gref.io/index.php"
//**************** websocket 接口 ****************
#define SocketBaseURLString  @"ws://115.28.54.7:11011"
#endif

//****************接口说明************

// 获取助记词
#define GetHelpWords @"/index/suggest-brain-key"
#define CreatWallet @"/index/create-account"




#endif /* DefineRequest_h */

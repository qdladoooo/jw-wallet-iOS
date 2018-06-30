//
//  DefineMacro.h

// 全局宏定义

#ifndef DefineMacro_h
#define DefineMacro_h

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define gy_LocalizableName @"Localizable"

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//随机颜色
#define KRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//通知中心
#define KNotificationCenter [NSNotificationCenter defaultCenter]
//弱引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type;
//判断是否是iPhone4s
#define IS_IPHONE4S (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)
//判断是否是iPhone5
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
//判断是否是iPhone6、iPhone7
#define IS_IPHONE6 (([[UIScreen mainScreen] bounds].size.height-667)?NO:YES)
//判断是否是iPhone6plush、7plus
#define IS_IPHONE6_PLUS (([[UIScreen mainScreen] bounds].size.height-736)?NO:YES)
//Appdelegate
#define APPDELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]
//当前设备的ios版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// 是否设置指纹登录
#define  TouchIdLogIn @"TouchIdLogIn"
// 是否设置指纹支付
#define TouchIdPay @"TouchIdPay"
// 钱宝信息数组标识
#define wallet_Info @"walletInfo"
// 自定义Log
#ifdef DEBUG
#define SSLog(...) NSLog(__VA_ARGS__)
#else
#define SSLog(...)
#endif

#endif /* DefineMacro_h */

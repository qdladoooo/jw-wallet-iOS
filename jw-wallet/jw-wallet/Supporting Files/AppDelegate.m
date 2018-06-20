//
//  AppDelegate.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/26.
//  Copyright © 2018年 SHSF. All rights reserved.
//
#import "SJ_NewfeatureViewController.h"
#import "AppDelegate.h"
#import "RootTabViewController.h"
#import "HXLanguageManager.h"
// 引入JPush功能所需头文件-----****------
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
// -----****------
// 引入 JSHARE 功能所需头文件
#import "JSHAREService.h"
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
//#import <AdSupport/AdSupport.h>
// -----****------
@interface AppDelegate ()
<JPUSHRegisterDelegate>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     // Override point for customization after application launch.
    //当前语言
    NSString *currentLanguage = kLanguageManager.currentLanguage;
    
    if([currentLanguage rangeOfString:currentLanguage].location == NSNotFound)
    {
        [kLanguageManager setUserlanguage:@"zh-hant"];
    }
    
    // 极光推送
    [self Add_JPUSH_APNs]; //初始化APNs代码
    [self Init_JPUSH:launchOptions]; //初始化JPush代码
    [self Init_JShare]; // 初始化极光分享
    
    //设置全局状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setAppWindows];
    [self setRootViewController];
    

    
    // 2.新特性--(引导页)--
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSString *key = @"CFBundleShortVersionString";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    [defaults setValue: nil forKey: @"deleteCard"];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 如果跟沙盒中存储的版本一致就跳过新特性
    if ([currentVersion isEqualToString:lastVersion]) {
        
        RootTabViewController *tabBarVc = [[RootTabViewController alloc] init];
        self.window.rootViewController = tabBarVc;
        tabBarVc.selectedIndex = 0;
        
    } else { // 新版本，进入导航页界面
        self.window.rootViewController = [[SJ_NewfeatureViewController alloc] init];
        // 存储新版本 进入首页再进行存储
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - 添加初始化APNs代码
-(void)Add_JPUSH_APNs{
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
}


#pragma mark - 添加初始化JPush代码
/**
 部分参数说明：
 
 appKey
 选择 Web Portal上 的应用 ，点击“设置” 获取其 appkey 值。请确保应用内配置的 appkey 与 Portal 上创建应用后生成的 appkey 一致。
 channel
 指明应用程序包的下载渠道，为方便分渠道统计，具体值由你自行定义，如：App Store。
 apsForProduction
 1.3.1版本新增，用于标识当前应用所使用的APNs证书环境。
 0 (默认值)表示采用的是开发证书，1 表示采用生产证书发布应用。
 注：此字段的值要与Build Settings的Code Signing配置的证书环境一致。
 advertisingIdentifier
 详见关于IDFA。https://docs.jiguang.cn/jpush/client/iOS/ios_guide_new/#_8
 */
-(void)Init_JPUSH:(NSDictionary *)launchOptions{
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *advertisingId = nil;
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    NSString *appKey = @"399cc62dbcf4cedaa5111340";
    NSString *channel = @"AppStore";
    BOOL isProduction = NO; // 0开发 1生产
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
}

#pragma mark - 注册APNs成功并上报DeviceToken
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark - 实现注册APNs失败接口（可选）
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
      NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark - 添加处理APNs通知回调方法
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark - 初始化极光分享
-(void)Init_JShare{
    JSHARELaunchConfig *config = [[JSHARELaunchConfig alloc] init];
    config.appKey = @"AppKey copied from JiGuang Portal application";
    config.SinaWeiboAppKey = @"374535501";
    config.SinaWeiboAppSecret = @"baccd12c166f1df96736b51ffbf600a2";
    config.SinaRedirectUri = @"https://www.jiguang.cn";
    config.QQAppId = @"1105864531";
    config.QQAppKey = @"glFYjkHQGSOCJHMC";
    config.WeChatAppId = @"wxa2ea563906227379";
    config.WeChatAppSecret = @"bb63c0a06bf0ee7f633a5bc44304d110";
    config.FacebookAppID = @"1847959632183996";
    config.FacebookDisplayName = @"JShareDemo";
    config.TwitterConsumerKey = @"4hCeIip1cpTk9oPYeCbYKhVWi";
    config.TwitterConsumerSecret = @"DuIontT8KPSmO2Y1oAvby7tpbWHJimuakpbiAUHEKncbffekmC";
    [JSHAREService setupWithConfig:config];
    [JSHAREService setDebug:YES];
}

//目前适用所有 iOS 系统
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    [JSHAREService handleOpenUrl:url];
    return YES;
}

@end

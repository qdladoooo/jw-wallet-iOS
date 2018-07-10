//
//  SSGlobalWebView.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/12.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSGlobalWebView.h"
#import "WKWebViewJavascriptBridge.h"

@interface SSGlobalWebView ()<WKNavigationDelegate,WKUIDelegate>
/**
 webView
 */
@property (nonatomic, strong)WKWebView *webView;

/**
 交互
 */
@property (nonatomic, strong)WKWebViewJavascriptBridge *bridge;

// -------自定义导航view-----
@property(nonatomic, strong)UIView *navigationView;

@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, strong)UIButton *rightBtn;
@end

@implementation SSGlobalWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self creatUI];
    [self registerNativeFunctions];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.webView reload];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 注册JS调用OC的方法
- (void)registerNativeFunctions
{
    
    [self registCallApp];
    

}
/**
 js调用分享功能
 */
- (void)registCallApp{
    [self.bridge registerHandler:@"callApp" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 在这里写原生的方法
    }];
    [_bridge registerHandler:@"backApp" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 返回
        [self canGoBack];
    }];
}
- (void)creatUI{
    [self creatNavigatonView];
    
    [self creatWebView];
}

- (void)creatNavigatonView{
    self.navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.navigationView.backgroundColor = MAIN_GROUNDCOLOR;
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        if (SCREEN_HEIGHT == 812) {
            make.height.equalTo(@88);
        }else{
            make.height.equalTo(@64);
        }
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 60, 44);
    [backBtn setImage:[UIImage imageNamed:@"nav_white"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navigationView.mas_bottom).with.offset(0);
        make.left.equalTo(self.navigationView.mas_left).with.offset(0);
        make.height.equalTo(@44);
        make.width.equalTo(@60);
    }];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 150, 44)];
    [self.titleLabel setTextColor:WHITCOLOR];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    if (self.titleName == nil) {
        self.titleLabel.text = @"GRE";
    }else{
        self.titleLabel.text = self.titleName;
    }
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.navigationView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navigationView.mas_bottom).with.offset(0);
        make.height.equalTo(@44);
        make.width.equalTo(@150);
        make.centerX.equalTo(self.navigationView.mas_centerX);
    }];
    
//    self.rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.rightBtn.frame = CGRectMake(SCREEN_WIDTH-80, 20, 60, 44);
//    self.rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [self.rightBtn setTitleColor:rgba(66, 66, 66, 1) forState:UIControlStateNormal];
//    [self.rightBtn setTitle:@" " forState:UIControlStateNormal];
//    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [self.rightBtn addTarget:self action:@selector(jumpBrokerPlan:) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationView addSubview:self.rightBtn];
//    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.navigationView.mas_bottom).with.offset(0);
//        make.right.equalTo(self.navigationView.mas_right).with.offset(-10);
//        make.height.equalTo(@44);
//        make.width.equalTo(@80);
//    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.navigationView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navigationView.mas_bottom).with.offset(0);
        make.left.equalTo(self.navigationView.mas_left).with.offset(0);
        make.right.equalTo(self.navigationView.mas_right).with.offset(0);
        make.height.equalTo(@0.5);
    }];
    
}

- (void)creatWebView{
    //设置WKWebView
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    self.webView.allowsBackForwardNavigationGestures = YES;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    
   
    NSString*encodedUrl = [self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"打开的网址是------%@",encodedUrl);
    // 废弃的方法
//    NSString * encodedUrl = [self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    [request setAllowsCellularAccess:YES];
    [self.webView loadRequest:request];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
    }];
    
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - 点击原生按钮返回
-(void)popBack{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击web返回
-(void)canGoBack{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/**
 传递参数到JS中
 */
- (void)transmiParameterToJS{
//    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
//    if (!isLogin) {
//        token = @"";
//    }
//    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
//    NSString *inviteCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"inviteCode"];
//    NSString *age = [[NSUserDefaults standardUserDefaults] objectForKey:@"personalAge"];
//    NSString *env = [NSString stringWithFormat:@"%d",openTest];
//    NSDictionary *params = @{@"token": token == nil ? @"" : token,
//                             @"userId": userId == nil ? @"" : userId,
//                             @"inviteCode": inviteCode == nil ? @"" : inviteCode,
//                             @"env":env,
//                             @"platform":kScreenHeight == 812? @"1":@"0",
//                             @"age":age == nil ? @"" :age,
//                             @"riskAssets":self.riskAssets == nil ? @"" : self.riskAssets,
//                             @"riskPaymentsOnschedule": self.riskPaymentsOnschedule == nil ? @"" :self.riskPaymentsOnschedule,
//                             @"riskRepaySource":self.riskRepaySource == nil ? @"" : self.riskRepaySource,
//                             @"contips":self.contips == nil ? @"0" : self.contips,
//                             @"wisdomId":self.wisdomId == nil?@"" : self.wisdomId
//                             };
//    NSData *data=[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    // 传递用户数据到 H5
//    [self.bridge callHandler:@"callJS" data:jsonStr];
}

/**
 从js中获得标签数据
 */
- (void)getMeeageFromeWebview{
    
    if (self.webView.title.length > 11) {
        self.titleLabel.text = [self.webView.title substringToIndex:11];
    }else if(self.webView.title.length > 0){
        self.titleLabel.text = self.webView.title;
    }
}
#pragma mark - 应用跳转专用
/**
 *  url是否是跳转APP类型的
 *
 *   URL
 *
 *   BOOL
 */
- (BOOL)isJumpToExternalAppWithURL:(NSURL *)URL{
    NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https"]];
    return ![validSchemes containsObject:URL.scheme];
}

#pragma mark - WKNavigationDelegate

/// 1 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
    
//    if([self isJumpToExternalAppWithURL:navigationAction.request.URL]) {
//        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
//    decisionHandler(WKNavigationActionPolicyAllow);
}

/// 2 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

/// 3 在收到服务器的响应头，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/// 4 开始获取到网页内容时返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

/// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 1ull *NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self getMeeageFromeWebview];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [self transmiParameterToJS];
}


/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSURLCredential *credential = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
}
@end

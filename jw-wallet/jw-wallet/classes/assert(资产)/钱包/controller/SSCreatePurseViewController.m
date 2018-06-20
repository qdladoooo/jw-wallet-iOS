//
//  SSCreatePurseViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/29.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSCreatePurseViewController.h"
#import "SSBackupWalletViewController.h"
@interface SSCreatePurseViewController ()<GT3CaptchaManagerDelegate>
// 各种标题~
@property (weak, nonatomic) IBOutlet UILabel *nav_title;
@property (weak, nonatomic) IBOutlet UILabel *walletName_title;
@property (weak, nonatomic) IBOutlet UILabel *passWord_title;
@property (weak, nonatomic) IBOutlet UILabel *repeatpassword_title;
@property (weak, nonatomic) IBOutlet UILabel *checkCode_title;
// 输入框们~
@property (weak, nonatomic) IBOutlet UITextField *tf1;
@property (weak, nonatomic) IBOutlet UITextField *tf2;
@property (weak, nonatomic) IBOutlet UITextField *tf3;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UILabel *inputCode_title;
// 提示
@property (weak, nonatomic) IBOutlet UILabel *tips;


/**
 底部提示信息框
 */
@property (weak, nonatomic) IBOutlet UIView *bottomTipView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *check_box;

@property (nonatomic, strong) GT3CaptchaManager *manager;
@property (strong, nonatomic) IBOutlet GT3CaptchaButton *vertifyBtn;
@property (nonatomic, strong) GT3CaptchaButton *captchaButton;
@property (weak, nonatomic) IBOutlet UIView *captchaView;

//网站主部署的用于验证登录的接口 (api_1)
#define api_1 @"http://www.geetest.com/demo/gt/register-slide"
//网站主部署的二次验证的接口 (api_2)
#define api_2 @"http://www.geetest.com/demo/gt/validate-slide"
@end

@implementation SSCreatePurseViewController
{
    BOOL hasVertify; //是否已经通过验证
}
- (void)viewWillAppear:(BOOL)animated {
    [self createCaptcha];
}

- (IBAction)vertify:(id)sender {
     [_vertifyBtn startCaptcha];
}

- (void)createCaptcha {
    //创建验证管理器实例
    
    GT3CaptchaManager *captchaManager = [[GT3CaptchaManager alloc] initWithAPI1:api_1 API2:api_2 timeout:5.0];
    captchaManager.delegate = self;
    
    //debug mode
    //    [captchaManager enableDebugMode:YES];
    
    //创建验证视图的实例, 并添加到父视图上
    _vertifyBtn = [[GT3CaptchaButton alloc] initWithFrame:_vertifyBtn.frame captchaManager:captchaManager];
    //推荐直接开启验证
//    [captchaButton registerCaptcha:nil];
//    [self.view addSubview:captchaButton];
//    [captchaButton startCaptcha];
   
    
}


#pragma mark - 极验二次验证
- (void)gtCaptcha:(GT3CaptchaManager *)manager didReceiveSecondaryCaptchaData:(NSData *)data response:(NSURLResponse *)response error:(GT3Error *)error decisionHandler:(void (^)(GT3SecondaryCaptchaPolicy))decisionHandler {
    if (!error) {
        //处理你的验证结果
        NSLog(@"\nsession ID: %@,\ndata: %@", [manager getCookieValue:@"msid"], [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];//转换数据格式
        NSLog(@"result---: %@", result);
        if ([result[@"status"] isEqualToString:@"success"]) {
            hasVertify = YES; // 通过行为验证
            SSLog(@"通过验证");
        }
    
        //成功请调用decisionHandler(GT3SecondaryCaptchaPolicyAllow)
        decisionHandler(GT3SecondaryCaptchaPolicyAllow);
        //失败请调用decisionHandler(GT3SecondaryCaptchaPolicyForbidden)
//        decisionHandler(GT3SecondaryCaptchaPolicyForbidden);
    }
    else {
        //二次验证发生错误
        decisionHandler(GT3SecondaryCaptchaPolicyForbidden);
        NSLog(@"validate error: %ld, %@", (long)error.code, error.localizedDescription);
    }
}

- (void)gtCaptcha:(GT3CaptchaManager *)manager errorHandler:(GT3Error *)error {
    //    //处理验证中返回的错误
        NSLog(@"error: %@", error.localizedDescription);
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.bottomTipView.layer.borderWidth = 1;
    self.bottomTipView.layer.borderColor = rgba(105, 200, 250, 1).CGColor;
    
    // 国际化处理
    self.nav_title.text = kLocalizedTableString(@"创建钱包", gy_LocalizableName);
    self.walletName_title.text = kLocalizedTableString(@"钱包名称", gy_LocalizableName);
    self.passWord_title.text = kLocalizedTableString(@"密码", gy_LocalizableName);
    self.repeatpassword_title.text = kLocalizedTableString(@"重复密码", gy_LocalizableName);
    self.checkCode_title.text = kLocalizedTableString(@"验证码", gy_LocalizableName);
    self.tf1.placeholder = kLocalizedTableString(@"请输入钱包名称", gy_LocalizableName);
    self.tf2.placeholder = kLocalizedTableString(@"6位纯数字", gy_LocalizableName);
    self.tf3.placeholder = kLocalizedTableString(@"重复密码", gy_LocalizableName);
    self.inputCode_title.text = kLocalizedTableString(@"请输入验证码", gy_LocalizableName);
    self.tips.text = kLocalizedTableString(self.tips.text, gy_LocalizableName);
    [self.sureBtn setTitle:kLocalizedTableString(@"确认", gy_LocalizableName) forState:UIControlStateNormal];
    
    self.sureBtn.backgroundColor = [UIColor lightGrayColor];
    
    [self createDefaultButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回上级页面
- (IBAction)back:(id)sender {
    if (self.isFromHomeAlert) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - 确认操作
- (IBAction)sure:(id)sender {
    
    if (self.check_box.selected == NO) {
        return;
    }
    if (_tf1.text.length==0) {
        [MBProgressHUD showText:_tf1.placeholder];
        return;
    }
    if (_tf2.text.length==0) {
        [MBProgressHUD showText:_tf2.placeholder];
        return;
    }else{
        if (_tf2.text.length>6) {
            [MBProgressHUD showText:_tf2.placeholder];
            return;
        }else if (_tf2.text.length==6){
        }else{
            [MBProgressHUD showText:_tf2.placeholder];
            return;
        }
    }
    
    if (_tf3.text.length == 0 ) {
        
        [MBProgressHUD showText:_tf3.placeholder];
        return;
    }else{
        
        if (![_tf3.text isEqualToString:_tf2.text]) {
            [MBProgressHUD showText:kLocalizedTableString(@"两次输入的密码不一致", gy_LocalizableName)];
            return;
        }
        
    }
//    if (_codeTF.text.length == 0) {
//        [MBProgressHUD showText:_inputCode_title.text];
//        return;
//    }
    if (hasVertify==NO) {
        [MBProgressHUD showText:kLocalizedTableString(_inputCode_title.text, gy_LocalizableName)];
        return;
    }
    // 存储密码到钥匙串
    [PassWordTool savePassWord:self.tf2.text];
    NSString *psw = [PassWordTool readPassWord];
    SSLog(@"%@",psw);
    
    // 跳转
    SSBackupWalletViewController *vc =[[SSBackupWalletViewController alloc] init];
    vc.userName = self.tf1.text;
    [self.navigationController pushViewController:vc animated:YES];
    
}
// 复选框点击
- (IBAction)check_box_click:(id)sender {
    self.check_box.selected = !self.check_box.selected;
    if (_check_box.selected) {
        _sureBtn.backgroundColor = Bluecolor;
    }else{
        _sureBtn.backgroundColor = [UIColor grayColor];
    }
}
- (void)createDefaultButton {
    //添加验证按钮到父视图上
//    self.captchaButton.center = CGPointMake(self.view.center.x, self.view.center.y + 76);
    self.captchaButton.center = CGPointMake(self.view.center.x , self.view.center.y-94);
    //推荐直接开启验证
    [self.captchaButton startCaptcha];
    [self.view addSubview:self.captchaButton];
}
- (GT3CaptchaButton *)captchaButton {
    if (!_captchaButton) {
        //创建验证管理器实例
        GT3CaptchaManager *captchaManager = [[GT3CaptchaManager alloc] initWithAPI1:api_1 API2:api_2 timeout:5.0];
        captchaManager.delegate = self;
        captchaManager.maskColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
        
        //debug mode
        //        [captchaManager enableDebugMode:YES];
        //创建验证视图的实例
        _captchaButton = [[GT3CaptchaButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) captchaManager:captchaManager];
    }
    return _captchaButton;
}

/** 修改API1的请求 */
- (void)gtCaptcha:(GT3CaptchaManager *)manager willSendRequestAPI1:(NSURLRequest *)originalRequest withReplacedHandler:(void (^)(NSURLRequest *))replacedHandler {
    NSMutableURLRequest *mRequest = [originalRequest mutableCopy];
    NSString *newURL = [NSString stringWithFormat:@"%@?t=%.0f", originalRequest.URL.absoluteString, [[[NSDate alloc] init]timeIntervalSince1970]];
    mRequest.URL = [NSURL URLWithString:newURL];
    
    replacedHandler(mRequest);
}
@end

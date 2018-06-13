//
//  SSCreatePurseViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/29.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSCreatePurseViewController.h"
#import "SSBackupWalletViewController.h"
@interface SSCreatePurseViewController ()
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

@property (weak, nonatomic) IBOutlet UILabel *inputCode_title;
// 提示
@property (weak, nonatomic) IBOutlet UILabel *tips;


/**
 底部提示信息框
 */
@property (weak, nonatomic) IBOutlet UIView *bottomTipView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation SSCreatePurseViewController

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
    SSBackupWalletViewController *vc =[[SSBackupWalletViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end

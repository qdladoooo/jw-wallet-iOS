//
//  SSBackupWalletViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/2.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSBackupWalletViewController.h"
#import "SSBackupMemorizingWordsVC.h"
@interface SSBackupWalletViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nav_title;
@property (weak, nonatomic) IBOutlet UILabel *backupYourWallet_title;
@property (weak, nonatomic) IBOutlet UILabel *backupTips_label;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation SSBackupWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = YES;
    self.nav_title.text = kLocalizedTableString(@"备份钱包", gy_LocalizableName);
    self.nav_title.font = [UIFont boldSystemFontOfSize:15];
    self.backupYourWallet_title.text = kLocalizedTableString(@"立即备份你的钱包！", gy_LocalizableName);
    self.backupYourWallet_title.font = [UIFont boldSystemFontOfSize:15];
    self.backupTips_label.text = kLocalizedTableString(_backupTips_label.text, gy_LocalizableName);
    [self.sureBtn setTitle:kLocalizedTableString(@"确认", gy_LocalizableName) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 返回
- (IBAction)backAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
// 确认
- (IBAction)sure:(id)sender {
//    [self passwordAlert]; // 验证密码
    SSBackupMemorizingWordsVC *vc = [[SSBackupMemorizingWordsVC alloc] init];
    vc.userName = self.userName;
    vc.password = self.password;
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - 密码输入框
-(void)passwordAlert{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"" message:kLocalizedTableString(@"请输入密码", gy_LocalizableName) preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = kLocalizedTableString(@"请输入密码", gy_LocalizableName);
        textField.layer.borderColor = Bluecolor.CGColor;
        textField.layer.borderWidth = 1.0f;
        textField.textColor = [UIColor darkGrayColor];
        textField.font = [UIFont systemFontOfSize:14];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.secureTextEntry = YES;
        
        
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:kLocalizedTableString(@"确认", gy_LocalizableName)  style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * passwordfiled = textfields[0];
        NSLog(@"%@",passwordfiled.text);
        
        if ([passwordfiled.text isEqualToString:self.password]) {
            SSBackupMemorizingWordsVC *vc = [[SSBackupMemorizingWordsVC alloc] init];
            vc.userName = self.userName;
            vc.password = self.password;
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
               [SJAlert createAlertWithMessage:kLocalizedTableString(@"密码输入错误", gy_LocalizableName) controller:self];
        }
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:kLocalizedTableString(@"取消", gy_LocalizableName) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // 取消
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end

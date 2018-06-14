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
    self.backupYourWallet_title.text = kLocalizedTableString(@"立即备份你的钱包！", gy_LocalizableName);
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
    SSBackupMemorizingWordsVC *vc = [[SSBackupMemorizingWordsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

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

/**
 底部提示信息框
 */
@property (weak, nonatomic) IBOutlet UIView *bottomTipView;

@end

@implementation SSCreatePurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.bottomTipView.layer.borderWidth = 1;
    self.bottomTipView.layer.borderColor = rgba(105, 200, 250, 1).CGColor;
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

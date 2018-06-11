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

@end

@implementation SSCreatePurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
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

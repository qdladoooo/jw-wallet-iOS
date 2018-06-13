//
//  SSGetMoneyViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/28.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSGetMoneyViewController.h"
#import "SGQRCode.h"
@interface SSGetMoneyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nav_title;

@property (weak, nonatomic) IBOutlet UILabel *getMoneyFromOthers_title;

@property (weak, nonatomic) IBOutlet UIButton *clickBtnToCopyAddress;

/**
 收款地址
 */
@property (weak, nonatomic) IBOutlet UILabel *address;

/**
 二维码
 */
@property (weak, nonatomic) IBOutlet UIImageView *codeImg;

@end

@implementation SSGetMoneyViewController
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nav_title.text = kLocalizedTableString(@"收款", gy_LocalizableName);
    self.getMoneyFromOthers_title.text = kLocalizedTableString(@"向他人扫码收款", gy_LocalizableName);
    [self.clickBtnToCopyAddress setTitle:kLocalizedTableString(@"复制收款地址", gy_LocalizableName) forState:UIControlStateNormal];
    self.fd_prefersNavigationBarHidden = YES;
    // 生成二维码(Default)
    [self setupGenerateQRCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - 复制收款地址
- (IBAction)copy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.address.text;
    
    [MBProgressHUD showText:kLocalizedTableString(@"复制成功", gy_LocalizableName)];
   
}

// 生成二维码
- (void)setupGenerateQRCode {
    _codeImg.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:@"https://www.baidu.com" imageViewWidth:_codeImg.width];
}

@end

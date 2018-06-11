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
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = YES;
    // 生成二维码(Default)
    [self setupGenerateQRCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - 赋值收款地址
- (IBAction)copy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.address.text;
    NSLog(@"%@",pasteboard.string);
   
}

// 生成二维码
- (void)setupGenerateQRCode {
    _codeImg.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:@"https://www.baidu.com" imageViewWidth:_codeImg.width];
}

@end

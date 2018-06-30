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
@property (weak, nonatomic) IBOutlet UIView *backview;

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
    [self addGradualLayer];
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
- (void)addGradualLayer{
    //渐变图层
    CAGradientLayer *gradientlayer1 = [CAGradientLayer layer];
    gradientlayer1.startPoint = CGPointMake(0.5, 0);
    gradientlayer1.endPoint = CGPointMake(0.5, 1);
    gradientlayer1.frame = self.backview.bounds;
    NSArray *colorAry1 = [NSArray arrayWithObjects:(id)rgba(28  , 43, 79, 1).CGColor,rgba(7, 12, 47, 1).CGColor, nil];
    gradientlayer1.colors = colorAry1;
    [self.backview.layer insertSublayer:gradientlayer1 atIndex:0];
}
@end

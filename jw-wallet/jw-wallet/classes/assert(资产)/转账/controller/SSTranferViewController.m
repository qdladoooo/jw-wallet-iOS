//
//  SSTranferViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/28.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSTranferViewController.h"

@interface SSTranferViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nav_title;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *transMoney;
@property (weak, nonatomic) IBOutlet UITextField *remark;
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (weak, nonatomic) IBOutlet UISlider *slider;


@property (weak, nonatomic) IBOutlet UILabel *transferInformation_title;
@property (weak, nonatomic) IBOutlet UILabel *personFees_title;
@property (weak, nonatomic) IBOutlet UILabel *slowly_title;
@property (weak, nonatomic) IBOutlet UILabel *fast_title;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UIButton *wenhao;

@end

@implementation SSTranferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    // 国际化
    self.nav_title.text = kLocalizedTableString(@"转账", gy_LocalizableName);
    
    self.transferInformation_title.text = kLocalizedTableString(@"转账信息", gy_LocalizableName);
    self.personFees_title.text = kLocalizedTableString(@"矿工费用", gy_LocalizableName);
    self.address.placeholder = kLocalizedTableString(@"收款人钱包地址", gy_LocalizableName);
    self.transMoney.placeholder = kLocalizedTableString(@"转账金额", gy_LocalizableName);
    self.remark.placeholder = kLocalizedTableString(@"备注", gy_LocalizableName);
    self.slowly_title.text = kLocalizedTableString(@"慢", gy_LocalizableName);
    self.fast_title.text = kLocalizedTableString(@"快", gy_LocalizableName);
    [self.sureBtn setTitle:kLocalizedTableString(@"确认", gy_LocalizableName) forState:UIControlStateNormal];
    
    self.address.layer.borderColor = BORDER_COLOR.CGColor;
//    self.transMoney.layer.borderColor = BORDER_COLOR.CGColor;
    self.remark.layer.borderColor = BORDER_COLOR.CGColor;
    
    self.address.layer.borderWidth = 0.5f;
//    self.transMoney.layer.borderWidth = 0.5f;
    self.remark.layer.borderWidth = 0.5f;
    self.slider.maximumTrackTintColor = rgba(235,237,245,1);
    self.slider.minimumTrackTintColor = rgba(26,154,252,1);
    
    [self setTextField];
    
    // 扫描结果不为空，用解析地址填充第一栏信息
    if (_jump_URL!=nil) {
        _address.text = _jump_URL;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTextField{
//    在uitextfield 中文字最左边距离左侧边框的距离
    self.address.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 51)];
    self.transMoney.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 51)];
    self.remark.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 51)];
    
    self.address.leftViewMode=UITextFieldViewModeAlways;
    self.transMoney.leftViewMode=UITextFieldViewModeAlways;
    self.remark.leftViewMode=UITextFieldViewModeAlways;
    
}

- (IBAction)sliderChangeValue:(id)sender {
    self.value.text = [NSString stringWithFormat:@"%f ether",self.slider.value];
}
#pragma mark - 矿工费用说明
- (IBAction)question:(id)sender {
    SSGlobalWebView *web = [[SSGlobalWebView alloc] init];
    web.urlString = @"https://help-center.token.im/hc/article/115000957653";
    [self.navigationController pushViewController:web animated:YES];
}
#pragma mark - 确认
- (IBAction)sureBtn:(id)sender {
    // 地址
    if (self.address.text.length==0) {
        [MBProgressHUD showText:_address.placeholder];
        return;
    }
    // 转账金额
    if (self.transMoney.text.length == 0) {
        [MBProgressHUD showText:_transMoney.placeholder];
        return;
    }
    // 点击确认开始转账
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURLString,@"转账url"];
    NSDictionary *params = @{
                             @"地址":@"xxx",
                             @"金额":@"xxx",
                             @"矿工费用":self.value.text
                             };
    [HttpTool postWithURL:url params:params success:^(id json) {
        // 成功
    } failure:^(NSError *error) {
        [MBProgressHUD showText:[NSString stringWithFormat:@"%@",error]];
    }];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

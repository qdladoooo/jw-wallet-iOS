//
//  SSTranferViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/28.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSTranferViewController.h"
#import "FCUtility.h"
#import "AccountInfo.h"
#import "RequestUtils.h"
#import "GlobalProperties.h"
#import "TransactionInfo.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "TransactionUtils.h"
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
@property(nonatomic, strong) SocketRocketUtility *utility;

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
    if (self.transMoney.text.length==0) {
        [MBProgressHUD showText:@"请输入转账金额"];
        return;
    }
    //    矿工费用=2+len(memo) * 10 / 1024
    self.slider.minimumValue = 0;
    self.slider.maximumValue = self.transMoney.text.doubleValue;
    self.value.text = [NSString stringWithFormat:@"%.f", 2 + self.slider.value*10/1024];
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
    [self requestSocketData];

}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 请求数据
-(void)requestSocketData{
    
    self.utility = [SocketRocketUtility instance];
    [self.utility SRWebSocketOpenWithURLString:SocketBaseURLString];
    __weak __typeof(self) weakSelf = self;
    if (self.utility.didOpen) {
        
        [weakSelf transactionTest1];
    }
    
    self.utility.didReceiveMessage = ^(id message) {
        //收到服务端发送过来的消息
        id result = [FCUtility toOCData:message];
        switch ([result[@"id"] integerValue]) {
            case GET_DYNAMIC_GLOBAL_PROPERTIES: {
                GlobalProperties *info = [GlobalProperties yy_modelWithJSON:message];
                NSLog(@"GlobalProperties");
                
                [weakSelf transactionTest2:info];
                
                break;
            }
                
            default:
                break;
        }
        
        SSLog(@"reciveMessage:%@",message);
    };
}

- (void)transactionTest1 {
    
    NSString *login = @"{\"method\": \"call\", \"params\": [1, \"login\", [\"\", \"\"]], \"jsonrpc\": \"2.0\", \"id\": 1}";
    [self.utility sendData:login];
    NSString *network_broadcast = @"{\"method\": \"call\", \"params\": [1, \"network_broadcast\", []], \"jsonrpc\": \"2.0\", \"id\": 2}";
    [self.utility sendData:network_broadcast];
    NSString *get_dynamic_global_properties = [RequestUtils get_dynamic_global_properties];
    [self.utility sendData:get_dynamic_global_properties];
    
}

- (void)transactionTest2:(GlobalProperties *)globalProperties {
    
    TransactionInfo *transactionInfo = [[TransactionInfo alloc] init];
//    transactionInfo.amountAmount = 100000000;
//    transactionInfo.amountAssetId = @"1.3.0";
    //    transactionInfo.feeAmount = 200000;
    //    transactionInfo.feeAssetId = @"1.3.0";
    //    transactionInfo.from = @"1.2.22";
    //    transactionInfo.to = @"1.2.6";
//    矿工费用单位是RISK，此处设计图有问题没有快慢，手续费构成分两部分，固定费用部分2RISK，浮动部分由备注长度决定，具体计算公式为
//    矿工费用=2+len(memo) * 10 / 1024
    
    transactionInfo.amountAmount = self.transMoney.text.integerValue;
    transactionInfo.amountAssetId = self.AssetID;
    transactionInfo.feeAmount = self.value.text.integerValue;
    transactionInfo.feeAssetId = self.AssetID;
    transactionInfo.from = self.AccountID;
    transactionInfo.to = self.address.text;
    transactionInfo.wif = @"5JKX2Khfi19nZN6Z5AqTQNafp2sVGTYhN2vpZep5sSNtq1FKbmh";
    
    JSContext *context = [[JSContext alloc] init];
    NSString *js = @"function readUint32( tid, data, offset ){var hexNum= data.substring(2*offset+6,2*offset+8)+data.substring(2*offset+4,2*offset+6)+data.substring(2*offset+2,2*offset+4)+data.substring(2*offset,2*offset+2);var ret = parseInt(hexNum,16).toString(10);return(ret)}";
    [context evaluateScript:js];
    JSValue *n = [context[@"readUint32"] callWithArguments:@[@8, globalProperties.result.head_block_id, @4]];
    
    transactionInfo.refBlockNum = (globalProperties.result.head_block_number & 0xFFFF);
    transactionInfo.refBlockPrefix = n.toNumber.intValue;
    
    NSString *transaction = [TransactionUtils initTransaction:transactionInfo];
    
    NSString *wholeTransaction = [RequestUtils broadcast_transaction_synchronous:transaction];
    NSLog(@"transactionInfo==>%@", wholeTransaction);
    
    [self.utility sendData:wholeTransaction];
    
}
@end

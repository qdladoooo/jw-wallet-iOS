//
//  SSAsertViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/26.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAsertViewController.h"
#import "SSAsertHearView.h"
#import "SSAsertCell.h"
#import "SSAsertDetailVC.h"
#import "SSManagerPurseViewController.h"
#import "WCQRCodeScanningVC.h"
#import "SSHomeCoverVC.h"
#import "SSAssetsAlert.h"
#import "SSAddAssertsVC.h"
#import "RequestUtils.h"
@interface SSAsertViewController ()<UITableViewDataSource, UITableViewDelegate,SRWebSocketDelegate>
@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, strong) NSArray* dataArr;/**< array */
//@property (nonatomic, strong) UIView *navgationView;
@property(nonatomic, strong) UIView *nav_view;


@property(nonatomic, strong) SocketRocketUtility *utility;
@end

@implementation SSAsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    
    [self buildTableView];
    _dataArr = @[@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4"];

    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // 启动图- 创建/导入钱包
    [self checkVersion];
    
    
    [self navigationView];
    
    [self requestSocketData];
    
    // 弹窗
    SSAssetsAlert *alert = [SSAssetsAlert showAseestAlert];
    __weak typeof (self) weakSelf = self;
   alert.AddAssetsBlock = ^(){
        SSAddAssertsVC *vc = [[SSAddAssertsVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };

    
}
#pragma mark - 设置导航栏透明
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat y = self.tableView.contentOffset.y;
    if (y > 145) {
        _nav_view.backgroundColor = rgba(7, 12, 47, 1);
    } else {
        _nav_view.backgroundColor = rgba(7, 12, 47, y/145);
    }
    // 背景色
    if (self.tableView.contentOffset.y>0) {
        self.tableView.backgroundColor = BACKGROUNDCOLOR;
    }else{
        self.tableView.backgroundColor = [UIColor clearColor];
    }

}
#pragma mark - TableView
- (void)buildTableView {
    
    // 头部背景
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    view.backgroundColor = MAIN_GROUNDCOLOR;
    [self.view addSubview:view];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = MAIN_GROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

//tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSAsertCell *cell = [SSAsertCell cellWithTableView:tableView];
    if (indexPath.row!=0) {
        cell.darkView.hidden = YES;
    }
    if (indexPath.row==0 || indexPath.row == 2) {
        cell.icon.image = [UIImage imageNamed:@"btc"];
        cell.name1.text = @"BTC";
        cell.name2.text = cell.name1.text;
    }else{
        cell.icon.image = [UIImage imageNamed:@"eth"];
        cell.name1.text = @"ETH";
        cell.name2.text = cell.name1.text;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSAsertDetailVC *vc = [[SSAsertDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 230;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SSAsertHearView *header = [[[NSBundle mainBundle] loadNibNamed:@"SSAsertHearView" owner:nil options:nil] lastObject];
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"walletName"];
    if (name.length) {
        [header.walletNameBtn setTitle:name forState:UIControlStateNormal];
    }else{
        [header.walletNameBtn setTitle:@"" forState:UIControlStateNormal];
    }
    
    return header;

}




#pragma mark - 头部按钮点击
-(void)purse{
    SSManagerPurseViewController *vc = [[SSManagerPurseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark - 扫一扫
-(void)scan{
    WCQRCodeScanningVC *WCScan = [[WCQRCodeScanningVC alloc] init];
    [self QRCodeScanVC:WCScan];
}

- (void)QRCodeScanVC:(UIViewController *)scanVC {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.navigationController pushViewController:scanVC animated:YES];
                        });
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                [self.navigationController pushViewController:scanVC animated:YES];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:kLocalizedTableString(@"温馨提示", gy_LocalizableName)  message:kLocalizedTableString(@"未检测到您的摄像头", gy_LocalizableName) preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:kLocalizedTableString(@"确定", gy_LocalizableName)  style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
}
#pragma mark - 导航栏view
-(void)navigationView{
    _nav_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    _nav_view.backgroundColor = [UIColor clearColor];
    // 扫描按钮
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(15, 43, 20, 20)];
    btn1.tintColor = [UIColor whiteColor];
    [btn1 setImage:[UIImage imageNamed:@"扫描"] forState:UIControlStateNormal];
    [_nav_view addSubview:btn1];
    // 钱包按钮
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-35, 43, 20, 20)];
    btn2.tintColor = [UIColor whiteColor];
    [btn2 setImage:[UIImage imageNamed:@"钱包"] forState:UIControlStateNormal];
    [_nav_view addSubview:btn2];
    [btn1 addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(purse) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav_view];
}
#pragma mark - 第一次进入
-(void)checkVersion{
    BOOL isFirstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLaunch"];
    BOOL endNewFeature = [[NSUserDefaults standardUserDefaults] boolForKey:@"EndNewFeature"];
    if (!isFirstLaunch && endNewFeature ) {
        SSHomeCoverVC *vc = [[SSHomeCoverVC alloc] init];
        [self.navigationController pushViewController:vc animated:NO];

    }

}
#pragma mark - 请求数据
-(void)requestSocketData{
    self.utility = [SocketRocketUtility instance];
    [self.utility SRWebSocketOpenWithURLString:SocketBaseURLString];
      __weak __typeof(self) weakSelf = self;
    self.utility.didOpen = ^{

       
        [weakSelf.utility sendDataWithJson:[RequestUtils get_full_accounts:@"1.2.0"]];
        NSString *json1 =[RequestUtils get_accounts:0 ids:@"1.2.0"];
        [weakSelf.utility sendDataWithJson:json1];
    };
    self.utility.didReceiveMessage = ^(id message) {
        
    };
}

- (void)SRWebSocketDidOpen {
    NSLog(@"开启成功");
    
    //在成功后需要做的操作。。。
    
    // 如果需要发送数据到服务器使用下面代码
//     { “id”：1，“method”：“call”，“params”：[ 0，“get_accounts”，[[ “1.2.0” ]]]}
    // "id":2,"method":"call","params":[1,"login",["",""]]} 登录
    //  message:{"id":2,"jsonrpc":"2.0","result":true} 登录成功
//    现在我们可以database通过:: 调用API的任何方法
//
//    >  { “id” ：1 ， “method” ：“call” ， “params” ：[ DATABASE_API_ID ，“get_accounts” ，[[ “1.2.0” ]]]}

//    NSArray *param = @[@0,@"get_accounts",@[@[@"1.2.0"]]];
//    [[SocketRocketUtility instance] sendData:param withMethod:@"call" IDStr:@"1"];
  
    // 登录
//    NSArray *arr = @[@1,@"login",@[@"buybuybuy",@"123456"]];
//    [[SocketRocketUtility instance] sendData:arr withMethod:@"call" IDStr:@"2"];
////    // get——account
//    NSArray *arr1 = @[@0,@"get_accounts",@[@[@"1.2.0"]]];
//    [[SocketRocketUtility instance] sendData:arr1 withMethod:@"call" IDStr:@"1"];
//    NSString *json =[RequestUtils get_accounts:0 ids:@"1.2.0"];
//    [[SocketRocketUtility instance] sendDataWithJson:json];
//
//    NSString *json1 = [RequestUtils get_full_accounts:@"1.2.0"];
//    [[SocketRocketUtility instance] sendDataWithJson:json1];
    // 获取资产列表信息
//    NSString *json = [RequestUtils get_assets:@"1.3.0"];
//    [[SocketRocketUtility instance] sendDataWithJson:json];
    
}


- (void)SRWebSocketDidReceiveMsg:(NSNotification *)note {
    //收到服务端发送过来的消息
    NSString * message = note.object;
    NSLog(@"message:%@",message);
/*
message: {
    "id": 3302,
    "jsonrpc": "2.0",
    "result": [{
        "id": "1.3.0",
        "symbol": "KRIS",
        "precision": 8,
        "issuer": "1.2.3",
        "options": {
            "max_supply": "1000000000000000000",
            "market_fee_percent": 0,
            "max_market_fee": "1000000000000000000",
            "issuer_permissions": 0,
            "flags": 0,
            "core_exchange_rate": {
                "base": {
                    "amount": 1,
                    "asset_id": "1.3.0"
                },
                "quote": {
                    "amount": 1,
                    "asset_id": "1.3.0"
                }
            },
            "whitelist_authorities": [],
            "blacklist_authorities": [],
            "whitelist_markets": [],
            "blacklist_markets": [],
            "description": "",
            "extensions": []
        },
        "dynamic_asset_data_id": "2.3.0"
    }]
    */

}


-(void)vertifyPersonAndMathion{
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
}
#pragma mark - 请求账户数据
//-(void)requestDate{
//    NSString *json =[RequestUtils get_accounts:0 ids:@"1.2.0"];
//    [[SocketRocketUtility instance] sendDataWithJson:json];
//
//}
@end

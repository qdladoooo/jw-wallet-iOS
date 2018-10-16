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
#import "FCUtility.h"
#import "AccountObserverFull.h"
#import "AssetsInfo.h"
#import "AccountInfo.h"
#import "AccountBalances.h"
#import "LSStretchableTableHeaderView.h"
@interface SSAsertViewController ()<UITableViewDataSource, UITableViewDelegate,SRWebSocketDelegate>
@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, strong) NSArray* dataArr;/**< array */
//@property (nonatomic, strong) UIView *navgationView;
@property(nonatomic, strong) UIView *nav_view;
@property(nonatomic,strong) LSStretchableTableHeaderView *strechView;
@property (nonatomic, strong) UIView *headBackView;
@property(nonatomic, strong) SocketRocketUtility *utility;
@property (nonatomic, strong)AccountObserverFull *infoModel;
@property (nonatomic, copy) NSMutableArray *assestsDetailsDataArr;
@property (nonatomic, copy) NSMutableArray *assestsDetailsModelArr;
/**
 资产数量
 */
@property (nonatomic, assign) NSInteger assestsCount;
@property (nonatomic, strong) AccountBalances *balanceModel;
@property (nonatomic, strong) AssetsInfo *assetsModel;
@property (nonatomic, strong) AccountInfo *AccountInfoModel;

/**
 账户余额
 */
@property (nonatomic, strong) NSString *balances;

/**
 账户ID
 */
@property (nonatomic, strong) NSString *accountID;
@end

@implementation SSAsertViewController
static int recordNumer = 0;

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
//    SSAssetsAlert *alert = [SSAssetsAlert showAseestAlert];
//    __weak typeof (self) weakSelf = self;
//   alert.AddAssetsBlock = ^(){
//        SSAddAssertsVC *vc = [[SSAddAssertsVC alloc] init];
//        [weakSelf.navigationController pushViewController:vc animated:YES];
//    };

    
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
   


}
#pragma mark - TableView
- (void)buildTableView {

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -150, SCREEN_WIDTH, SCREEN_HEIGHT+150) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WHITCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    // 头部背景
        _headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, -150, SCREEN_WIDTH, 150)];
    _headBackView.backgroundColor = MAIN_GROUNDCOLOR;
        [self.view addSubview:_headBackView];    
    LSStretchableTableHeaderView *strechView=[LSStretchableTableHeaderView stretchHeaderForTableView:self.tableView headerView:self.tableView.tableHeaderView withView:_headBackView];
    self.strechView =strechView;
    
}

//tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.assestsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSAsertCell *cell = [SSAsertCell cellWithTableView:tableView];
    if (indexPath.row!=0) {
        cell.darkView.hidden = YES;
    }
    cell.icon.image = [UIImage imageNamed:@"eos"];
    if (indexPath.row<self.assestsCount) {
        cell.name1.text = self.assetsModel.result[indexPath.row].symbol;
        CGFloat amount = self.balanceModel.result[indexPath.row].amount.doubleValue;
        NSInteger precision = self.assetsModel.result[indexPath.row].precision;
//        amount / 10^precision
        cell.name2.text = [NSString stringWithFormat:@"%.2f",amount/pow(10, precision)];
        self.balances = cell.name2.text;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSAsertDetailVC *vc = [[SSAsertDetailVC alloc] init];
    vc.AssetID = self.assetsModel.result[indexPath.row].ID;
    vc.AccountID = self.accountID;
    CGFloat amount = self.balanceModel.result[indexPath.row].amount.doubleValue;
    NSInteger precision = self.assetsModel.result[indexPath.row].precision;
    //        amount / 10^precision
     vc.balances = [NSString stringWithFormat:@"%.2f",amount/pow(10, precision)];
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
        header.walletName.text = self.AccountInfoModel.result[0].name;
    NSString *walletID = [NSString stringWithFormat:@"ID:%@",self.AccountInfoModel.result[0].ID];
    [header.walletNameAdressBtn setTitle:walletID forState:UIControlStateNormal];
    
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
    NSString *lookup_account_names = [RequestUtils lookup_account_names:@"w200"];
    NSString *get_account_balances = [RequestUtils get_account_balances:@"1.2.22"];
    NSString *get_assets = [RequestUtils get_assets:@"1.3.0"];
    self.utility.didOpen = ^{

        [weakSelf.utility sendData:lookup_account_names];
    };
    self.utility.didReceiveMessage = ^(id message) {
        id result = [FCUtility toOCData:message];
        switch ([result[@"id"] integerValue]) {
            case LOOKUP_ACCOUNT_NAMES_ID: {
                AccountInfo *info = [AccountInfo yy_modelWithJSON:message];
                weakSelf.AccountInfoModel = info;
                NSString *ID =  info.result[0].ID;
                weakSelf.accountID = ID;
                NSString *get_account_balances = [RequestUtils get_account_balances:ID];
                [weakSelf.utility sendData:get_account_balances];
                
                // 获取账户历史数据
//                NSString *get_account = [RequestUtils get_accounts:ID];
//                [weakSelf.utility sendData:get_account];
                NSString *get_account_history = [RequestUtils get_account_history:ID];
                [weakSelf.utility sendData:get_account_history];
                NSLog(@"AccountInfo");
                break;
            }
            case GET_ACCOUNT_BALANCES_ID: {
                // 获取资产详情
                AccountBalances *info = [AccountBalances yy_modelWithJSON:message];
                weakSelf.balanceModel = info;
                NSMutableArray *idArr = [NSMutableArray array];
                for (int i = 0; i<info.result.count; i++) {
                    NSString *assetsIDS = info.result[i].asset_id;
                    [idArr addObject:assetsIDS];
                }
            
                NSString *str = [idArr componentsJoinedByString:@"\",\""];
                SSLog(@"%@",str);
                NSString *get_assets = [RequestUtils get_assets:str];
                [weakSelf.utility sendData:get_assets];
                weakSelf.assestsCount = info.result.count;
                NSLog(@"AccountBalances");
                break;
            }
            case GET_FULL_ACCOUNTS_ID:
            {
                weakSelf.infoModel = [AccountObserverFull yy_modelWithJSON:message];
                NSString *idStr = [NSString stringWithFormat:@"%ld",weakSelf.infoModel.ID];
                NSString *get_assets = [RequestUtils get_assets:@"1.2.0"];
                [weakSelf.utility sendData:get_assets];
                
                break;
            }
            case GET_ASSETS_ID: {
                    weakSelf.assetsModel = [AssetsInfo yy_modelWithJSON:message];
            
                    NSString *symbol = weakSelf.assetsModel.result[0].symbol;
                    NSString *precision = [NSString stringWithFormat:@"%ld",weakSelf.assetsModel.result[0].precision];
                SSLog(@"symbol:%@,precision:%@",symbol,precision);
                    [weakSelf.tableView reloadData];
                NSLog(@"AssetsInfo");
                break;
                
            }
            case GET_ACCOUNTS_HISTORY:
            {
                NSLog(@"get_account_history");
                break;
            }
            default:
                break;
        }
        SSLog(@"ReciveMessage:%@",message);
    };
}





- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
}

@end

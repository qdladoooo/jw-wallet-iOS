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
@interface SSAsertViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, strong) NSArray* dataArr;/**< array */
//@property (nonatomic, strong) UIView *navgationView;
@property(nonatomic, strong) UIView *nav_view;
@end

@implementation SSAsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self buildTableView];
    _dataArr = @[@"1",@"2",@"3",@"4"];

    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // 启动图- 创建/导入钱包
    [self checkVersion];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self navigationView];
}
#pragma mark - 设置导航栏透明
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = self.tableView.contentOffset.y;
    if (y > 145) {
        _nav_view.backgroundColor = rgba(0, 10, 42, 1);
    } else {
        _nav_view.backgroundColor = rgba(0, 10, 42, y/145);
    }
}
#pragma mark - TableView
- (void)buildTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:24 green:244 blue:255 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

//tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _dataArr.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSAsertCell *cell = [SSAsertCell cellWithTableView:tableView];
    if (indexPath.row!=0) {
        cell.darkView.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSAsertDetailVC *vc = [[SSAsertDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 230;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   UIView *headview = [SSAsertHearView createAsertHearView];
    return headview;
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
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
}
#pragma mark - 导航栏view
-(void)navigationView{
    _nav_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    _nav_view.backgroundColor = [UIColor clearColor];
    // 扫描按钮
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    btn1.tintColor = [UIColor whiteColor];
    [btn1 setImage:[UIImage imageNamed:@"扫描"] forState:UIControlStateNormal];
    [_nav_view addSubview:btn1];
    // 钱包按钮
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 20, 40, 40)];
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
@end

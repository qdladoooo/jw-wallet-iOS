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
#import "SJLaunchPageView.h"
#import "WCQRCodeScanningVC.h"

@interface SSAsertViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, strong) NSArray* dataArr;/**< array */
//@property (nonatomic, strong) UIView *navgationView;
@property(nonatomic, strong) UIView *nav_view;
@end

@implementation SSAsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [self setNavComponent];
    [self buildTableView];
    _dataArr = @[@"1",@"2",@"3",@"4"];

    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // 启动图
    [SJLaunchPageView showLaunchPageView];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self navigationView];
}
#pragma mark - 设置导航栏透明
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"toumingbeijing"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setNavComponent {
//    self.navAlpha = 0;
//    self.navTintColor = [UIColor colorWithRed:0 green:10 blue:41 alpha:1];;
//    self.navTitleColor = [UIColor whiteColor];
//    self.navBackgroundColor = [UIColor colorWithRed:0 green:10 blue:41 alpha:1];
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriRenderingImage:@"purse"] style:UIBarButtonItemStylePlain target:self action:@selector(scan)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriRenderingImage:@"purse"] style:UIBarButtonItemStylePlain target:self action:@selector(purse)];
    
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



//根据滑动尺寸改变透明度
- (UIImage *)getImageWithAlpha:(CGFloat)alpha {
    
//    UIColor *color = [UIColor colorWithRed:251/255.0 green:249/255.0 blue:248/255.0 alpha:alpha];
    UIColor *color = MAIN_GROUNDCOLOR;
    CGSize colorSize = CGSizeMake(1, 1);
    
    //UIGraphicsBeginImageContext（）获取指定需要截取color的size
    UIGraphicsBeginImageContext(colorSize);
    //得到当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //用颜色填充
    CGContextSetFillColorWithColor(context, color.CGColor);
    //每个截取到的上下文中需要填充的模板的frame
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//-(void)navigationView{
//    _navgationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
//    _navgationView.backgroundColor = MAIN_GROUNDCOLOR;
//    [self.view addSubview:_navgationView];
//}

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

-(void)navigationView{
    _nav_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    _nav_view.backgroundColor = [UIColor clearColor];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 60, 60)];
    btn1.tintColor = [UIColor whiteColor];
    [btn1 setImage:[UIImage imageNamed:@"purse"] forState:UIControlStateNormal];
    [_nav_view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 20, 60, 60)];
    btn2.tintColor = [UIColor whiteColor];
    [btn2 setImage:[UIImage imageNamed:@"purse"] forState:UIControlStateNormal];
    [_nav_view addSubview:btn2];
    [btn1 addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(purse) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav_view];
}
@end

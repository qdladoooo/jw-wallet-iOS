//
//  SSAccountViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/26.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAccountViewController.h"
#import "SSAccoutCell.h"
#import "SSAccoutHeaderView.h"
#import "SSLanguageSetVC.h"
#import "SSUnitSetViewController.h"
#import "SSChangePasswordVC.h"
#import "SSHelpCenterViewController.h"
#import "SSAppShareViewController.h"
#import "SSInviteCodeShare.h"
#import "SSInviteCodeShareCell.h"
#import "SSTouchIDSetCell.h"
#import "SSTouchIDVC.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "RequestUtils.h"
#import "SSAccountModel.h"
#import "FCUtility.h"
#import "AccountInfo.h"
@interface SSAccountViewController ()<UITableViewDelegate,UITableViewDataSource,SRWebSocketDelegate>
@property (nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSString *launguageShow;
@property (nonatomic, strong) NSString *unitShow;
@property (nonatomic, strong) NSString *status1;
@property (nonatomic, strong) NSString *status2;

@property (nonatomic, copy) NSString *accountName;
@property (nonatomic, copy) NSString *accountID;
@property (nonatomic, strong) SSAccountModel *accountModel;
/**
 开关状态数据源
 */
@property (nonatomic, copy) NSArray *statusArr;
@property (nonatomic, strong)  SSAccoutHeaderView *header;
@property(nonatomic, strong) SocketRocketUtility *utility;
@property (nonatomic, strong) AccountInfo *AccountInfoModel;
@end

@implementation SSAccountViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.fd_prefersNavigationBarHidden = YES;

    [self buildTableView];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self requestSocketData];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 语言设置
    NSString *currentLanguage = kLanguageManager.currentLanguage;
    if ([currentLanguage isEqualToString:@"zh-Hant"]) {
        _launguageShow = @"繁体中文";
    }else if([currentLanguage isEqualToString:@"en"]){
        _launguageShow = @"EngLish";
    }else{
        _launguageShow = @"";
    }
    // 货币设置
    BOOL USD = [[NSUserDefaults standardUserDefaults] boolForKey:@"USD"];
    BOOL CNY = [[NSUserDefaults standardUserDefaults] boolForKey:@"CNY"];
    if (USD) {
        _unitShow = @"USD";
    }else if (CNY){
        _unitShow = @"CNY";
    }else{
        _unitShow = @"";
    }
    
    // 开关状态
    BOOL status1 = [UserDefaultUtil boolValueForKey:TouchIdLogIn];
    BOOL status2 = [UserDefaultUtil boolValueForKey:TouchIdPay];
  
    _status1 = status1?@"1":@"0";
    _status2 = status2?@"1":@"0";
    
    _statusArr = @[_status1,_status2];

    [self.tableView reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (void)buildTableView {
    // 头部背景
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    view.backgroundColor = MAIN_GROUNDCOLOR;
    [self.view addSubview:view];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 去除多余的cell
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorColor = BACKGROUNDCOLOR;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
}
#pragma mark - tablewView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section == 1){
        return 3;
    }else{
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 70;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        if (SCREEN_HEIGHT == 812) {
            return 179;
        }else{
            return 157;
        }
    }else{
        return 44;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
// datasource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
       NSInteger index = indexPath.row;
    if (indexPath.section == 0) {
        SSInviteCodeShareCell *cell = [SSInviteCodeShareCell cellWithTableView:tableView];
        return cell;
    }else if (indexPath.section == 1){
        SSAccoutCell *cell = [SSAccoutCell cellWithTableView:tableView];
        switch (index) {
            case 0:
                cell.title.text = kLocalizedTableString(@"帮助中心", gy_LocalizableName);
                break;
            case 1:
            
                cell.title.text = kLocalizedTableString(@"语言设置", gy_LocalizableName);
                cell.title2.hidden = NO;
                cell.title2.text = _launguageShow;
                break;
            
            case 2:
                cell.title.text = kLocalizedTableString(@"货币单位", gy_LocalizableName);
                cell.title2.hidden = NO;
                cell.title2.text = _unitShow;
                break;
                
            default:
                break;
        }
        return cell;
        
    }else if (indexPath.section == 2){
        SSTouchIDSetCell *cell = [SSTouchIDSetCell cellWithTableView:tableView];
        // 开关状态
        [cell.switchStatus setOn:[_statusArr[index] boolValue]];
        // 点击开关
        cell.switchclickBlock = ^(BOOL onOrOff) {
            if (index==0) {// 指纹登录开关
                [UserDefaultUtil saveBoolValue:onOrOff forKey:TouchIdLogIn];
                if (onOrOff) {
//                    [self verifyTouchId];
                }
            }else{
                // 指纹支付
                [UserDefaultUtil saveBoolValue:onOrOff forKey:TouchIdPay];
            }
        };
        
        switch (index) {
            case 0:
                
                cell.title.text = kLocalizedTableString(@"启用指纹登录", gy_LocalizableName);
                
                break;
            case 1:
                cell.title.text = kLocalizedTableString(@"启用指纹支付", gy_LocalizableName);
                
                break;
                
            default:
                break;
        }

        return cell;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        self.header = [[[NSBundle mainBundle] loadNibNamed:@"SSAccoutHeaderView" owner:nil options:nil] lastObject];
        self.header.accountId.text = [NSString stringWithFormat:@"ID: %@",self.AccountInfoModel.result[0].ID];
        self.header.accountName.text = self.AccountInfoModel.result[0].name;
        return self.header;
    }else{
        UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        sectionHeader.backgroundColor = BACKGROUNDCOLOR;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, sectionHeader.bounds.size.height-14-10, 200, 14)];
        if (section==1) {
            label.text = kLocalizedTableString(@"基本信息", gy_LocalizableName);
        }else if (section==2){
            label.text = kLocalizedTableString(@"设置", gy_LocalizableName);
        }
        [label setFont:[UIFont systemFontOfSize:12]];
        label.textColor = FONT_DARKGRAYCOLOR;
        [sectionHeader addSubview:label];
        
        return sectionHeader;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SSInviteCodeShare *vc = [[SSInviteCodeShare alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
//            SSHelpCenterViewController *vc = [[SSHelpCenterViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
            SSGlobalWebView *helpWeb = [[SSGlobalWebView alloc] init];
            helpWeb.titleName = kLocalizedTableString(@"帮助中心", gy_LocalizableName);
            helpWeb.urlString = @"https://help-center.token.im/hc?locale=zh-cn";
            [self.navigationController pushViewController:helpWeb animated:YES];
        }else if (indexPath.row == 1){
            SSLanguageSetVC *vc = [[SSLanguageSetVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 2){
            SSUnitSetViewController *vc = [[SSUnitSetViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

        }
    }
    
}


#pragma mark - 弹出Touch ID系统框
- (void)verifyTouchId
{
    [[SSTouchIDVC shareInstance] verifyTouchId:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 验证成功");// 登录成功
                
            });
        }else if(error){
            switch (error.code) {
                case LAErrorAuthenticationFailed:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 验证失败");// 验证手势密码
                        
                    });
                    break;
                }
                case LAErrorUserCancel:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 被用户手动取消");//验证手势密码
                    });
                }
                    break;
                case LAErrorUserFallback:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"用户不使用TouchID,选择手动输入密码");
//                        [MBProgressHUD showNoImageMessage:@"用户不使用TouchID，重新验证手势"];
                    });
                }
                    break;
                case LAErrorSystemCancel:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");//验证手势密码
//                        [MBProgressHUD showNoImageMessage:@"TouchID 被系统取消，重新验证手势"];
                    });
                }
                    break;
                case LAErrorPasscodeNotSet:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 无法启动,因为用户没有设置密码");
//                        [MBProgressHUD showNoImageMessage:@"TouchID 无法启动，重新验证手势"];
                    });
                }
                    break;
                case LAErrorTouchIDNotEnrolled:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 无法启动,因为用户没有设置TouchID");
//                        [MBProgressHUD showNoImageMessage:@"用户没有设置TouchID，重新验证手势"];
                    });
                }
                    break;
                case LAErrorTouchIDNotAvailable:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 无效");
//                        [MBProgressHUD showNoImageMessage:@"TouchID 无效，重新验证手势"];
                    });
                }
                    break;
                case LAErrorTouchIDLockout:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
//                        [MBProgressHUD showNoImageMessage:@"TouchID 被锁定，重新验证手势"];
                    });
                }
                    break;
                case LAErrorAppCancel:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                    });
                }
                    break;
                case LAErrorInvalidContext:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                    });
                }
                    break;
                default:
                    break;
            }
            
        }
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.tableView.contentOffset.y>0) {
        self.tableView.backgroundColor = BACKGROUNDCOLOR;
    }else{
       self.tableView.backgroundColor = [UIColor clearColor];
    }
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.contentSize = CGSizeMake(SCREEN_WIDTH,self.tableView.height-100);
}
#pragma mark - 请求数据
-(void)requestSocketData{
    
    self.utility = [SocketRocketUtility instance];
    [self.utility SRWebSocketOpenWithURLString:SocketBaseURLString];
    __weak __typeof(self) weakSelf = self;
     NSString *lookup_account_names = [RequestUtils lookup_account_names:@"w200"];
    if (self.utility.didOpen) {
        
        [weakSelf.utility sendData:lookup_account_names];
    }

    self.utility.didReceiveMessage = ^(id message) {
        //收到服务端发送过来的消息
        id result = [FCUtility toOCData:message];
        switch ([result[@"id"] integerValue]) {
            case LOOKUP_ACCOUNT_NAMES_ID: {
                AccountInfo *info = [AccountInfo yy_modelWithJSON:message];
                weakSelf.AccountInfoModel = info;
//                NSString *ID =  info.result[0].ID;
//                NSString *get_account_balances = [RequestUtils get_account_balances:ID];
//                [weakSelf.utility sendData:get_account_balances];
                [weakSelf.tableView reloadData];
                NSLog(@"AccountInfo");
                
                break;
            }
            
            default:
                break;
        }
    };
  
}




@end

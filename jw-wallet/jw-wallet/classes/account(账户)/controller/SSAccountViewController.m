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
@interface SSAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) UITableView* tableView;
@end

@implementation SSAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITCOLOR;
    self.fd_prefersNavigationBarHidden = YES;
    [self buildTableView];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 去除多余的cell
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView
- (void)buildTableView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:24 green:244 blue:255 alpha:1];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 0.01)];
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
            return 177;
        }else{
            return 155;
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
                cell.title.text = @"帮助中心";
                break;
            case 1:
                cell.title.text = @"语言设置";
                cell.title2.hidden = NO;
                cell.title2.text = @"繁体中文";
                break;
            case 2:
                cell.title.text = @"货币单位";
                cell.title2.hidden = NO;
                cell.title2.text = @"USD";
                break;
                
            default:
                break;
        }
        return cell;
        
    }else if (indexPath.section == 2){
        SSTouchIDSetCell *cell = [SSTouchIDSetCell cellWithTableView:tableView];
        switch (index) {
            case 0:
                cell.title.text = @"启用指纹登录";
                break;
            case 1:
                cell.title.text = @"启用指纹支付";
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
        UIView *headerView = [SSAccoutHeaderView creatHeaderView];
        return headerView;
    }else{
        UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        sectionHeader.backgroundColor = rgba(242, 246, 255, 1);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, sectionHeader.bounds.size.height-14-10, 100, 14)];
        if (section==1) {
            label.text = @"基本信息";
        }else if (section==2){
            label.text = @"设置";
        }
        [label setFont:[UIFont systemFontOfSize:14]];
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
            SSHelpCenterViewController *vc = [[SSHelpCenterViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            SSLanguageSetVC *vc = [[SSLanguageSetVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 2){
            SSUnitSetViewController *vc = [[SSUnitSetViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

        }
    }
    
}
@end

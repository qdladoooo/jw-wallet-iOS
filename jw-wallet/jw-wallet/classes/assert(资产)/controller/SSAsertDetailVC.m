//
//  SSAsertDetailVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/28.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAsertDetailVC.h"
#import "SSTradingRecordsCell.h"
#import "SSTranferViewController.h"
#import "SSGetMoneyViewController.h"
#import "SSTransRecordVC.h"
@interface SSAsertDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tablewView;
@property (weak, nonatomic) IBOutlet UILabel *nav_title;
@property (weak, nonatomic) IBOutlet UILabel *banlance_title;
@property (weak, nonatomic) IBOutlet UIButton *transfer; // 转账
@property (weak, nonatomic) IBOutlet UIButton *getMoney; // 收款
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation SSAsertDetailVC
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.nav_title.text = kLocalizedTableString(@"资产详情", gy_LocalizableName);
    self.nav_title.font = [UIFont boldSystemFontOfSize:15];
    self.banlance_title.text = kLocalizedTableString(@"账户余额",gy_LocalizableName);
    self.banlance_title.font = [UIFont boldSystemFontOfSize:15];
    [self.transfer setTitle:kLocalizedTableString(@"转账", gy_LocalizableName) forState:UIControlStateNormal];
    
    [self.getMoney setTitle:kLocalizedTableString(@"收款", gy_LocalizableName) forState:UIControlStateNormal];
    self.icon.layer.cornerRadius = 15;
    self.icon.layer.masksToBounds = YES;
//    self.title = @"资产详情";
//    if (@available(iOS 11.0, *)) {
//        self.tablewView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    self.tablewView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tablewView.backgroundColor = BACKGROUNDCOLOR;
    self.tablewView.separatorColor = BACKGROUNDCOLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

#pragma mark - UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSTradingRecordsCell *cell = [SSTradingRecordsCell cellWithTablewView:tableView];
    cell.topLine.hidden = indexPath.row==0?NO:YES;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    headerView.backgroundColor = WHITCOLOR;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    label.text = kLocalizedTableString(@"交易记录", gy_LocalizableName);
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    
    [headerView addSubview:label];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSTransRecordVC *recordVC = [[SSTransRecordVC alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
}
#pragma mark - 点击事件
// 转账
- (IBAction)transferAction:(id)sender {
    SSTranferViewController *vc = [[SSTranferViewController alloc] init];
    [self.navigationController pushViewController:vc  animated:YES];
}
// 收款
- (IBAction)getMoney:(id)sender {
    SSGetMoneyViewController *vc = [[SSGetMoneyViewController alloc] init];
    [self.navigationController pushViewController:vc  animated:YES];
}


@end

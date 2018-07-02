//
//  SSManagerPurseViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/29.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSManagerPurseViewController.h"
#import "SSPurseListCell.h"
#import "SSCreatePurseViewController.h"
#import "SSAddPurseViewController.h"
#import "SSWalletDetailVC.h"

@interface SSManagerPurseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nav_title;
@property (weak, nonatomic) IBOutlet UIButton *createBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (nonatomic, strong) SSWalletInfo *model;
/**
 钱包数据
 */
@property (nonatomic, copy) NSArray *walletDataArr;
@property (nonatomic, copy) NSMutableArray *data;
@end

@implementation SSManagerPurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor colorFromHexRGB:@"f2f6ff"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.nav_title.text = kLocalizedTableString(@"管理钱包", gy_LocalizableName);
    [self.createBtn setTitle:kLocalizedTableString(@"创建钱包", gy_LocalizableName) forState:UIControlStateNormal];
    [self.addBtn setTitle:kLocalizedTableString(@"导入钱包", gy_LocalizableName) forState:UIControlStateNormal];
    
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 读取数据库，查看钱包列表
    self.walletDataArr = [NSArray bg_arrayWithName:wallet_Info];
    
    SSLog(@"%@",self.walletDataArr);
    
    // 初始化
    self.data = [NSMutableArray array];
    
    self.data = [SSWalletInfo mj_objectArrayWithKeyValuesArray:self.walletDataArr];
    
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -  UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.walletDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSPurseListCell *cell = [SSPurseListCell cellWithTableView:tableView];

    self.model = self.data[indexPath.row];
    cell.walletName_title.text = self.model.walletName;
    return cell;
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.model = self.data[indexPath.row];
    SSWalletDetailVC *vc = [[SSWalletDetailVC alloc] init];
    vc.model = self.model;
    vc.index = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

#pragma mark - 创建钱包
- (IBAction)createPurse:(id)sender {
    SSCreatePurseViewController *vc = [[SSCreatePurseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - 导入钱包
- (IBAction)AddPurse:(id)sender {
    SSAddPurseViewController *vc = [[SSAddPurseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end

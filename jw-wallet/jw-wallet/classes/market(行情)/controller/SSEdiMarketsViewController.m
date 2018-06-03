//
//  SSEdiMarketsViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/3.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSEdiMarketsViewController.h"
#import "SSSectionHeaderView.h"
#import "SSEditMarketsCell.h"
@interface SSEdiMarketsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SSEdiMarketsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.tableView.backgroundColor = MAIN_GROUNDCOLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSEditMarketsCell *cell = [SSEditMarketsCell cellWithTableView:tableView];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SSSectionHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"SSSectionHeaderView" owner:nil options:nil] lastObject];
    headerView.title1.text = @"资产名称";
    headerView.title2.text = @"提醒";
    headerView.title3.text = @"拖动排序";
    return headerView;
}








@end

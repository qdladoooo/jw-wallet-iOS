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
@interface SSAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) UITableView* tableView;
@end

@implementation SSAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITCOLOR;
    self.navigationController.navigationBarHidden = YES;
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
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:24 green:244 blue:255 alpha:1];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
#pragma mark - tablewView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else{
        return 3;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 155;
    }else{
        return 44;
    }
}
// datasource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSAccoutCell *cell = [SSAccoutCell cellWithTableView:tableView];
    NSInteger index = indexPath.row;
    if (indexPath.section==1) {
        switch (index) {
            case 0:
                cell.title.text = @"帮助中心";
                break;
            case 1:
                cell.title.text = @"分享邀请码";
                break;
            case 2:
                cell.title.text = @"应用推荐";
                break;
                
            default:
                break;
        }
    }else if (indexPath.section==2){
        switch (index) {
            case 0:
                cell.title.text = @"支付设置";
                break;
            case 1:
                cell.title.text = @"语言设置";
                cell.title2.hidden = NO;
                cell.title2.text = @"简体文";
                break;
            case 2:
                cell.title.text = @"货币单位";
                cell.title2.hidden = NO;
                cell.title2.text = @"USD";
                break;
                
            default:
                break;
        }
    }
   
    return cell;
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

}
@end

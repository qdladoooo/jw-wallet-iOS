//
//  SSMarktViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/26.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSMarktViewController.h"
#import "SSMarketCell.h"
#import "SSSectionHeaderView.h"
#import "SSAddMarketsViewController.h"
#import "SSMarketsDetalViewController.h"
#import "SSEdiMarketsViewController.h"
#import "SSNavigationBar.h"
@interface SSMarktViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation SSMarktViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.fd_prefersNavigationBarHidden = YES;
//    UIView  *nav = [SSNavigationBar creatNavigationBar];
//    nav.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
//    [self.view addSubview:nav];
    
    self.title = @"行情";
    [self buildTableView];
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"..." style:UIBarButtonItemStylePlain target:self action:@selector(marketsControll)];

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
#pragma mark - tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSMarketCell *cell = [SSMarketCell cellWithTableView:tableView];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [SSSectionHeaderView creatSectionHeaderView];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

#pragma mark - UITableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSMarketsDetalViewController *detailVC = [[SSMarketsDetalViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - 行情编辑
-(void)marketsControll{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"编辑行情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        SSEdiMarketsViewController *vc = [[SSEdiMarketsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    UIAlertAction *Action2 = [UIAlertAction actionWithTitle:@"添加行情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SSAddMarketsViewController *vc = [[SSAddMarketsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //修改按钮
    
     [Action1 setValue:[UIColor colorFromHexRGB:@"333333"] forKey:@"titleTextColor"];
     [Action2 setValue:[UIColor colorFromHexRGB:@"333333"] forKey:@"titleTextColor"];
    [cancel setValue:[UIColor colorFromHexRGB:@"333333"] forKey:@"titleTextColor"];
    
    
    [alertController addAction:Action1];
    [alertController addAction:Action2];
    [alertController addAction:cancel];
    [self  presentViewController:alertController animated:YES completion:nil];
}


@end



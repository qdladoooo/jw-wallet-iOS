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
@property(nonatomic, strong) UIView *nav_view;
@end

@implementation SSMarktViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;

   
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"..." style:UIBarButtonItemStylePlain target:self action:@selector(marketsControll)];
     [self buildTableView];
    [self navigationView];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView
- (void)buildTableView {
//    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
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
    
    UIAlertAction *Action1 = [UIAlertAction actionWithTitle:kLocalizedTableString(@"编辑行情", gy_LocalizableName) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        SSEdiMarketsViewController *vc = [[SSEdiMarketsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    UIAlertAction *Action2 = [UIAlertAction actionWithTitle:kLocalizedTableString(@"添加行情", gy_LocalizableName) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SSAddMarketsViewController *vc = [[SSAddMarketsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:kLocalizedTableString(@"取消", gy_LocalizableName) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
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

#pragma mark - 导航栏view
-(void)navigationView{
    
    if (_nav_view==nil) {
        _nav_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _nav_view.backgroundColor = MAIN_GROUNDCOLOR;
    }
    
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(0, 40, SCREEN_WIDTH/2, 15);
    title.centerX = _nav_view.centerX;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:15];
    title.text = kLocalizedTableString(@"行情", gy_LocalizableName);

    [_nav_view addSubview:title];
    // 扫描按钮
//    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
//    btn1.tintColor = [UIColor whiteColor];
//    [btn1 setImage:[UIImage imageNamed:@"nav_white"] forState:UIControlStateNormal];
//    [_nav_view addSubview:btn1];
    // 钱包按钮
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 20, 40, 40)];
    btn2.tintColor = [UIColor whiteColor];
//    [btn2 setImage:[UIImage imageNamed:@"钱包"] forState:UIControlStateNormal];
    [btn2 setTitle:@"..." forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_nav_view addSubview:btn2];
//    [btn1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(marketsControll) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav_view];
}

@end



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
#import "XRDragTableView.h"
@interface SSEdiMarketsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet XRDragTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *nav_title;

@end

@implementation SSEdiMarketsViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.tableView.backgroundColor = MAIN_GROUNDCOLOR;
//    self.tableView.isExchange = YES; // 交换的方式，默认为插入
    self.tableView.dataArray = self.dataArray;
    //当cell拖动到tableView边缘时，tableView自动滚动的速度
    self.tableView.scrollSpeed = 10;
    
    self.nav_title.text = kLocalizedTableString(@"编辑行情", gy_LocalizableName);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 返回
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
// 复原
- (IBAction)reset:(id)sender {
    [self.tableView resetCellLocation];
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSEditMarketsCell *cell = [SSEditMarketsCell cellWithTableView:tableView];
    cell.Name.text = _dataArray[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SSSectionHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"SSSectionHeaderView" owner:nil options:nil] lastObject];
    headerView.title1.text = kLocalizedTableString( @"资产名称", gy_LocalizableName);
    headerView.title2.text = kLocalizedTableString(@"提醒", gy_LocalizableName);
    headerView.title3.text = kLocalizedTableString(@"拖动排序", gy_LocalizableName);
    return headerView;
}








@end

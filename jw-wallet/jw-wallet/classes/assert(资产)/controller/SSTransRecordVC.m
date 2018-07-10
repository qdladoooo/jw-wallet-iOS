//
//  SSTransRecordVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/7.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSTransRecordVC.h"
#import "SSTransRecordCell.h"
#import "SSTransRecordHeaderView.h"
@interface SSTransRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nav_title;

@end

@implementation SSTransRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = YES;
    self.tableView.backgroundColor = BACKGROUNDCOLOR;
    self.tableView.separatorColor = BACKGROUNDCOLOR;
    self.nav_title.text = kLocalizedTableString(@"交易记录", gy_LocalizableName);
    self.nav_title.font = [UIFont boldSystemFontOfSize:15];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 返回
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - <UITableViewDelegate,UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 93;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSTransRecordCell *cell = [SSTransRecordCell cellWithTableView:tableView];
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.title1.text = kLocalizedTableString(@"发款方", gy_LocalizableName) ;
                cell.title2.text = @"";
                
                break;
            case 1:
                cell.title1.text = kLocalizedTableString(@"收款方", gy_LocalizableName);
                cell.title2.text = @"";
                break;
            case 2:
                cell.title1.text = kLocalizedTableString(@"手续费", gy_LocalizableName);
                cell.title2.text = @"";
                break;
                
            default:
                break;
        }
    }else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                cell.title1.text = kLocalizedTableString( @"交易号", gy_LocalizableName);
                cell.title2.text = @"";
                cell.title2.textColor = Bluecolor;
                break;
            case 1:
                cell.title1.text = kLocalizedTableString(@"区块", gy_LocalizableName);
                cell.title2.text = @"";
                break;
            case 2:
                cell.title1.text = kLocalizedTableString(@"交易时间", gy_LocalizableName);
                cell.title2.text = @"";
                break;
                
            default:
                break;
        }
        
    }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        SSTransRecordHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"SSTransRecordHeaderView" owner:nil options:nil] lastObject];
        return headerView;
        
    }else{
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        view.backgroundColor = BACKGROUNDCOLOR;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(view.frame)-14-10, SCREEN_WIDTH/2, 14)];
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:14];
        
        if (section == 0) {
            label.text = kLocalizedTableString(@"账户信息", gy_LocalizableName) ;
        }else{
            label.text = kLocalizedTableString(@"交易信息", gy_LocalizableName);
        }
        [view addSubview:label];
        return view;
    }
}

@end

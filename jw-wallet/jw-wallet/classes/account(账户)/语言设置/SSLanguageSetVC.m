//
//  SSLanguageSetVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/31.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSLanguageSetVC.h"
#import "SSLanguageCell.h"
#import "HXLanguageManager.h"
@interface SSLanguageSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *dataAry;
@end

@implementation SSLanguageSetVC
{
    NSInteger selectedState;
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    _dataAry = @[ @"zh-Hant-CN", //中文繁体
                  @"en-CN"];// 英语
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSLanguageCell *cell = [SSLanguageCell cellWithTableview:tableView];
    
    
    
    if (indexPath.row == 0) {
        cell.title.text = @"繁体中文";
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.title.text =@"English";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    NSString *language = self.dataAry[indexPath.row];
    [kLanguageManager setUserlanguage:language];
    [self.tableview reloadData];
    
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return 10;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

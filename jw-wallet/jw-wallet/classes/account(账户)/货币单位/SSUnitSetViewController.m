//
//  SSUnitSetViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/2.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSUnitSetViewController.h"
#import "SSUnitSetTableViewCell.h"
#import "RootTabViewController.h"
@interface SSUnitSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,copy) NSArray *titleArr;
@property (weak, nonatomic) IBOutlet UILabel *nav_title;

@end

@implementation SSUnitSetViewController
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    _titleArr = @[@"USD",@"CNY"];
    self.nav_title.text = kLocalizedTableString(@"货币单位", gy_LocalizableName);
    self.nav_title.font = [UIFont boldSystemFontOfSize:15];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSUnitSetTableViewCell *cell = [SSUnitSetTableViewCell cellWithTablew:tableView];
    if (indexPath.row == 0) {
        cell.title.text = @"USD";
    }else{
        cell.title.text = @"CNY";
    }
    BOOL uniset = [[NSUserDefaults standardUserDefaults] boolForKey:_titleArr[indexPath.row]];
    
    if (uniset) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
   
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"USD"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"CNY"];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"USD"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CNY"];
    }
    
    [self.tableview reloadData];
    
    NSLog(@"当前货币：%@",_titleArr[indexPath.row]);
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.navigationController popViewControllerAnimated:YES];
    } completion:^(BOOL finished) {
        // 我们要把系统windown的rootViewController替换掉
        RootTabViewController *tab = [[RootTabViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
        // 跳转到设置页
        tab.selectedIndex = 3;
    }];

}
@end

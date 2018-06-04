//
//  SSAddAssertsVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/4.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAddAssertsVC.h"
#import "SSAddAssertsCell.h"
@interface SSAddAssertsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SSAddAssertsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.tableView.backgroundColor = MAIN_GROUNDCOLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSAddAssertsCell *cell = [SSAddAssertsCell cellWithTableView:tableView];
    return cell;
}




@end

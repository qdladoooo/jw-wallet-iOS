//
//  SSWalletDetailVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/6.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSWalletDetailVC.h"
#import "SSWalletListCell.h"
#import "SSWalletHeader.h"
#import "SSWalletHeaderTop.h"
#import "SSExportPrivatePassWord.h"

@interface SSWalletDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@end

@implementation SSWalletDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.deleteBtn.layer setBorderWidth:1];
    [self.deleteBtn.layer setBorderColor:rgba(15, 117, 230, 1).CGColor];
    [self.deleteBtn setTitleColor:rgba(15, 117, 230, 1) forState:UIControlStateNormal];
    
    self.fd_prefersNavigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1) {
        return 2;
    }else{
        return 2;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 92;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    footer.backgroundColor = [UIColor colorFromHexRGB:@"f2f6ff"];
    return footer;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        SSWalletHeaderTop *top = [[[NSBundle mainBundle] loadNibNamed:@"SSWalletHeaderTop" owner:nil options:nil] lastObject];
        return top;
    }else{
        SSWalletHeader *sectionHeader = [[[NSBundle mainBundle] loadNibNamed:@"SSWalletHeader" owner:nil options:nil] lastObject];
        if(section == 1){
            sectionHeader.headerTitle.text = @"钱包信息";
        }else{
             sectionHeader.headerTitle.text = @"导出信息";
        }
        return sectionHeader;
    }
    

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSWalletListCell *cell = [SSWalletListCell cellWithTableView:tableView];
    if (indexPath.section==1) {
        if (indexPath.row == 0) {
            cell.title1.text = @"钱包名称";
            cell.navR.hidden = YES;
            cell.title2.hidden = NO;
        }else{
            cell.title1.text = @"修改密码";
        }
    }else if (indexPath.section ==  2){
        if (indexPath.row==0) {
            cell.title1.text = @"导出私钥";
        }else{
             cell.title1.text = @"导出keystore";
        }
    }
    return cell;
}
/**
 删除钱包

 @param sender <#sender description#>
 */
- (IBAction)deleteWallet:(id)sender {
    SSExportPrivatePassWord *view = [[[NSBundle mainBundle] loadNibNamed:@"SSExportPrivatePassWord" owner:nil options:nil] lastObject];
    view.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:view];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

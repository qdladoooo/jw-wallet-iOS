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
#import "SSChangePasswordVC.h"
#import "LZPageViewController.h"
#import "SSKeystoreFileVC.h"
#import "SSMatrixCodeVC.h"

@interface SSWalletDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (weak, nonatomic) IBOutlet UILabel *nav_title;

@end

@implementation SSWalletDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabelView.separatorColor = BACKGROUNDCOLOR;
    [self.deleteBtn.layer setBorderWidth:1];
    [self.deleteBtn.layer setBorderColor:rgba(15, 117, 230, 1).CGColor];
    [self.deleteBtn setTitleColor:rgba(15, 117, 230, 1) forState:UIControlStateNormal];
    [self.deleteBtn setTitle:kLocalizedTableString(@"删除钱包", gy_LocalizableName) forState:UIControlStateNormal];
    self.nav_title.text = kLocalizedTableString(@"钱包详情", gy_LocalizableName);
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
            sectionHeader.headerTitle.text =kLocalizedTableString(@"钱包信息", gy_LocalizableName) ;
        }else{
             sectionHeader.headerTitle.text = kLocalizedTableString( @"导出信息", gy_LocalizableName);
        }
        return sectionHeader;
    }
    

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSWalletListCell *cell = [SSWalletListCell cellWithTableView:tableView];
    if (indexPath.section==1) {
        if (indexPath.row == 0) {
            cell.title1.text = kLocalizedTableString(@"钱包名称", gy_LocalizableName);
            cell.navR.hidden = YES;
            cell.title2.hidden = NO;
            cell.title2.text = self.model.walletName;
        }else{
            cell.title1.text = kLocalizedTableString(@"修改密码", gy_LocalizableName);
        }
    }else if (indexPath.section ==  2){
        if (indexPath.row==0) {
            cell.title1.text = kLocalizedTableString(@"导出私钥", gy_LocalizableName);
        }else{
             cell.title1.text = kLocalizedTableString(@"导出keystore", gy_LocalizableName);
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row == 1) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:1];
            [self passwordAlert:path];
            // 修改密码
        }
    }else if (indexPath.section==2){
        if (indexPath.row == 0) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:2];
            [self passwordAlert:path];
             // 导出私钥
        }else{
            NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:2];
            // 导出keystore，没有发现设计图
            [self passwordAlert:path];
        }
    }
}
/**
 删除钱包

 @param sender <#sender description#>
 */
- (IBAction)deleteWallet:(id)sender {
    [self passwordAlert:nil];
    
 

 
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 密码输入框
-(void)passwordAlert:(NSIndexPath*)pach{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"" message:kLocalizedTableString(@"请输入密码", gy_LocalizableName) preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = kLocalizedTableString(@"请输入密码", gy_LocalizableName);
        textField.layer.borderColor = Bluecolor.CGColor;
        textField.layer.borderWidth = 1.0f;
        textField.textColor = [UIColor darkGrayColor];
         textField.font = [UIFont systemFontOfSize:14];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.secureTextEntry = YES;


    }];
    [alertController addAction:[UIAlertAction actionWithTitle:kLocalizedTableString(@"确认", gy_LocalizableName)  style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * passwordfiled = textfields[0];
        NSLog(@"%@",passwordfiled.text);
  
        // 导出私钥
        if (![passwordfiled.text isEqualToString:self.model.walletPassword]) {

            [SJAlert createAlertWithMessage:kLocalizedTableString(@"密码输入错误", gy_LocalizableName) controller:self];
            return ;
        }
        // 删除钱包
        if (pach==nil) {
            [SJAlert createAlertWithMessage:kLocalizedTableString(@"删除成功", gy_LocalizableName) controller:self];
            [NSArray bg_deleteObjectWithName:wallet_Info Index:self.index];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        if (pach.section==1) {
            if (pach.row==1) {
                
                    // 修改密码
                    SSChangePasswordVC *vc = [[SSChangePasswordVC alloc] init];
                    vc.index = self.index;
                    [self.navigationController pushViewController:vc animated:YES];
            
            }
        }
        
        
        if (pach.section==2) {
            if (pach.row==0) {
               
                SSExportPrivatePassWord *view = [[[NSBundle mainBundle] loadNibNamed:@"SSExportPrivatePassWord" owner:nil options:nil] lastObject];
                view.model = self.model;
                view.frame = [UIScreen mainScreen].bounds;
                [self.view addSubview:view];
            }else{
                // 导出keystore
                LZPageViewController *pageVc = [[LZPageViewController alloc] initWithTitles:@[kLocalizedTableString(@"导出Keystore", gy_LocalizableName) ,kLocalizedTableString( @"二维码", gy_LocalizableName)] controllersClass:@[[SSKeystoreFileVC class],[SSMatrixCodeVC class]]];
                [self.navigationController pushViewController:pageVc animated:YES];
                
            }
        }
        
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:kLocalizedTableString(@"取消", gy_LocalizableName) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // 取消
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end

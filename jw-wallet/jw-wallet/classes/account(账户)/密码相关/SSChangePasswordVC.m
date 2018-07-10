//
//  SSChangePasswordVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/2.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSChangePasswordVC.h"

@interface SSChangePasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *currentPassword;
@property (weak, nonatomic) IBOutlet UILabel *nav_title;
@property (weak, nonatomic) IBOutlet UIButton *sure;

@end

@implementation SSChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.currentPassword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 45)];
    self.currentPassword.leftViewMode = UITextFieldViewModeAlways;
     self.fd_prefersNavigationBarHidden =  YES;
    
    self.nav_title.text = kLocalizedTableString(@"修改密码", gy_LocalizableName);
    self.nav_title.font =  [UIFont boldSystemFontOfSize:15];
    [self.sure setTitle:kLocalizedTableString(@"确认", gy_LocalizableName) forState:UIControlStateNormal];
    self.currentPassword.placeholder = kLocalizedTableString(@"请输入新密码", gy_LocalizableName);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 确认
- (IBAction)sureAction:(id)sender {
    NSArray *arr = [NSArray bg_arrayWithName:wallet_Info];
    SSLog(@"%@",arr);
    if (self.currentPassword.text.length==0) {
        [MBProgressHUD showText:kLocalizedTableString(self.currentPassword.placeholder, gy_LocalizableName)];
        return;
    }else if (self.currentPassword.text.length<6){
        [MBProgressHUD showText:kLocalizedTableString(@"密码位数不足", gy_LocalizableName)];
        return;
    }
    


    // 删除元素
    
    
    
}
#pragma mark - 返回
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

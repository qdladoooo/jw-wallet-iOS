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

@end

@implementation SSChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.currentPassword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 45)];
    self.currentPassword.leftViewMode = UITextFieldViewModeAlways;
     self.fd_prefersNavigationBarHidden =  YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 确认
- (IBAction)sureAction:(id)sender {
    
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

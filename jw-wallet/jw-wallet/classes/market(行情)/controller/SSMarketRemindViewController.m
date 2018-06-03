//
//  SSMarketRemindViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/4.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSMarketRemindViewController.h"

@interface SSMarketRemindViewController ()
@property (weak, nonatomic) IBOutlet UITextField *TF1;
@property (weak, nonatomic) IBOutlet UITextField *TF2;

@end

@implementation SSMarketRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // "通过KVC修改占位文字的颜色"
    [self.TF1 setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.TF2 setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [MBProgressHUD showText:@"保存成功"];
    }];
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

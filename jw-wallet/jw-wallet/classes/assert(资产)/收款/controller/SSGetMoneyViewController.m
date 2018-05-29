//
//  SSGetMoneyViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/28.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSGetMoneyViewController.h"

@interface SSGetMoneyViewController ()

/**
 收款地址
 */
@property (weak, nonatomic) IBOutlet UILabel *address;

@end

@implementation SSGetMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"收款";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - 赋值收款地址
- (IBAction)copy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.address.text;
    NSLog(@"%@",pasteboard.string);
   
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

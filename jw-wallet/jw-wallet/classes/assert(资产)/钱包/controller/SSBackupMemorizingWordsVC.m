//
//  SSBackupMemorizingWordsVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/2.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSBackupMemorizingWordsVC.h"
#import "SSConfirmHelpWordsVC.h"
@interface SSBackupMemorizingWordsVC ()

@end

@implementation SSBackupMemorizingWordsVC
// 下一步
- (IBAction)next:(id)sender {
    
    SSConfirmHelpWordsVC *vc = [[SSConfirmHelpWordsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
// 返回上级
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.fd_prefersNavigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

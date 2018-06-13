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
@property (weak, nonatomic) IBOutlet UILabel *nav_title;
@property (weak, nonatomic) IBOutlet UILabel *writeYourWords;
@property (weak, nonatomic) IBOutlet UILabel *tips;
@property (weak, nonatomic) IBOutlet UIButton *nextStep;

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
    
    self.nav_title.text = kLocalizedTableString(@"备份助记词", gy_LocalizableName);
    self.writeYourWords.text = kLocalizedTableString(@"抄写下你的助记词", gy_LocalizableName);
    self.tips.text = kLocalizedTableString(_tips.text, gy_LocalizableName);
    [self.nextStep setTitle:@"下一步" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

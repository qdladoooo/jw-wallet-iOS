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
@property (weak, nonatomic) IBOutlet UILabel *helpwords;

/**
 助记词数组
 */
@property (nonatomic, copy) NSArray *strArr;

@end

@implementation SSBackupMemorizingWordsVC
// 下一步
- (IBAction)next:(id)sender {
    
    SSConfirmHelpWordsVC *vc = [[SSConfirmHelpWordsVC alloc] init];
    vc.userName = self.userName;
    vc.dataArr = self.strArr;
    vc.password = self.password;
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
    
}
// 返回跟菜单
- (IBAction)backAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _strArr = [NSArray array]; // 初始化助记词数组
    self.fd_prefersNavigationBarHidden = YES;
    
    self.nav_title.text = kLocalizedTableString(@"备份助记词", gy_LocalizableName);
    self.nav_title.font = [UIFont boldSystemFontOfSize:15];
    self.writeYourWords.text = kLocalizedTableString(@"抄写下你的助记词", gy_LocalizableName);
    self.writeYourWords.font = [UIFont boldSystemFontOfSize:15];
    self.tips.text = kLocalizedTableString(_tips.text, gy_LocalizableName);
    [self.nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    
    self.helpwords.text = @"";
    self.helpwords.text = self.model.brain_priv_key;
    // 把助记词包装成数组
    [self makeArrayFromString];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 用字符串组装成一个数组
-(void)makeArrayFromString{
    NSString *str = self.model.brain_priv_key;
    self.strArr = [str componentsSeparatedByString:@" "];
    SSLog(@"助记词：%@",self.strArr);
}

@end

//
//  SSBackupMemorizingWordsVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/2.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSBackupMemorizingWordsVC.h"
#import "SSConfirmHelpWordsVC.h"
#import "SSHelpWordsModel.h"
@interface SSBackupMemorizingWordsVC ()
@property (weak, nonatomic) IBOutlet UILabel *nav_title;
@property (weak, nonatomic) IBOutlet UILabel *writeYourWords;
@property (weak, nonatomic) IBOutlet UILabel *tips;
@property (weak, nonatomic) IBOutlet UIButton *nextStep;
@property (weak, nonatomic) IBOutlet UILabel *helpwords;
@property (nonatomic, strong) SSHelpWordsModel *model;
@end

@implementation SSBackupMemorizingWordsVC
// 下一步
- (IBAction)next:(id)sender {
    
    SSConfirmHelpWordsVC *vc = [[SSConfirmHelpWordsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
// 返回跟菜单
- (IBAction)backAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.fd_prefersNavigationBarHidden = YES;
    
    self.nav_title.text = kLocalizedTableString(@"备份助记词", gy_LocalizableName);
    self.writeYourWords.text = kLocalizedTableString(@"抄写下你的助记词", gy_LocalizableName);
    self.tips.text = kLocalizedTableString(_tips.text, gy_LocalizableName);
    [self.nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    
    self.helpwords.text = @"";
    [self requestHelpWords];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestHelpWords{
    NSString *url = [NSString  stringWithFormat:@"%@%@",BaseURLString,GetHelpWords];
    [MBProgressHUD showHUDOnView:self.view];
    [HttpTool postWithURL:url params:nil success:^(id json) {
       
        SSLog(@"%@",json);
        NSDictionary *data = json[@"result"];
        if (![data isKindOfClass:[NSNull class]]) {
            if ([json[@"result_code"] integerValue] == 10000 ) {
                self.model = [SSHelpWordsModel mj_objectWithKeyValues:data];
                self.helpwords.text = self.model.brain_priv_key;
            }
        }else{
            [MBProgressHUD showError:@"获取失败"];
        }
    [MBProgressHUD hiddenForView:self.view];
    } failure:^(NSError *error) {
         SSLog(@"%@",error);
        [MBProgressHUD hiddenForView:self.view];
    }];


}

@end

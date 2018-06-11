//
//  SSHomeCoverVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/11.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSHomeCoverVC.h"
#import "SSCreatePurseViewController.h"
#import "SSAddPurseViewController.h"
@interface SSHomeCoverVC ()

@end

@implementation SSHomeCoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLaunch"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)creatWallet:(id)sender {
    SSCreatePurseViewController *vc = [[SSCreatePurseViewController alloc] init];
    vc.isFromHomeAlert = YES;
    [self presentViewController:vc animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}
- (IBAction)addWallet:(id)sender {
    SSAddPurseViewController *vc = [[SSAddPurseViewController alloc] init];
      vc.isFromHomeAlert = YES;
    [self presentViewController:vc animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

@end

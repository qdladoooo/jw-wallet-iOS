//
//  SSAuthorizedLoginCV.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/2.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAuthorizedLoginCV.h"

@interface SSAuthorizedLoginCV ()
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@end

@implementation SSAuthorizedLoginCV
- (IBAction)agree:(id)sender {
    [MBProgressHUD showText:@"允许"];
}
- (IBAction)reject:(id)sender {
    [MBProgressHUD showText:@"拒绝"];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.userImage.layer setCornerRadius:34];
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

@end

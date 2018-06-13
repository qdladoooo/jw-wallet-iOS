//
//  SSInviteCodeShare.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/4.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSInviteCodeShare.h"
#import "JSHAREService.h"
@interface SSInviteCodeShare ()
@property (weak, nonatomic) IBOutlet UILabel *nav_title;
@property (weak, nonatomic) IBOutlet UIButton *share;

@end

@implementation SSInviteCodeShare
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden =  YES;
    self.nav_title.text = kLocalizedTableString(@"分享邀请码", gy_LocalizableName);
}
// 分享
- (IBAction)share:(id)sender {
    JSHAREMessage *message = [JSHAREMessage message];
    message.text = @"JShare SDK 支持主流社交平台、帮助开发者轻松实现社会化功能！";
    message.platform = JSHAREPlatformWechatSession;
    message.mediaType = JSHAREText;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        NSLog(@"分享回调");
        [MBProgressHUD showText:[NSString stringWithFormat:@"%@\n%lu\n%@",message,(unsigned long)state,error]];
    }];
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

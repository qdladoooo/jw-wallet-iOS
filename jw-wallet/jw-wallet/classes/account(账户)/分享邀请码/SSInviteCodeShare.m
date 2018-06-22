//
//  SSInviteCodeShare.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/4.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSInviteCodeShare.h"
#import "JSHAREService.h"
#import "ShareView.h"
@interface SSInviteCodeShare ()
@property (weak, nonatomic) IBOutlet UILabel *nav_title;
@property (weak, nonatomic) IBOutlet UIButton *share;
@property (nonatomic, assign) JSHAREPlatform selectPlatform;
@property (nonatomic, strong) ShareView * shareView;
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
//    self.selectPlatform = JSHAREPlatformQzone;
     [self.shareView showWithContentType:JSHAREText];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ShareView *)shareView {
    if (!_shareView) {
        _shareView = [ShareView getFactoryShareViewWithCallBack:^(JSHAREPlatform platform, JSHAREMediaType type) {
            switch (type) {
                case JSHAREText:
                    [self shareTextWithPlatform:platform];
                    break;
//                case JSHAREImage:
//                    [self shareImageWithPlatform:platform];
//                    break;
//                case JSHARELink:
//                    [self shareLinkWithPlatform:platform];
//                    break;
//                case JSHAREAudio:
//                    [self shareMusicWithPlatform:platform];
//                    break;
//                case JSHAREVideo:
//                    [self shareVideoWithPlatform:platform];
//                    break;
//                case JSHAREApp:
//                    [self shareAppWithPlatform:platform];
//                    break;
//                case JSHAREEmoticon:
//                    [self shareEmoticonWithPlatform:platform];
//                    break;
//                case JSHAREFile:
//                    [self shareFileWithPlatform:platform];
//                    break;
//                default:
//                    [self getUserInfoWithPlatform:platform];
//                    break;
            }
            
        }];
        [self.view addSubview:self.shareView];
    }
    return _shareView;
}
- (void)getUserInfoWithPlatform:(JSHAREPlatform)platfrom{
    [JSHAREService getSocialUserInfo:platfrom handler:^(JSHARESocialUserInfo *userInfo, NSError *error) {
        NSString *alertMessage;
        NSString *title;
        if (error) {
            title = @"失败";
            alertMessage = @"无法获取到用户信息";
        }else{
            title = userInfo.name;
            NSString *gender = nil;
            if (userInfo.gender == 1) {
                gender = @"男";
            }else if (userInfo.gender == 2){
                gender = @"女";
            }else{
                gender = @"未知";
            }
            
            alertMessage = [NSString stringWithFormat:@"昵称: %@\n 头像链接: %@\n 性别: %@\n",userInfo.name,userInfo.iconurl,gender];
        }
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:title message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [Alert show];
        });
        
        
    }];
}
- (void)shareTextWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    message.text = [NSString stringWithFormat:@"时间:%@ JShare SDK支持主流社交平台、帮助开发者轻松实现社会化功能！",[self localizedStringTime]];
    message.platform = platform;
    message.mediaType = JSHAREText;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        [self showAlertWithState:state error:error];
    }];
}
- (NSString *)localizedStringTime{
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];[formatter setDateFormat:@"yyy-MM-dd HH:mm:ss"];
    NSString*dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

- (void)showAlertWithState:(JSHAREState)state error:(NSError *)error{
    
    NSString *string = nil;
    if (error) {
        string = [NSString stringWithFormat:@"分享失败,error:%@", error.description];
    }else{
        switch (state) {
            case JSHAREStateSuccess:
                string = @"分享成功";
                break;
            case JSHAREStateFail:
                string = @"分享失败";
                break;
            case JSHAREStateCancel:
                string = @"分享取消";
                break;
            case JSHAREStateUnknown:
                string = @"Unknown";
                break;
            default:
                break;
        }
    }
    
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:nil message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [Alert show];
    });
}
@end

//
//  SSTouchIDVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/18.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSTouchIDVC.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface SSTouchIDVC ()

@end

@implementation SSTouchIDVC

-(SSTouchIDVC *)shareInstance
{
    static dispatch_once_t predicate;
    static SSTouchIDVC * vc;
    dispatch_once(&predicate, ^{
        vc = [[SSTouchIDVC alloc] init];
    });
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



/**
 验证指纹
 */
- (void)verifyTouchId:(void(^)(BOOL success, NSError * __nullable error))result{
    
    //        if ([Global isTouchIdEnabledOrNotBySystem]) {
    LAContext *context = [LAContext new];
    
    NSError *error;
    // 如果指纹失效，输入六位的数字密码
    context.localizedFallbackTitle = @"";// Cancel "Enter Password" option(cannot set as nil)
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:kLocalizedTableString(@"通过Home键验证指纹并开启指纹", gy_LocalizableName) reply:^(BOOL success, NSError *error) {
            if (result) {
                result(success,error);
            }
        }];
    } else {
        if (result) {
            result(NO,nil);
        }
    }
    
}


@end

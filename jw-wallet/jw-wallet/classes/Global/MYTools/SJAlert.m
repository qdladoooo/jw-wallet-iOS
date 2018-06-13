//
//  SJAlert.m
//  ShouJinLiCai
//
//  Created by 王冠阳 on 16/5/22.
//  Copyright © 2016年 shoujinwang. All rights reserved.
//

#import "SJAlert.h"

@implementation SJAlert
//通过传递信息创建警告栏
+ (void)createAlertWithMessage: (NSString *)message controller:(UIViewController *)viewController
{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: kLocalizedTableString(@"温馨提示", gy_LocalizableName) message: message preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:kLocalizedTableString(@"我知道了", gy_LocalizableName) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [alertController addAction: action];
    [viewController presentViewController: alertController animated: YES completion: nil];


    
}
+(void)creatAlertWithTitle:(NSString *)title message:(NSString *)message actionMessage:(NSString *)actionMessage ntroller:(UIViewController *)viewController{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: title message: message preferredStyle: UIAlertControllerStyleAlert];
    [alertController addAction: [UIAlertAction actionWithTitle: actionMessage style: UIAlertActionStyleCancel handler: nil]];
//    [alertController addAction:[UIAlertAction actionWithTitle:actionMessage style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [viewController presentViewController: alertController animated: YES completion: nil];
    });
    
}
//创建黑色警告框
+ (void)createShadowAlertWithMessage: (NSString *)message frame: (CGRect)frame superView:(UIView *)superView
{
    UIView * shadowView = [[UIView alloc] initWithFrame: frame];
    shadowView.backgroundColor = rgba(100, 100, 100, 0.7);
    UILabel * label = [[UILabel alloc] initWithFrame: shadowView.bounds];
    label.text = message;
    label.font = [UIFont systemFontOfSize: 15];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [shadowView addSubview: label];
    
    [superView addSubview: shadowView];
    [UIView animateWithDuration: 1.5f animations: ^{
        shadowView.alpha = 0.0f;
    } completion: ^(BOOL finished) {
        [shadowView removeFromSuperview];
    }];
}

@end

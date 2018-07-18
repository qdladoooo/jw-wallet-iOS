//
//  SSAssetsAlert.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/7/18.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAssetsAlert.h"
@interface SSAssetsAlert()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end
@implementation SSAssetsAlert

+(void)showAseestAlert{
    SSAssetsAlert *alertView = (SSAssetsAlert *)[[NSBundle mainBundle] loadNibNamed:@"SSAssetsAlert" owner:nil options:nil].lastObject;
    alertView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    [alertView showAnimation];
}

/**
 关闭
 */
- (IBAction)close:(id)sender {
    [self hiddenAnmation];
}



/**
 添加资产
 */
- (IBAction)addAssets:(id)sender {
    [MBProgressHUD showText:@"添加资产"];
}

-(void)showAnimation{
    self.contentView.transform = CGAffineTransformMakeScale(0.001,0.001);
    self.backgroundColor = rgba(0, 0, 0, 0);
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = rgba(0, 0, 0, 0.3);
        self.contentView.transform = CGAffineTransformMakeScale(1,1);
    }];
}

-(void)hiddenAnmation{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = rgba(0, 0, 0, 0);
        self.contentView.transform = CGAffineTransformMakeScale(0.001,0.001);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end

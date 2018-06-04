//
//  SSAsertHearView.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/27.
//  Copyright © 2018年 SHSF. All rights reserved.
//
#import "SSAddAssertsVC.h"
#import "SSAsertHearView.h"
#import "SSGetMoneyViewController.h"
@implementation SSAsertHearView

+(UIView *)createAsertHearView{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"SSAsertHearView" owner:self options:nil] lastObject];
    return view;
}

/**
 收款地址，点击打开二维码

 @param sender <#sender description#>
 */
- (IBAction)getMoneyAdress:(id)sender {
    SSGetMoneyViewController *vc = [[SSGetMoneyViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc  animated:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
// 添加新的资产
- (IBAction)addNewAsserts:(id)sender {
    SSAddAssertsVC *vc = [[SSAddAssertsVC alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

@end

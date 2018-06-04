//
//  SSCreateWalletView.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/4.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSCreateWalletView.h"
@interface SSCreateWalletView()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@end
@implementation SSCreateWalletView
-(void)awakeFromNib{
    [super awakeFromNib];
    [self.btn1.layer setCornerRadius:22];
    [self.btn2.layer setCornerRadius:22];
}
- (IBAction)addWallet:(id)sender {
}
- (IBAction)creatWallet:(id)sender {
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  SSWalletHeaderTop.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/7.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSWalletHeaderTop.h"
@interface SSWalletHeaderTop()
@property (weak, nonatomic) IBOutlet UILabel *walletName_label;

@end
@implementation SSWalletHeaderTop


-(void)awakeFromNib{
    [super awakeFromNib];
    self.walletName_label.text = kLocalizedTableString(@"钱包名称", gy_LocalizableName);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  SSExportPrivatePassWord.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/7.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSExportPrivatePassWord.h"
@interface SSExportPrivatePassWord()
@property (weak, nonatomic) IBOutlet UILabel *safeTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIButton *btnForCopy_label;
@property (weak, nonatomic) IBOutlet UILabel *prvate_key;


@end
@implementation SSExportPrivatePassWord

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = rgba(0, 0, 0, 0.5);
    [self.safeTipLabel.layer setBorderColor:Bluecolor.CGColor];
    [self.safeTipLabel.layer setBorderWidth:1.0f];
    self.title.text = kLocalizedTableString(@"导出私钥", gy_LocalizableName);
    self.safeTipLabel.text = kLocalizedTableString(self.safeTipLabel.text, gy_LocalizableName);
    [self.btnForCopy_label setTitle:kLocalizedTableString(@"复制", gy_LocalizableName) forState:UIControlStateNormal];
}
- (IBAction)remove:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)copy:(id)sender {
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    [board setString:self.prvate_key.text];
    [MBProgressHUD showText:kLocalizedTableString(@"复制成功", gy_LocalizableName)];
}
- (void)setModel:(SSWalletInfo *)model{
    _model = model;
    self.prvate_key.text = self.model.privatePassword;
}
@end

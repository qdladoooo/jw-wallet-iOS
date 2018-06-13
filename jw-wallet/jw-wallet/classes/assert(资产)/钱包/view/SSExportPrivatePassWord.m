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

@end
@implementation SSExportPrivatePassWord

-(void)awakeFromNib{
    [super awakeFromNib];
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
    [MBProgressHUD showText:kLocalizedTableString(@"复制成功", gy_LocalizableName)];
}

@end

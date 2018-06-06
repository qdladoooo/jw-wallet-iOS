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

@end
@implementation SSExportPrivatePassWord

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.safeTipLabel.layer setBorderColor:Bluecolor.CGColor];
    [self.safeTipLabel.layer setBorderWidth:1.0f];
}
- (IBAction)remove:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)copy:(id)sender {
    [MBProgressHUD showText:@"复制成功"];
}

@end

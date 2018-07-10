//
//  SSPurseListCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/30.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSPurseListCell.h"
@interface SSPurseListCell()




@end
@implementation SSPurseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.setBtn setTitle:kLocalizedTableString(@" 设置默认 ", gy_LocalizableName) forState:UIControlStateNormal];
    [self.setBtn setTitle:kLocalizedTableString(@" 设置默认 ", gy_LocalizableName) forState:UIControlStateSelected];
    self.setBtn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    self.setBtn.layer.borderWidth = 1;
    self.setBtn.layer.borderColor = Bluecolor.CGColor;
    self.walletName_title.font = [UIFont boldSystemFontOfSize:15];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"SSPurseListCell";
    SSPurseListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SSPurseListCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
//- (IBAction)setWallet:(id)sender {
//    _setBtn.selected = !_setBtn.selected;
//    if (_setBtn.selected) {
//        self.setBtn.layer.borderWidth = 0;
//    }else{
//        self.setBtn.layer.borderWidth = 1;
//        self.setBtn.layer.borderColor = Bluecolor.CGColor;
//    }
//    if (_IsButtonnSelectedBlock) {
//
//        _IsButtonnSelectedBlock(_setBtn.selected);
//    }
//    // 存储选择状态
//    [[NSUserDefaults standardUserDefaults] setBool:_setBtn.selected forKey:@"MoRenWallet"];
//}


@end

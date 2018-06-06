//
//  SSPurseListCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/30.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSPurseListCell.h"
@interface SSPurseListCell()

/**
 设置按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *setBtn;

@end
@implementation SSPurseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
- (IBAction)setWallet:(id)sender {
    _setBtn.selected = !_setBtn.selected;
    if (_IsButtonnSelectedBlock) {
        _IsButtonnSelectedBlock(_setBtn.selected);
    }
    // 存储选择状态
    [[NSUserDefaults standardUserDefaults] setBool:_setBtn.selected forKey:@"MoRenWallet"];
}


@end

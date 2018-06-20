//
//  SSTouchIDSetCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/4.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSTouchIDSetCell.h"

@implementation SSTouchIDSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
// 开关
- (IBAction)switchONAndOff:(UISwitch *)sender {
    
    if (_switchclickBlock) {
        _switchclickBlock(sender.isOn);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"SSTouchIDSetCell";
    SSTouchIDSetCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SSTouchIDSetCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end

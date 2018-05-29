//
//  SSPurseListCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/30.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSPurseListCell.h"

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
@end

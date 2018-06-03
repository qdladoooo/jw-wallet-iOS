//
//  SSAddMarketsListCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/3.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAddMarketsListCell.h"

@implementation SSAddMarketsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithtableView:(UITableView *)tableView{
    static NSString *ID = @"SSAddMarketsListCell";
    SSAddMarketsListCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SSAddMarketsListCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end

//
//  SSKeystoreContentCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/11.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSKeystoreContentCell.h"

@implementation SSKeystoreContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableVie:(UITableView *)tableView{
    static NSString *ID = @"SSKeystoreContentCell";
    SSKeystoreContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SSKeystoreContentCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end

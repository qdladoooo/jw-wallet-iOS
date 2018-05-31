//
//  SSLanguageCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/31.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSLanguageCell.h"

@implementation SSLanguageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableview:(UITableView *)tableview{
    static NSString *ID = @"SSLanguageCell";
    SSLanguageCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SSLanguageCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end

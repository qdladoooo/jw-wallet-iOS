//
//  SSInviteCodeShareCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/4.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSInviteCodeShareCell.h"

@interface SSInviteCodeShareCell()
@property (weak, nonatomic) IBOutlet UILabel *inviteCode;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end
@implementation SSInviteCodeShareCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.inviteCode.text = kLocalizedTableString(@"分享邀请码", gy_LocalizableName);
    self.bottomLabel.text = kLocalizedTableString(@"副标题(可配置)", gy_LocalizableName);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"SSInviteCodeShareCell";
    SSInviteCodeShareCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SSInviteCodeShareCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end

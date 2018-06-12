//
//  SSEditMarketsCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/3.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSEditMarketsCell.h"
#import "SSMarketRemindViewController.h"

@implementation SSEditMarketsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"SSEditMarketsCell";
    SSEditMarketsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SSEditMarketsCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
// 提醒
- (IBAction)remid:(id)sender {
    SSMarketRemindViewController *vc = [SSMarketRemindViewController alloc];
    [self.viewController presentViewController:vc animated:YES completion:nil];

    
}

@end

//
//  SSAddAssertsCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/4.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAddAssertsCell.h"
@interface SSAddAssertsCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageLogo;

@end
@implementation SSAddAssertsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.imageLogo.layer setCornerRadius:20];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"SSAddAssertsCell";
    SSAddAssertsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SSAddAssertsCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end

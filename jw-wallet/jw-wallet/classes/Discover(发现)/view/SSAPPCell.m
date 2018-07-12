//
//  SSAPPCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/7/13.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAPPCell.h"
@interface SSAPPCell()
@property (weak, nonatomic) IBOutlet UIImageView *appImage;

@end
@implementation SSAPPCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.appImage.layer.cornerRadius = 28;
    self.appImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"SSAPPCell";
    SSAPPCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SSAPPCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end

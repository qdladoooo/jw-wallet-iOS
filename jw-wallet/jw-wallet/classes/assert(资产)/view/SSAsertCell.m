
//
//  SSAsertCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/27.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAsertCell.h"
@interface SSAsertCell()
@property (weak, nonatomic) IBOutlet UIView *CellContentView;

@end
@implementation SSAsertCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.icon.layer.cornerRadius = 16;
    self.icon.layer.masksToBounds = YES;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.CellContentView.layer.shadowOffset =CGSizeMake(2, 2);
    
    self.CellContentView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    
    self.CellContentView.layer.shadowRadius = 2;
    
    self.CellContentView.layer.shadowOpacity = 0.3f;
    
    self.CellContentView.layer.masksToBounds = NO;
    
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"SSAsertCell";
    SSAsertCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SSAsertCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

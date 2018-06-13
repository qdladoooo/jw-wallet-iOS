//
//  SSAccoutHeaderView.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/27.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAccoutHeaderView.h"
@interface SSAccoutHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *accoutLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountName;

@end
@implementation SSAccoutHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.accoutLabel.text = kLocalizedTableString(@"账户", gy_LocalizableName);
    self.accountName.text = kLocalizedTableString(@"账户名称", gy_LocalizableName);
}
+(UIView *)creatHeaderView{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"SSAccoutHeaderView" owner:self options:nil] lastObject];
    return view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

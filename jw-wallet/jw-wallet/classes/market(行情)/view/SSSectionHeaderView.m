
//
//  SSSectionHeaderView.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/27.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSSectionHeaderView.h"
@interface SSSectionHeaderView()


@end
@implementation SSSectionHeaderView
+(UIView *)creatSectionHeaderView{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"SSSectionHeaderView" owner:self options:nil] lastObject];
    return view;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.title1.text = kLocalizedTableString(@"资产名称", gy_LocalizableName);
    self.title2.text = kLocalizedTableString(@"最新价", gy_LocalizableName);
    self.title3.text = kLocalizedTableString(@"涨跌幅", gy_LocalizableName);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

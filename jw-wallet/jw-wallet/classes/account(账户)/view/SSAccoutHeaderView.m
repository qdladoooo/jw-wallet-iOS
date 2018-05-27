//
//  SSAccoutHeaderView.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/27.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAccoutHeaderView.h"

@implementation SSAccoutHeaderView
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

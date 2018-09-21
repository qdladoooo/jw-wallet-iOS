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
@end
@implementation SSAccoutHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.accoutLabel.text = kLocalizedTableString(@"账户", gy_LocalizableName);
    self.accoutLabel.font = [UIFont boldSystemFontOfSize:15];
    self.accountName.font = [UIFont boldSystemFontOfSize:15];
    self.accountId.font = [UIFont boldSystemFontOfSize:12];
   
}

+(UIView *)creatHeaderView{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"SSAccoutHeaderView" owner:self options:nil] lastObject];
    return view;
}


@end

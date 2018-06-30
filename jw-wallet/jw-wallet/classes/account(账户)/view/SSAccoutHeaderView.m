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
@property (weak, nonatomic) IBOutlet SJGradientView *grandView;

@end
@implementation SSAccoutHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.accoutLabel.text = kLocalizedTableString(@"账户", gy_LocalizableName);
    self.accountName.text = kLocalizedTableString(@"账户名称", gy_LocalizableName);
//    [self addGradualLayer];
   
}

+(UIView *)creatHeaderView{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"SSAccoutHeaderView" owner:self options:nil] lastObject];
    return view;
}
- (void)addGradualLayer{
    //渐变图层
    CAGradientLayer *gradientlayer1 = [CAGradientLayer layer];
    gradientlayer1.startPoint = CGPointMake(0.5, 0);
    gradientlayer1.endPoint = CGPointMake(0.5, 1);
    gradientlayer1.frame = self.grandView.bounds;
    NSArray *colorAry1 = [NSArray arrayWithObjects:(id)rgba(7, 12, 47, 1).CGColor, rgba(28  , 43, 79, 1).CGColor,nil];
    gradientlayer1.colors = colorAry1;
    [self.grandView.layer insertSublayer:gradientlayer1 atIndex:0];
}

@end

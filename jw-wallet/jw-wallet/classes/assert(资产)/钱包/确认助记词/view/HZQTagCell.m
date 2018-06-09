//
//  HZQTagCell.m
//  HZQTagCollectionView
//
//  Created by 1 on 15/10/20.
//  Copyright © 2015年 HZQ. All rights reserved.
//

#import "HZQTagCell.h"

@implementation HZQTagCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.frame)-5, 12)];
        self.text.textColor = [UIColor darkGrayColor];
        self.text.font = [UIFont systemFontOfSize:14];
        self.text.textAlignment = NSTextAlignmentCenter;
//        self.text.layer.borderColor = [[UIColor grayColor] CGColor];
//        self.text.layer.borderWidth = 0.8f;
//        self.text.layer.cornerRadius = 2.0f;
        
        [self addSubview:self.text];
        
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.frame = CGRectMake(CGRectGetWidth(self.frame) - 10, 0, 20, 12);
        self.btn.layer.cornerRadius = 5;
        self.btn.layer.masksToBounds = YES;
//        [self.btn setBackgroundImage:[UIImage imageNamed:@"iconfont-shanchujilu"] forState:0];
        [self addSubview:self.btn];
        
        
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    
    /* 放大缩小 */
    
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画选项设定
    animation.duration = 0.2; // 动画持续时间
    animation.repeatCount = -1; // 重复次数
    animation.autoreverses = YES; // 动画结束时执行逆动画
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:0.9]; // 结束时的倍率
    
    // 添加动画
    [self.layer addAnimation:animation forKey:@"scale-layer"];
    
}

@end

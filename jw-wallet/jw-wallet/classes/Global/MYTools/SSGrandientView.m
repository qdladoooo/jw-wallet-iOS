//
//  SSGrandientView.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/30.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSGrandientView.h"

@implementation SSGrandientView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    //渐变图层
    CAGradientLayer *gradientlayer1 = [CAGradientLayer layer];
    gradientlayer1.startPoint = CGPointMake(0.5, 0);
    gradientlayer1.endPoint = CGPointMake(0.5, 1);
    gradientlayer1.frame = self.bounds;
    NSArray *colorAry1 = [NSArray arrayWithObjects:(id) rgba(28  , 43, 79, 1).CGColor,rgba(7, 12, 47, 1).CGColor,  nil];
    gradientlayer1.colors = colorAry1;
    [self.layer insertSublayer: gradientlayer1 atIndex:0];
}


@end

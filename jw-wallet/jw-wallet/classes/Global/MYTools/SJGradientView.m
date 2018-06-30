//
//  SJGradientView.m
//  ShouJinLiCai
//
//  Created by 宋任强 on 2017/11/6.
//

#import "SJGradientView.h"

@implementation SJGradientView


- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    //渐变图层
    CAGradientLayer *gradientlayer1 = [CAGradientLayer layer];
    gradientlayer1.startPoint = CGPointMake(0.5, 0);
    gradientlayer1.endPoint = CGPointMake(0.5, 1);
    gradientlayer1.frame = self.bounds;
    NSArray *colorAry1 = [NSArray arrayWithObjects:(id) rgba(7, 12, 47, 1).CGColor,  rgba(28  , 43, 79, 1).CGColor,nil];
    gradientlayer1.colors = colorAry1;
    [self.layer insertSublayer: gradientlayer1 atIndex:0];
}


@end

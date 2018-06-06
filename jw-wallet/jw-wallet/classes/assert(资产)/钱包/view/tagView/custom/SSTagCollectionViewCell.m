//
//  SSTagCollectionViewCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/6.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSTagCollectionViewCell.h"
@interface SSTagCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation SSTagCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _bgView.layer.cornerRadius = 13;
}

-(void)setTitleStr:(NSString *)title color:(NSString *)color{
    [self.label setText:title];
    _bgView.backgroundColor = [self randomColor];
}


-(UIColor *)randomColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end

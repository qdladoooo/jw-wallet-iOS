//
//  YYBHorizontalCollectionCell.m
//  YouYouBao
//
//  Created by Funny on 2017/4/13.
//  Copyright © 2017年 Funny. All rights reserved.
//

#import "YYBHorizontalCollectionCell.h"


#define Image_Label_Space 5
#define DescripLabelFont [UIFont systemFontOfSize:12]

@interface YYBHorizontalCollectionCell ()

@end

@implementation YYBHorizontalCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.displayImageView];
        
        [self.contentView addSubview:self.descripLabel];

    }
    return self;
}

- (void)setDisplayImageString:(NSString *)displayImageString DescripLabelString:(NSString *)descripLabelStrig {
    
    self.displayImageView.image = [UIImage imageNamed:displayImageString];
    
    self.descripLabel.text = descripLabelStrig;
}

- (UIImageView *)displayImageView {
    if (!_displayImageView) {
//        _displayImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-20)];

        _displayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 56, 56)];

        
        UIBezierPath *maskPath;
        maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _displayImageView.width, _displayImageView.height) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(28,28)];

        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = CGRectMake(0, 0, _displayImageView.width, _displayImageView.height);
        maskLayer.path = maskPath.CGPath;
        _displayImageView.layer.mask = maskLayer;
        
    }
    return _displayImageView;
}

- (UILabel *)descripLabel{
    if (!_descripLabel) {
        _descripLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.displayImageView.frame) + 15, _displayImageView.width, 12)];
        _descripLabel.textColor = [UIColor darkGrayColor];
        _descripLabel.textAlignment = NSTextAlignmentCenter;
        _descripLabel.centerX = _displayImageView.centerX;
        _descripLabel.font = DescripLabelFont;
    }
    return _descripLabel;
}


@end

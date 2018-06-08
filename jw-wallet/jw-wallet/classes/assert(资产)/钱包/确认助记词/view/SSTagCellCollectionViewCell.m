//
//  SSTagCellCollectionViewCell.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/7.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSTagCellCollectionViewCell.h"

@implementation SSTagCellCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    self.layer.borderWidth = 1;
}

@end

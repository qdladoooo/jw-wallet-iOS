//
//  SSTagCellCollectionViewCell.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/7.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSTagCellCollectionViewCell : UICollectionViewCell

/**
 标签名称
 */
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (nonatomic, assign) BOOL isSelected;

@end

//
//  SSTagCollectionViewCell.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/6.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSTagCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
-(void)setTitleStr:(NSString *)title color:(NSString *)color;
@end

//
//  SSAsertCell.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/27.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSAserModel.h"
@interface SSAsertCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIView *darkView;

@end

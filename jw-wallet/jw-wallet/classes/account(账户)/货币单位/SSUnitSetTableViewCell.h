//
//  SSUnitSetTableViewCell.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/2.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSUnitSetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
+(instancetype)cellWithTablew:(UITableView *)tableView;
@end

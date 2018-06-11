//
//  SSKeystoreContentCell.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/11.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSKeystoreContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *content;
+(instancetype)cellWithTableVie:(UITableView *)tableView;
@end

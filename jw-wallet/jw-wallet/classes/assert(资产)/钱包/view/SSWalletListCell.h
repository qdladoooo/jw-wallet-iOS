//
//  SSWalletListCell.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/6.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSWalletListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *navR;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

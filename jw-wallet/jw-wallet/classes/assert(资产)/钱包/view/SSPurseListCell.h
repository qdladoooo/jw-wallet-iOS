//
//  SSPurseListCell.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/30.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSPurseListCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
/**
 设置按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@property (nonatomic, assign) BOOL SetMoRenWallet;
@property (weak, nonatomic) IBOutlet UILabel *walletName_title;
@end

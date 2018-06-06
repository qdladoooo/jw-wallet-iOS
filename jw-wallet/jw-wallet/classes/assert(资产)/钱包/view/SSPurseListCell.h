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
@property (nonatomic, assign) BOOL SetMoRenWallet;
@property (nonatomic, strong) void (^IsButtonnSelectedBlock)(BOOL);
@end

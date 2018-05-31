//
//  SSLanguageCell.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/31.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSLanguageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
+(instancetype)cellWithTableview:(UITableView *)tableview;
@end

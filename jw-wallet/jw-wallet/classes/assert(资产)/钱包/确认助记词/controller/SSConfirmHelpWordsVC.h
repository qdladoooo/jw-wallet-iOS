//
//  SSConfirmHelpWordsVC.h
//  conllectionDemo
//
//  Created by 王冠阳 on 2018/6/9.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSHelpWordsModel.h"
@interface SSConfirmHelpWordsVC : UIViewController

/**
 助记词数据源
 */
@property (nonatomic, copy) NSArray *dataArr;
@property (nonatomic,copy) NSString *helpwords;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong) SSHelpWordsModel *model;
-(void)draw;
@end

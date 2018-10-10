//
//  SSAsertHearView.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/27.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSAsertHearView : UIView
@property (weak, nonatomic) IBOutlet UILabel *walletName;

@property (weak, nonatomic) IBOutlet UIButton *walletNameAdressBtn;

+(UIView *)createAsertHearView;
@end

//
//  SSTouchIDVC.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/18.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSTouchIDVC : UIViewController
+ (SSTouchIDVC *_Nonnull)shareInstance;
- (void)verifyTouchId:(void(^_Nonnull)(BOOL success, NSError * __nullable error))result;
@end

//
//  SSGlobalWebView.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/12.
//  Copyright © 2018年 SHSF. All rights reserved.
//  公共的webView

#import <UIKit/UIKit.h>

@interface SSGlobalWebView : UIViewController
/** 标题展示 */
@property (nonatomic, copy) NSString *titleName;
/** 链接 */
@property (nonatomic, copy) NSString *urlString;
@end

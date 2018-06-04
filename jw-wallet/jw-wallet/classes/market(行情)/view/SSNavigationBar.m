//
//  SSNavigationBar.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/4.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSNavigationBar.h"
#import "SSEdiMarketsViewController.h"
#import "SSAddMarketsViewController.h"
@implementation SSNavigationBar

+(UIView *)creatNavigationBar{
    UIView *nav = [[[NSBundle mainBundle] loadNibNamed:@"SSNavigationBar" owner:nil options:nil] lastObject];
    return nav;
}
- (IBAction)back:(id)sender {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Edit:(id)sender {
    [self marketsControll];
}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
//        self.translatesAutoresizingMaskIntoConstraints = NO;
//        
//    }
//    return self;
//}
//
//- (void)updateConstraints{
//    [super updateConstraints];
//    NSArray *constrains = self.constraints;
//    for(NSLayoutConstraint *constraintin in constrains){
//        if(constraintin.firstAttribute == NSLayoutAttributeHeight){
//            if (SCREEN_HEIGHT == 812) {
//                constraintin.constant = 88;
//            }else{
//                constraintin.constant = 64;
//            }
//        }
//    }
//}

#pragma mark - 行情编辑
-(void)marketsControll{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"编辑行情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        SSEdiMarketsViewController *vc = [[SSEdiMarketsViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES];
        
    }];
    UIAlertAction *Action2 = [UIAlertAction actionWithTitle:@"添加行情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SSAddMarketsViewController *vc = [[SSAddMarketsViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //修改按钮
    
    [Action1 setValue:[UIColor colorFromHexRGB:@"333333"] forKey:@"titleTextColor"];
    [Action2 setValue:[UIColor colorFromHexRGB:@"333333"] forKey:@"titleTextColor"];
    [cancel setValue:[UIColor colorFromHexRGB:@"333333"] forKey:@"titleTextColor"];
    
    
    [alertController addAction:Action1];
    [alertController addAction:Action2];
    [alertController addAction:cancel];
    [self.viewController  presentViewController:alertController animated:YES completion:nil];
}


@end

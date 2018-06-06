//
//  SSConfirmHelpWordsVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/5.
//  Copyright © 2018年 SHSF. All rights reserved.
//
#define kItemHeight 26
#define kMinimumLineSpacing 5
#define kMinimumInteritemSpacing 5

#define kSectionEdgeInsetsLeft 15
#define kSectionEdgeInsetsBottom 0
#define kSectionEdgeInsetsTop 5
#define kSectionEdgeInsetsRight 15

#define kMarginTop 134


#import "ViewController.h"
//#import "TagCell.h"
#import "TagModel.h"
#import "SSConfirmHelpWordsVC.h"
#import "SSManagerPurseViewController.h"
@interface SSConfirmHelpWordsVC ()
@property (strong, nonatomic) NSMutableArray *originDataList;
@property (strong, nonatomic) NSMutableArray *selectedList;
@property (strong, nonatomic) NSMutableArray *unSelectedList;
//@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation SSConfirmHelpWordsVC
- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 下一步
- (IBAction)nextStep:(id)sender {
    [MBProgressHUD showText:@"你备份的助记词验证正确，是否从钱包移除该助记词？"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end

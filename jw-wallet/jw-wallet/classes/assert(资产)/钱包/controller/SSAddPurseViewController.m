//
//  SSAddPurseViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/29.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAddPurseViewController.h"

@interface SSAddPurseViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

/**
 textView占位字符
 */
@property (weak, nonatomic) IBOutlet UILabel *textViewPlaceHolderText;

@end

@implementation SSAddPurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.fd_prefersNavigationBarHidden = YES;
    self.textView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 点击事件
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)begainAddPurse:(id)sender {
    
}
#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    if (self.textView.text.length) {
        self.textViewPlaceHolderText.hidden = YES;
    }else{
        self.textViewPlaceHolderText.hidden = NO;
    }
}

@end

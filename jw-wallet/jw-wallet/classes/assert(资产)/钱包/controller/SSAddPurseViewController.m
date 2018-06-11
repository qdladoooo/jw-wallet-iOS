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
@property (weak, nonatomic) IBOutlet UIButton *helpMemoryBtn;
@property (weak, nonatomic) IBOutlet UIButton *privateKey;

@end

@implementation SSAddPurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.fd_prefersNavigationBarHidden = YES;
    self.textView.delegate = self;
    self.helpMemoryBtn.selected = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag==111) {
        self.helpMemoryBtn.selected = YES;
        self.privateKey.selected = NO;
        self.textViewPlaceHolderText.text = @"请填写助记词，按空格分隔";
    }else{
        self.privateKey.selected = YES;
        self.helpMemoryBtn.selected = NO;
        self.textViewPlaceHolderText.text = @"请填写明文私钥";
    }
    
}
#pragma mark - 点击事件
- (IBAction)back:(id)sender {
    if (self.isFromHomeAlert) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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

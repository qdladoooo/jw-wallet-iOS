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

/**
 助记词按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *helpMemoryBtn;

/**
 私钥按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *privateKey;
@property (weak, nonatomic) IBOutlet UILabel *nav_title;

@property (weak, nonatomic) IBOutlet UILabel *password_title;
@property (weak, nonatomic) IBOutlet UILabel *repeatPassword_title;
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;
@property (weak, nonatomic) IBOutlet UIButton *startImport;

@end

@implementation SSAddPurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nav_title.text = kLocalizedTableString(@"导入钱包", gy_LocalizableName);
    [self.helpMemoryBtn setTitle:kLocalizedTableString(@"助记词", gy_LocalizableName) forState:UIControlStateNormal];
    [self.privateKey setTitle:kLocalizedTableString(@"私钥", gy_LocalizableName) forState:UIControlStateNormal];
    self.password_title.text = kLocalizedTableString(@"密码", gy_LocalizableName);
    self.repeatPassword_title.text = kLocalizedTableString(@"重复密码", gy_LocalizableName);
    self.password1.placeholder = kLocalizedTableString(@"6位纯数字", gy_LocalizableName);
    self.password2.placeholder = kLocalizedTableString(@"6位纯数字", gy_LocalizableName);
    [self.startImport setTitle:kLocalizedTableString(@"开始导入", gy_LocalizableName) forState:UIControlStateNormal];
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
        self.textViewPlaceHolderText.text =kLocalizedTableString(@"请填写助记词，按空格分隔", gy_LocalizableName)  ;
    }else{
        self.privateKey.selected = YES;
        self.helpMemoryBtn.selected = NO;
        self.textViewPlaceHolderText.text =kLocalizedTableString(@"请填写明文私钥", gy_LocalizableName);
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

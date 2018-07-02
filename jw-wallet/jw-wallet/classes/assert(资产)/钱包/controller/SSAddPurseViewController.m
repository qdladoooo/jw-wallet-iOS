//
//  SSAddPurseViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/29.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAddPurseViewController.h"
#import "SSManagerPurseViewController.h"
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
@property (weak, nonatomic) IBOutlet UILabel *userName_title;
@property (weak, nonatomic) IBOutlet UILabel *password_title;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UIButton *startImport;

/**
 助记词内容
 */
@property (nonatomic, copy) NSString *helpWords;

/**
 私钥内容
 */
@property (nonatomic, copy) NSString *private_Key;

@end

@implementation SSAddPurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nav_title.text = kLocalizedTableString(@"导入钱包", gy_LocalizableName);
    [self.helpMemoryBtn setTitle:kLocalizedTableString(@"助记词", gy_LocalizableName) forState:UIControlStateNormal];
    [self.privateKey setTitle:kLocalizedTableString(@"私钥", gy_LocalizableName) forState:UIControlStateNormal];
    self.userName_title.text = kLocalizedTableString(@"用户名", gy_LocalizableName);
    self.userName.placeholder = kLocalizedTableString(@"请输入用户名", gy_LocalizableName);
    self.password_title.text = kLocalizedTableString(@"密码", gy_LocalizableName);

    self.password1.placeholder = kLocalizedTableString(@"6位纯数字", gy_LocalizableName);

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
        self.textView.text = self.helpWords;
        
    }else{
        self.privateKey.selected = YES;
        self.helpMemoryBtn.selected = NO;
        self.textViewPlaceHolderText.text =kLocalizedTableString(@"请填写明文私钥", gy_LocalizableName);
        self.textView.text = self.private_Key;
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
#pragma mark - 导入钱包
- (IBAction)begainAddPurse:(id)sender {
    if (self.helpMemoryBtn.selected) {
        if (self.helpWords.length == 0) {
            [MBProgressHUD showText:kLocalizedTableString(@"请填写助记词，按空格分隔", gy_LocalizableName) ];
            return;
        }
    }else{
        if (self.private_Key.length == 0) {
            [MBProgressHUD showText:kLocalizedTableString(@"请填写明文私钥", gy_LocalizableName)];
            return;
        }
    }
    
    if (self.userName.text.length == 0 ) {
        [MBProgressHUD showText:kLocalizedTableString(self.userName.placeholder, gy_LocalizableName)];
        return;
    }
    if (self.password1.text.length == 0 ) {
        [MBProgressHUD showText:kLocalizedTableString(self.password1.placeholder, gy_LocalizableName)];
        return;
    }else{
        if (self.password1.text.length != 6) {
            [MBProgressHUD showText:kLocalizedTableString(self.password1.placeholder, gy_LocalizableName)];
            return;
        }
    }

    
    // 开始导入
    [self SaveWalletInfoArray];
    // 返回
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    if (self.textView.text.length) {
        self.textViewPlaceHolderText.hidden = YES;
    }else{
        self.textViewPlaceHolderText.hidden = NO;
    }
    if (self.helpMemoryBtn.selected) {
        self.helpWords = self.textView.text;
    }
    if (self.privateKey.selected) {
        self.private_Key = self.textView.text;
    }
}

#pragma mark - 保存用户信息数组到数据库
-(void)SaveWalletInfoArray{
    
    NSMutableArray* walletInfoArr = [NSMutableArray array];
    NSDictionary *dict = @{
                           @"walletName":self.userName.text,
                           @"privatePassword":self.textView.text,
                           @"walletPassword":self.password1.text
                           };
    [walletInfoArr addObject:dict];
    //    SSWalletInfo *infoModel = [[SSWalletInfo alloc] init];
    //    infoModel.walletName = self.userName;
    //    infoModel.privatePassword = self.helpwords;
    //    infoModel.walletPassword = self.password;
    //    [walletInfoArr addObject:infoModel];
    /**
     存储标识名为wallet_Info数组.
     */
    [walletInfoArr bg_saveArrayWithName:wallet_Info];
    
    /**
     往标识名为@"testA"的数组中添加元素.
     */
    //[NSArray bg_addObjectWithName:@"testA" object:@[@(1),@"哈哈"]];
    
    /**
     更新标识名为testA的数组某个位置上的元素.
     */
    //[NSArray bg_updateObjectWithName:@"testA" Object:@"人妖" Index:0];
    
    /**
     删除标识名为testA的数组某个位置上的元素.
     */
    //[NSArray bg_deleteObjectWithName:@"testA" Index:3];
    
    /**
     查询标识名为testA的数组全部元素.
     */
    NSArray* testResult = [NSArray bg_arrayWithName:wallet_Info];
    
    /**
     获取标识名为testA的数组某个位置上的元素.
     */
    //    id arrObject = [NSArray bg_objectWithName:@"testA" Index:3];
    
    /**
     清除标识名为testA的数组所有元素.
     */
    //[NSArray bg_clearArrayWithName:@"testA"];
    
    NSLog(@"结果 = %@",testResult);
}
@end

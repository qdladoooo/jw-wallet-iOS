//
//  SSMatrixCodeVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/10.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSMatrixCodeVC.h"
#import "SSKeyStoreTipsCell.h"
#import "SGQRCode.h"
@interface SSMatrixCodeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, copy) NSArray *contentArr;
@property (weak, nonatomic) IBOutlet UIButton *showCode;

/**
 遮罩
 */
@property (weak, nonatomic) IBOutlet UIView *coverView;

/**
 二维码
 */
@property (weak, nonatomic) IBOutlet UIImageView *codeImage;

@end

@implementation SSMatrixCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = WHITCOLOR;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    _titleArr = @[@"仅供直接扫描",@"在安全环境下使用"];
    _contentArr = @[@"二维码禁止保存、截图、以及拍照。仅供用户在安全环境下直接扫描来方便的导入钱包",
                    @"请在确保四周无人及无摄像头的情况下使用，二维码一旦被他人获取将造成不可挽回的资产损失"];
     // 生成二维码(Default)
    [self setupGenerateQRCode];
    
}
// 生成二维码
- (void)setupGenerateQRCode {
    _codeImage.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:@"https://www.jd.com" imageViewWidth:_codeImage.width];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"SSKeyStoreTipsCell";
    SSKeyStoreTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SSKeyStoreTipsCell" owner:nil options:nil] lastObject];
    }
    cell.title.text = _titleArr[indexPath.row];
    cell.content.text = _contentArr[indexPath.row];
    return cell;
}
// 显示二维码
- (IBAction)showMatrixCode:(id)sender {
    
    [UIView animateWithDuration:1 delay:0.5 options:UIViewAnimationOptionShowHideTransitionViews  animations:^{
          self.coverView.alpha = .3f;
          self.codeImage.alpha = .3f;
    } completion:^(BOOL finished) {

         [self.coverView removeFromSuperview];
         self.codeImage.alpha = 1.0f;
        
    }];

    
 
}

@end

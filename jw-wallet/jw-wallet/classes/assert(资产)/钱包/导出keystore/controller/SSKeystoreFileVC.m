//
//  SSKeystoreFileVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/10.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSKeystoreFileVC.h"
#import "SSKeyStoreTipsCell.h"
#import "SSKeystoreContentCell.h"
@interface SSKeystoreFileVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, copy) NSArray *contentArr;
@end

@implementation SSKeystoreFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = WHITCOLOR;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    _titleArr = @[@"离线保存",@"请勿使用网络传输",@"密码保险箱保存"];
    _contentArr = @[@"请复制黏贴 Keystore 文件到安全、离线的地方保存。切勿保存至邮箱、记事本、网盘、聊天工具等，非常危险",
                    @"请勿通过网络工具传输 Keystore文件，一旦被黑客获取将造成不可挽回的资产损失。建议离线设备通过扫描二维码方式传输。",
                    @"如需在线保存，则建议使用安全等级更高的 1Password 等密码保管软件保存 Keystore"];
    [SJAlert creatAlertWithTitle:@"请勿截图" message:@"请确保四周无人及无任何摄像头！勿用截图或拍照的方式保存Keystore文件或对应二维码" actionMessage:@"知道了" ntroller:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return _titleArr.count;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100;
//}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *ID = @"SSKeyStoreTipsCell";
        SSKeyStoreTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SSKeyStoreTipsCell" owner:nil options:nil] lastObject];
        }
        cell.title.text = _titleArr[indexPath.row];
        cell.content.text = _contentArr[indexPath.row];
        return cell;
    }else{
        SSKeystoreContentCell *cell = [SSKeystoreContentCell cellWithTableVie:tableView];
        return cell;
    }
}

#pragma mark - 复制keystore
- (IBAction)copKeystore:(id)sender {
    [MBProgressHUD showText:@"已复制"];
}

@end

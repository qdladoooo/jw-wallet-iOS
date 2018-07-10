//
//  SSLanguageSetVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/31.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSLanguageSetVC.h"
#import "SSLanguageCell.h"
#import "HXLanguageManager.h"
#import "RootTabViewController.h"
@interface SSLanguageSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *dataAry;
@property (weak, nonatomic) IBOutlet UILabel *nav_title;

@end

@implementation SSLanguageSetVC
{
    NSInteger selectedState;
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    _dataAry = @[ @"zh-Hant", //中文繁体
                  @"en"];// 英语
    self.nav_title.text = kLocalizedTableString(@"语言设置", gy_LocalizableName);
    self.nav_title.font = [UIFont boldSystemFontOfSize:15];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSLanguageCell *cell = [SSLanguageCell cellWithTableview:tableView];
    
    if (indexPath.row == 0) {
        cell.title.text =  @"繁体中文";
    }else{
        cell.title.text = @"English";
    }
    NSString *language = [kLanguageManager languageFormat:self.dataAry[indexPath.row]];
    
    //当前语言
    NSString *currentLanguage = kLanguageManager.currentLanguage;
    
    if([currentLanguage rangeOfString:language].location != NSNotFound)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
   
    NSString *language = self.dataAry[indexPath.row];
    [kLanguageManager setUserlanguage:language];
    [self.tableview reloadData];
    NSLog(@"当前语言:%@",language);
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.navigationController popViewControllerAnimated:YES];
    } completion:^(BOOL finished) {
        // 我们要把系统windown的rootViewController替换掉
        RootTabViewController *tab = [[RootTabViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
        // 跳转到设置页
        tab.selectedIndex = 3;
    }];
    
}




@end

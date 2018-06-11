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
@interface SSLanguageSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *dataAry;
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
                  @"en-CN"];// 英语
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
 
    if (indexPath.row == 0) {
        
    }
    NSString *language = self.dataAry[indexPath.row];
    [kLanguageManager setUserlanguage:language];
    [self.tableview reloadData];
    NSLog(@"当前语言:%@",language);
    
}

////对应国家的语言
- (NSString *)ittemCountryLanguage:(NSString *)lang {
    NSString *language = [kLanguageManager languageFormat:lang];
    NSString *countryLanguage = [[[NSLocale alloc] initWithLocaleIdentifier:language] displayNameForKey:NSLocaleIdentifier value:language];
    return countryLanguage;
}



@end

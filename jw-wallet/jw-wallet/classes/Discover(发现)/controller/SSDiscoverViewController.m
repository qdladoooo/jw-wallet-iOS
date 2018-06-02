//
//  SSDiscoverViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/2.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSDiscoverViewController.h"
#import "SSBannerView.h"
#import "SSApplicationsShareView.h"
#import "SSArticleTableViewCell.h"
#import "SDCycleScrollView.h"
@interface SSDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) UIView *NormalHeaderView;
@property (nonatomic, strong) UILabel *NormalHeaderTitle;
@end

@implementation SSDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:24 green:244 blue:255 alpha:1];
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return 6;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 275;
    }else if(section == 1){
        return 45;
    }else if (section == 2){
        return 125;
    }else if (section == 3){
        return 45;
    }
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SSArticleTableViewCell *cell = [SSArticleTableViewCell cellWithTableView:tableView];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        SSBannerView *banner = [[[NSBundle mainBundle] loadNibNamed:@"SSBannerView" owner:nil options:nil] lastObject];
        return banner;
    }else if (section == 2){
        SSApplicationsShareView *appView = [[[NSBundle mainBundle] loadNibNamed:@"SSApplicationsShareView" owner:nil options:nil] lastObject];
        return appView;
    }
    else{
        
        
            _NormalHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
            _NormalHeaderView.backgroundColor = [UIColor colorFromHexRGB:@"f2f6ff"];
            _NormalHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_NormalHeaderView.frame) -5-12, SCREEN_WIDTH, 12)];
            _NormalHeaderTitle.textColor = [UIColor darkGrayColor];
            _NormalHeaderTitle.font = [UIFont systemFontOfSize:12];
            _NormalHeaderTitle.textAlignment = NSTextAlignmentLeft;
            [_NormalHeaderView addSubview:_NormalHeaderTitle];

            if (section == 1) {
                _NormalHeaderTitle.text = @"应用";
            }else if(section == 3){
                _NormalHeaderTitle.text = @"文章";
            }
        
        return _NormalHeaderView;
        
    }
    return nil;
}

// 网络加载图片的轮播器
//SDCycleScrollView *cycleScrollView = [cycleScrollViewWithFrame:frame delegate:delegate placeholderImage:placeholderImage];
//cycleScrollView.imageURLStringsGroup = imagesURLStrings;
//
//// 本地加载图片的轮播器
//SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame: imagesGroup:图片数组];

@end

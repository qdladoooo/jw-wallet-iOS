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
#import "SSAppScrollview.h"
@interface SSDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) UIView *NormalHeaderView;
@property (nonatomic, strong) UILabel *NormalHeaderTitle;
@property (nonatomic, copy) NSArray *imageArr;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) SSAppScrollview *appScrollview;
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
    _imageArr = [NSArray array];

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
        if (_cycleScrollView == nil) {
            _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 275) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
            _cycleScrollView.backgroundColor = [UIColor blackColor];
        }
        _cycleScrollView.imageURLStringsGroup = @[@"https://img.zcool.cn/community/017a40596eea61a8012193a3e8f019.jpg@2o.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527967337152&di=e3686479ec94c4f3e7c5a1a87835d572&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F015aeb591d13cfb5b3086ed4c94464.png",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527967337151&di=2d527d16eb9ceeb6b5318716e3bc4c49&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F011d75596ccb8da8012193a3569662.jpg%401280w_1l_2o_100sh.jpg"];
        _cycleScrollView.autoScrollTimeInterval = 3;
        _cycleScrollView.titlesGroup = @[@"哈哈",@"呵呵",@"嘻嘻"];
        _cycleScrollView.pageControlRightOffset = 100;
        
        return _cycleScrollView;
       
    }else if (section == 2){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125)];
        view.backgroundColor = [UIColor lightGrayColor];
        return view;
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

//#pragma mark - 轮播图
//-(SDCycleScrollView *)cycleScrollView{
//    if (_cycleScrollView == nil) {
//        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 275) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
//        _cycleScrollView.backgroundColor = [UIColor redColor];
//    }
//    _cycleScrollView.imageURLStringsGroup = @[@"https://img.zcool.cn/community/017a40596eea61a8012193a3e8f019.jpg@2o.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527967337152&di=e3686479ec94c4f3e7c5a1a87835d572&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F015aeb591d13cfb5b3086ed4c94464.png",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527967337151&di=2d527d16eb9ceeb6b5318716e3bc4c49&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F011d75596ccb8da8012193a3569662.jpg%401280w_1l_2o_100sh.jpg"];
//    return _cycleScrollView;
//}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了%ld个图片",index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
     NSLog(@"当前是第%ld个图片",index);
}
@end

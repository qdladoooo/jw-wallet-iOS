//
//  SSDiscoverViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/2.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSDiscoverViewController.h"
#import "SSApplicationsShareView.h"
#import "SSArticleTableViewCell.h"
#import "SDCycleScrollView.h"
#import "YYBHorizontalCollectionView.h"
#import "YYBHCModel.h"
#import "YYBHorizontalCollectionCell.h"
#import "HXSearchBar.h"
#import "SSAPPCell.h"

@interface SSDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,YYBHorizontalCollectionViewDelegate,UISearchBarDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) UIView *NormalHeaderView;
@property (nonatomic, strong) UILabel *NormalHeaderTitle;
@property (nonatomic, copy) NSArray *imageArr;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end

@implementation SSDiscoverViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    self.tableView.separatorColor = BORDER_COLOR;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    view.backgroundColor = MAIN_GROUNDCOLOR;
    [self.view addSubview:view];
    [self addSearchBar];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, SCREEN_HEIGHT-80) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = MAIN_GROUNDCOLOR;
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

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.contentSize = CGSizeMake(SCREEN_WIDTH,self.tableView.height-80 );
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 6;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 262;
    }else if(section == 1){
        return 45;
    }else if (section == 2){
        return 125;
    }else if (section == 3){
        return 45;
    }
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

//    SSArticleTableViewCell *cell = [SSArticleTableViewCell cellWithTableView:tableView];
//    return cell;
    SSAPPCell *cell = [SSAPPCell cellWithTableView:tableView];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (_cycleScrollView == nil) {
            
            _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 262) delegate:self placeholderImage:[UIImage imageNamed:@""]];
            
        }
        _cycleScrollView.imageURLStringsGroup = @[@"https://img.zcool.cn/community/017a40596eea61a8012193a3e8f019.jpg@2o.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527967337152&di=e3686479ec94c4f3e7c5a1a87835d572&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F015aeb591d13cfb5b3086ed4c94464.png",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527967337151&di=2d527d16eb9ceeb6b5318716e3bc4c49&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F011d75596ccb8da8012193a3569662.jpg%401280w_1l_2o_100sh.jpg"];
//        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        _cycleScrollView.currentPageDotColor = [UIColor whiteColor];
//        _cycleScrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:0.5];
//        _cycleScrollView.pageControlDotSize = CGSizeMake(20, 6);  // pageControl小点的大小
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _cycleScrollView.autoScrollTimeInterval = 3;
        _cycleScrollView.zoomType = YES;
        _cycleScrollView.ShowGradientLayer = YES;
    
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        //        _cycleScrollView.pageControlRightOffset = 100;
        //        _cycleScrollView.titlesGroup = @[@"哈哈",@"呵呵",@"嘻嘻"];

        return _cycleScrollView;
       
    }else if (section == 2){ // app
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:20];
        for (int i = 0; i < 20; i ++) {
            YYBHCModel *model = [[YYBHCModel alloc]init];
            model.imagestring = @"eos";
            model.labelstring = [NSString stringWithFormat:@"应用%d",i];
            [dataArray addObject:model];
        }
        NSArray *models = (NSArray *)dataArray;
        
        
          YYBHorizontalCollectionView *hcollectionview = [[YYBHorizontalCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125) ItemSize:CGSizeMake(80, 125) MinimumLineSpacing:5 MinimumInteritemSpacing:0];
        hcollectionview.models = models;
        hcollectionview.yybdelegate = self;
        return hcollectionview;
    }
    else{
        
            _NormalHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
            _NormalHeaderView.backgroundColor = BACKGROUNDCOLOR;
            _NormalHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_NormalHeaderView.frame) -5-12, SCREEN_WIDTH, 12)];
            _NormalHeaderTitle.textColor = FONT_DARKGRAYCOLOR;
            _NormalHeaderTitle.font = [UIFont systemFontOfSize:12];
            _NormalHeaderTitle.textAlignment = NSTextAlignmentLeft;
            [_NormalHeaderView addSubview:_NormalHeaderTitle];

            if (section == 1) {
                _NormalHeaderTitle.text = kLocalizedTableString(@"应用", gy_LocalizableName);
            }else if(section == 3){
                _NormalHeaderTitle.text = kLocalizedTableString(@"文章", gy_LocalizableName);
            }
        
        return _NormalHeaderView;
        
    }

    return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSGlobalWebView *web = [[SSGlobalWebView alloc] init];
    web.urlString = @"https://www.baidu.com";
    [self.navigationController pushViewController:web animated:YES];
}


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了%ld个图片",index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
//     NSLog(@"当前是第%ld个图片",index);
    
}

#pragma mark - YYBHorizontalCollectionViewDelegate
- (void)YYBHorizontalcollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
}
//添加搜索条
- (void)addSearchBar {
    //加上 搜索栏
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    searchBarView.backgroundColor = rgba(7, 12, 47, 1);
    [self.view addSubview:searchBarView];
    HXSearchBar *searchBar = [[HXSearchBar alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 20, 34)];
    searchBar.delegate = self;
    //输入框提示
    searchBar.placeholder = @"搜索应用";
    //光标颜色
    searchBar.cursorColor = [UIColor lightGrayColor];
    //TextField
    searchBar.searchBarTextField.layer.cornerRadius = 17;
    searchBar.searchBarTextField.layer.masksToBounds = YES;
//    searchBar.searchBarTextField.layer.borderColor = [UIColor redColor].CGColor;
//    searchBar.searchBarTextField.layer.borderWidth = 1.0;
    
    //清除按钮图标
    //    searchBar.clearButtonImage = [UIImage imageNamed:@"demand_delete"];
    
    //去掉取消按钮灰色背景
    searchBar.hideSearchBarBackgroundImage = YES;
    
    [searchBarView addSubview:searchBar];
}
#pragma mark - UISearchBar Delegate

//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    HXSearchBar *sear = (HXSearchBar *)searchBar;
    //取消按钮
    sear.cancleButton.backgroundColor = [UIColor clearColor];
    [sear.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [sear.cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sear.cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
}

//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText:%@",searchText);
}

//搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

//取消按钮点击的回调
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [self.view endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 背景色
    if (self.tableView.contentOffset.y>0) {
        self.tableView.backgroundColor = BACKGROUNDCOLOR;
    }else{
        self.tableView.backgroundColor = [UIColor clearColor];
    }

}
@end

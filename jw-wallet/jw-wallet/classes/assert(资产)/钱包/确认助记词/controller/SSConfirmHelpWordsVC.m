//
//  SSConfirmHelpWordsVC.m
//  conllectionDemo
//
//  Created by 王冠阳 on 2018/6/9.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSConfirmHelpWordsVC.h"
#import "HZQTagCell.h"
#import "GTButtonTagsView.h"
#import "SSTagModel.h"

// 每行个数
#define RowCount 4

// 每个按钮的高度
#define BtnHeight 30
@interface SSConfirmHelpWordsVC () <GTButtonTagsViewDelegate>
{
    NSMutableArray *_titles;
    NSMutableArray *_selectedStatusTitles; // 选中状态下的标题
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;
@property (weak, nonatomic) IBOutlet GTButtonTagsView *labelsView;

@property (weak, nonatomic) IBOutlet UILabel *nav_title;
@property (weak, nonatomic) IBOutlet UILabel *makeSureYourHelpWords;
@property (weak, nonatomic) IBOutlet UILabel *tips;
@property (weak, nonatomic) IBOutlet UIButton *nextStep;

/**
 最后得到的助记词
 */
@property (nonatomic, copy)NSString *finalStr;
/**
 数据源模型
 */
@property (nonatomic, strong)SSTagModel *tagModel;
@end

@implementation SSConfirmHelpWordsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    _titles = [NSMutableArray array];
    // 国际化
    self.nav_title.text = kLocalizedTableString(@"确认助记词", gy_LocalizableName);
    self.makeSureYourHelpWords.text = kLocalizedTableString(@"确认你的钱包助记词", gy_LocalizableName);
    self.tips.text = kLocalizedTableString(_tips.text, gy_LocalizableName);
    [self.nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    
    [self setupColloctionView];
    
    
    // --------bottomview

    self.labelsView.delegate = self;
    
    [self randomArr:self.dataArr];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



/** 设置collectionViewHeight */
- (void)settingCollectionViewHeight {
    
    // 初始高度
    if (_titles.count == 0) {
        self.collectionViewHeight.constant = 40.0f;
        return;
    }
    
    if (_titles.count % RowCount == 0) {
        self.collectionViewHeight.constant = ((BtnHeight + 10) * _titles.count / RowCount);
        
    } else {
        self.collectionViewHeight.constant = ((BtnHeight + 10) * ((_titles.count / RowCount) + 1));
    }
    
}

/** 设置ColloctionView属性 */
- (void)setupColloctionView
{
    // 设置collectionViewHeight
    [self settingCollectionViewHeight];
    
    //设置代理
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[HZQTagCell class] forCellWithReuseIdentifier:@"cell"];
    
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titles.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    HZQTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    
    cell.text.text = _titles[indexPath.row];
    
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    int count = RowCount;
    float padding = (count+2)*(count+1);
    
    return CGSizeMake((SCREEN_WIDTH-padding)/count, BtnHeight);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_titles removeObjectAtIndex:indexPath.row];
    
    [self.collectionView reloadData];
    
    // 设置collectionViewHeight
    [self settingCollectionViewHeight];
    
    [self.view layoutIfNeeded];
}

#pragma mark -  <GTButtonTagsViewDelegate>


-(void)GTButtonTagsView:(GTButtonTagsView *)view selectIndex:(NSInteger)index selectText:(NSString *)text {
    NSLog(@"第: %ld 文本: %@", index, text);
  
    if (_titles.count>=_dataArr.count) {
        return;
    }
      [self randomArr:_dataArr];
    [self.labelsView layoutIfNeeded];
    [_titles addObject:text];
    [self.collectionView reloadData];
    [self settingCollectionViewHeight];
   

}
#pragma mark - 下一步
- (IBAction)nextStep:(id)sender {
    SSLog(@"助记词顺序--%@",_titles);
    _finalStr = [_titles componentsJoinedByString:@""]; // 为分隔符
    SSLog(@"%@",_finalStr);
    [self requestData];
}
#pragma mark - 网络请求
-(void)requestData{
    
    //  参数：brain_key:助记词   username：用户名
    NSDictionary *params = @{
                             @"brain_key":_finalStr,
                             @"username":@"123"
                             };
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURLString,CreatWallet];
    [HttpTool postWithURL:url params:params success:^(id json) {
        SSLog(@"%@",json);
        [MBProgressHUD showText:json[@"reason"]];
    } failure:^(NSError *error) {
         SSLog(@"%@",error);
    }];
    
}
#pragma mark - 随机打乱的数组
-(void)randomArr:(NSArray *)arr{
//    NSArray* arr = self.dataArr;
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    SSLog(@"随机打乱的数组%@",arr);
    self.labelsView.dataArr = arr;
}
@end

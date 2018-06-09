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


@end

@implementation SSConfirmHelpWordsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    _titles = [NSMutableArray array];
    
//    [_titles addObject:@"三年级1班"];
//    [_titles addObject:@"三年级2班"];
//    [_titles addObject:@"三年级3班"];
//    [_titles addObject:@"三年级4班"];
//    [_titles addObject:@"三年级5班"];
//    [_titles addObject:@"三年级6班"];
//    [_titles addObject:@"三年级7班"];
    
    [self setupColloctionView];
    
    
    // --------bottomview
    
    self.labelsView.delegate = self;
    self.labelsView.dataArr = @[@"fghjkfgh",@"fghjkfgh",@"fghjkfgh",@"fghjkfgh",@"fghjkfgh",@"fghjkfgh",@"fghjkfgh",@"fghjkfgh",@"fghjkfgh",@"fghjkfgh",@"fghjkfgh",@"fghjkfgh",@"fghjkfgh"];
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
    if (_titles.count>=12) {
        return;
    }
  
    [_titles addObject:text];
    [self.collectionView reloadData];
    [self settingCollectionViewHeight];
   

}
#pragma mark - 下一步
- (IBAction)nextStep:(id)sender {
    
}

@end

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
#import "BGFMDB.h"
#import "SSWalletInfo.h"
#import "SSManagerPurseViewController.h"
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
@property (strong, nonatomic) IBOutlet GTButtonTagsView *labelsView;

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

    // 数据库操作
     bg_setDebug(YES);//打开调试模式,打印输出调试信息.
    
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
    _finalStr = [_titles componentsJoinedByString:@" "]; // 为分隔符
    SSLog(@"%@",_finalStr);
    [self requestData];
}
#pragma mark - 网络请求
-(void)requestData{
    
    //  参数：brain_key:助记词   username：用户名
    NSDictionary *params = @{
                             @"brain_key":_finalStr,
                             @"username":_userName
                             };
     [MBProgressHUD showHUDOnView:self.view];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURLString,CreatWallet];
    [HttpTool postWithURL:url params:params success:^(id json) {
        SSLog(@"%@",json);
        
        if ([json[@"result_code"] integerValue] == 10000) {
            [MBProgressHUD showText:@"创建钱包成功！"];
            [self SaveWalletInfoArray]; // 保存用户信息
            // 保存（助记词）私钥
            [UserDefaultUtil saveValue:self.helpwords forKey:private_password];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
                [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];

            });
            
        }else{
            [MBProgressHUD showText:json[@"reason"]];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:wallet_password];
        }
        [MBProgressHUD hiddenForView:self.view];
    } failure:^(NSError *error) {
         SSLog(@"%@",error);
        [MBProgressHUD hiddenForView:self.view];
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


#pragma mark - 保存用户信息数组到数据库
-(void)SaveWalletInfoArray{
    
    NSMutableArray* walletInfoArr = [NSMutableArray array];
    NSDictionary *dict = @{
                           @"walletName":self.userName,
                           @"privatePassword":self.helpwords,
                           @"walletPassword":self.password
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

//
//  SSConfirmHelpWordsVC.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/5.
//  Copyright © 2018年 SHSF. All rights reserved.
//


#import "ViewController.h"

#import "TagModel.h"
#import "SSConfirmHelpWordsVC.h"
#import "SSManagerPurseViewController.h"
#import "YZTagList.h"
#import "SSconfirmHeaderView.h"
#import "SSSelectedTableViewCell.h"
#import "SSUnSelectedTableViewCell.h"
#import "SSTagCellCollectionViewCell.h"
static NSString * const SelectedCellIdentifer = @"SSSelectedTableViewCell";

static NSString * const UnselectedCellIdentifer = @"SSUnSelectedTableViewCell";

@interface SSConfirmHelpWordsVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate>

//@property (nonatomic, strong) NSMutableArray *groups;

@property (nonatomic, strong) NSMutableDictionary *selectTagDict;

@property (nonatomic, strong) NSMutableArray *deleteList;
@property (strong, nonatomic) NSMutableArray *selectedList; // 已选数组
@property (strong, nonatomic) NSMutableArray *unSelectedList; // 候选数组
@property (nonatomic, strong) YZTagList *tagList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SSConfirmHelpWordsVC
- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    

}

- (NSMutableDictionary *)selectTagDict
{
    if (_selectTagDict == nil) {
        _selectTagDict = [NSMutableDictionary dictionary];
    }
    return _selectTagDict;
}
- (YZTagList *)tagList
{
    if (_tagList == nil) {
        _tagList = [[YZTagList alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        _tagList.tagBackgroundColor = [UIColor colorWithRed:20 / 255.0 green:145 / 255.0 blue:255 / 255.0 alpha:1];
        _tagList.tagCornerRadius = 7;
        __weak typeof(self) weakSelf = self;
        _tagList.clickTagBlock = ^(NSString *tag){
            [weakSelf clickTag:tag];
            
        };
        _tagList.tagColor = [UIColor whiteColor];
    }
    _tagList.backgroundColor = [UIColor lightGrayColor];
    return _tagList;
}

- (void)clickTag:(NSString *)tag
{
    // 删除标签
    [_tagList deleteTag:tag];
    
    // 刷新第0组
    NSIndexSet *indexSex = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSex withRowAnimation:UITableViewRowAnimationNone];
    
    
    
    // 更新cell标题
//    SSTagCellCollectionViewCell *cell = self.selectTagDict[tag];
    
//    cell.tagLabel
//    YZTagItem *item = cell.item;
//    item.isSelected = !item.isSelected;
//    cell.item = item;
//    cell.tagLabel =

//     移除选中的cell
//    [self.selectTagDict removeObjectForKey:tag];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    
    _unSelectedList = [NSMutableArray array];
    _selectedList = [NSMutableArray array];
    
    [_selectedList addObjectsFromArray:@[@"hello",@"hello",@"hello"]];
    [_unSelectedList addObjectsFromArray:@[@"hello",@"hello",@"hello",@"hello",@"hello",@"hello",@"hello",@"hello",@"hello",@"hello",@"hello",@"hello",@"hello"]];
    
    // 注册已选cell
    [self.tableView registerClass:[SSSelectedTableViewCell class] forCellReuseIdentifier:SelectedCellIdentifer];
    // 注册待选cell
    [self.tableView registerNib:[UINib nibWithNibName:@"SSUnSelectedTableViewCell" bundle:nil] forCellReuseIdentifier:UnselectedCellIdentifer];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return _tagList.tagListH;

    }else{
        CGFloat itemH = 30;
        CGFloat originY = 27;
        CGFloat margin = 10;
        NSInteger cols = 4;
        NSInteger rows = (self.unSelectedList.count - 1) / cols + 1;
        CGFloat cellH = rows * (itemH + margin) + originY;
        return cellH;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 105;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        SSSelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectedCellIdentifer];
        cell.tagList = self.tagList;
        cell.backgroundColor = [UIColor lightGrayColor];
        return cell;
    }else{
        
        SSUnSelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UnselectedCellIdentifer forIndexPath:indexPath];
        cell.collectionView.delegate = self;
        cell.itemsArr = self.unSelectedList;
        return cell;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SSconfirmHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"SSconfirmHeaderView" owner:nil options:nil] lastObject];
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    // footerView
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 75)];
    // 下一步按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 45)];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    btn.titleLabel.textColor = WHITCOLOR;
    btn.backgroundColor = Bluecolor;
    [btn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:btn];
    return footerView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SSTagCellCollectionViewCell *cell = (SSTagCellCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    NSString *tagStr = [NSString stringWithFormat:@"%@",cell.tagLabel.text];
    [self.tagList addTag:tagStr];
//    cell.isSelected = !cell.selected;
//    if (cell.isSelected) {
//        // 添加标签
//        [self.tagList addTag:tagStr];
//
//    } else {
//        // 删除标签
//        [self.tagList deleteTag:tagStr];
//    }
    
    // 刷新第0组
    NSIndexSet *indexSex = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSex withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark - 下一步
-(void)nextStep{
    [MBProgressHUD showText:@"你备份的助记词验证正确，是否从钱包移除该助记词？"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end

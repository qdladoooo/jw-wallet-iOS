//
//  YYBHorizontalCollectionView.m
//  YouYouBao
//
//  Created by Funny on 2017/4/13.
//  Copyright © 2017年 Funny. All rights reserved.
//

#import "YYBHorizontalCollectionView.h"
#import "YYBHorizontalCollectionCell.h"
#import "YYBHCModel.h"

static NSString *YYBHorizontalIdentifier = @"YYBHorizontalIdentifier";

#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))


@interface YYBHorizontalCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation YYBHorizontalCollectionView

- (id)initWithFrame:(CGRect)frame ItemSize:(CGSize)itemSize MinimumLineSpacing:(CGFloat)minimumLineSpacing MinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = itemSize;
    flowLayout.minimumLineSpacing = minimumLineSpacing;
    flowLayout.minimumInteritemSpacing = minimumInteritemSpacing;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        
        [self setContentInset:UIEdgeInsetsMake(15, 15, 15, 15)];
        
        [self registerClass:[YYBHorizontalCollectionCell class] forCellWithReuseIdentifier:YYBHorizontalIdentifier];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.models.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YYBHorizontalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YYBHorizontalIdentifier forIndexPath:indexPath];
    YYBHCModel *model = [self.models objectAtIndex:indexPath.item];
    [cell setDisplayImageString:model.imagestring DescripLabelString:model.labelstring];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if ( !IsNilOrNull(self.yybdelegate) && [self.yybdelegate respondsToSelector:@selector(YYBHorizontalcollectionView:didSelectItemAtIndexPath:)]) {
        
        [self.yybdelegate YYBHorizontalcollectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
    
    if (self.yybHorizontalCollectionBlock) {
        self.yybHorizontalCollectionBlock(collectionView, indexPath);
    }
}

@end

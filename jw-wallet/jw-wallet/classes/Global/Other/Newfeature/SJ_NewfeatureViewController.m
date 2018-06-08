//
//  SJ_NewfeatureViewController.m
//  ShouJinLiCai
//
//  Created by 王冠阳 on 16/4/7.
//  Copyright © 2016年 shoujinwang. All rights reserved.
//

#import "SJ_NewfeatureViewController.h"
#import "SSAsertViewController.h"
#import "RootTabViewController.h"

#define SJ_NewfeatureImageCount 3
@interface SJ_NewfeatureViewController ()<UIScrollViewDelegate>
//@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SJ_NewfeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加UISrollView
    [self setupScrollView];
    
    // 2.添加pageControl
//    [self setupPageControl];
}

/**
 *  添加pageControl
 */
//- (void)setupPageControl
//{
//    // 1.添加
//    UIPageControl *pageControl = [[UIPageControl alloc] init];
//    pageControl.numberOfPages = SJ_NewfeatureImageCount;
//    CGFloat centerX = self.view.frame.size.width * 0.5;
//    CGFloat centerY = self.view.frame.size.height - 30;
//    pageControl.center = CGPointMake(centerX, centerY);
//    pageControl.bounds = CGRectMake(0, 0, 100, 30);
//    pageControl.userInteractionEnabled = NO;
//    [self.view addSubview:pageControl];
//    self.pageControl = pageControl;
//
//    // 2.设置圆点的颜色  SJ_RGB_COLOR
//
//    pageControl.currentPageIndicatorTintColor =  rgba(253, 98, 42,1);
//    pageControl.pageIndicatorTintColor = rgba(189, 189, 189,1);
//}

/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0; index<SJ_NewfeatureImageCount; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        // 设置图片
        NSString *name = [NSString stringWithFormat:@"2018guide_%d", index];
        imageView.image = [UIImage imageNamed:name];
        
        // 设置frame
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        // 在最后一个图片上面添加按钮
        if (index == SJ_NewfeatureImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
//    // 3.设置滚动的内容尺寸
//    scrollView.contentSize = CGSizeMake(imageW * SJ_NewfeatureImageCount, 0);
//    scrollView.showsHorizontalScrollIndicator = NO;
//    scrollView.pagingEnabled = YES;
//    scrollView.bounces = NO;
    
    // 3.设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(imageW * SJ_NewfeatureImageCount+10, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    _scrollView = scrollView;
}

/**
 *  添加内容到最后一个图片
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0.让imageView能跟用户交互
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    
    // 2.设置frame
    
    startButton.frame = CGRectMake(0, SCREEN_HEIGHT * 0.9,SCREEN_WIDTH / 2,  SCREEN_WIDTH * 50 / 320);
    startButton.centerX = SCREEN_WIDTH / 2;
    
    
    // 3.设置文字
//    [startButton setTitle:@"开始体验" forState:UIControlStateNormal];
//    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    
}

/**
 *  开始按钮
 */
- (void)start
{
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 切换窗口的根控制器
   RootTabViewController *RootVc = [[RootTabViewController alloc] init];
    self.view.window.rootViewController = RootVc;
    
    // 结束之后再弹首页view
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"EndNewFeature"];
}

- (void)checkboxClick:(UIButton *)checkbox
{
    checkbox.selected = !checkbox.isSelected;
}


/**
 *  只要UIScrollView滚动了,就会调用
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    //    // 2.求出页码
//        double pageDouble = offsetX / scrollView.frame.size.width;
//        int pageInt = (int)(pageDouble + 0.5);
//        self.pageControl.currentPage = pageInt;
    
    if (offsetX>_scrollView.width*2) {

        RootTabViewController *RootVc = [[RootTabViewController alloc] init];
        self.view.window.rootViewController = RootVc;
        RootVc.selectedIndex = 0;
        
        // 结束之后再弹首页view
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"EndNewFeature"];

    }
}

@end

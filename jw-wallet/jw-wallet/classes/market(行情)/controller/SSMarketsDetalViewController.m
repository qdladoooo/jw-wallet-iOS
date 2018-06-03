//
//  SSMarketsDetalViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/3.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSMarketsDetalViewController.h"
#import "AAChartKit.h"
@interface SSMarketsDetalViewController ()
@property (strong, nonatomic) AAChartView  *chartBackview;

@property (nonatomic, strong)  AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;
@end

@implementation SSMarketsDetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    
//    创建视图AAChartView
    CGFloat chartViewWidth  = self.view.frame.size.width;
    CGFloat chartViewHeight = self.view.frame.size.height/2-50;
    _aaChartView = [[AAChartView alloc]init];
    _aaChartView.frame = CGRectMake(0,SCREEN_HEIGHT/2 , chartViewWidth, chartViewHeight);
    ////禁用 AAChartView 滚动效果(默认不禁用)
    //self.aaChartView.scrollEnabled = NO;
    ////设置图表视图的内容高度(默认 contentHeight 和 AAChartView 的高度相同)
    //_aaChartView.contentHeight = chartViewHeight;
    [self.view addSubview:_aaChartView];
    
//    2.配置视图模型AAChartModel
    _aaChartModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartStackingTypeFalse)//设置图表的类型(这里以设置的为柱状图为例)
    .titleSet(@"编程语言热度")//设置图表标题
    .subtitleSet(@"虚拟数据")//设置图表副标题
    .categoriesSet(@[@"Java",@"Swift",@"Python",@"Ruby", @"PHP",@"Go",@"C",@"C#",@"C++"])//图表横轴的内容
    .yAxisTitleSet(@"摄氏度")//设置图表 y 轴的单位
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"2017")
                 .dataSet(@[@7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2, @26.5, @23.3, @18.3, @13.9, @9.6]),
                 AAObject(AASeriesElement)
                 .nameSet(@"2018")
                 .dataSet(@[@0.2, @0.8, @5.7, @11.3, @17.0, @22.0, @24.8, @24.1, @20.1, @14.1, @8.6, @2.5]),
                 AAObject(AASeriesElement)
                 .nameSet(@"2019")
                 .dataSet(@[@0.9, @0.6, @3.5, @8.4, @13.5, @17.0, @18.6, @17.9, @14.3, @9.0, @3.9, @1.0]),
                 AAObject(AASeriesElement)
                 .nameSet(@"2020")
                 .dataSet(@[@3.9, @4.2, @5.7, @8.5, @11.9, @15.2, @17.0, @16.6, @14.2, @10.3, @6.6, @4.8]),
                 ])
    ;
    
//    3.绘制图形(创建 AAChartView 实例对象后,首次绘制图形调用此方法)
    /*图表视图对象调用图表模型对象,绘制最终图形*/
    [_aaChartView aa_drawChartWithChartModel:_aaChartModel];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 返回
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

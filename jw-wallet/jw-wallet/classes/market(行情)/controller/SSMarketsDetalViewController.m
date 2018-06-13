//
//  SSMarketsDetalViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/3.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSMarketsDetalViewController.h"
#import "UIColor+YYStockTheme.h"
#import "UIColor+YYStockTheme.h"
#import "Masonry.h"
#import "YYFiveRecordModel.h"
#import "YYLineDataModel.h"
#import "YYTimeLineModel.h"
#import "YYStockVariable.h"
#import "AppServer.h"
#import "YYStock.h"

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define SCREEN_MAX_LENGTH MAX(kScreenWidth,kScreenHeight)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)
@interface SSMarketsDetalViewController ()

/**
 蓝点
 */
@property (weak, nonatomic) IBOutlet UIView *bluePoint;

/**
 灰dian
 */
@property (weak, nonatomic) IBOutlet UIView *grayPoint;

/**
 行情走势图backview
 */
@property (weak, nonatomic) IBOutlet UIView *KLineBackView;

/**
 K线数据源
 */
@property (strong, nonatomic) NSMutableDictionary *stockDatadict;
@property (copy, nonatomic) NSArray *stockDataKeyArray;
@property (copy, nonatomic) NSArray *stockTopBarTitleArray;
@property (strong, nonatomic) YYFiveRecordModel *fiveRecordModel;

@property (strong, nonatomic) YYStock *stock;
@property (nonatomic, assign) NSString *stockId;
@property (weak, nonatomic) UIView *fullScreenView;

/**
 是否显示五档图
 */
@property (assign, nonatomic) BOOL isShowFiveRecord;

@property (weak, nonatomic) IBOutlet UILabel *nav_title;

@end

@implementation SSMarketsDetalViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 返回
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (instancetype)initWithStockId:(NSString *)stockId title:(NSString *)title isShowFiveRecord:(BOOL)isShowFiveRecord {
    self = [super init];
    if(self) {
        _isShowFiveRecord = isShowFiveRecord;
        _stockId = @"88888888";
        self.navigationItem.title = @"YY股(88888888)";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.fd_prefersNavigationBarHidden = YES;
    self.nav_title.text = kLocalizedTableString(@"行情详情", gy_LocalizableName);
    [self.bluePoint.layer setCornerRadius:4];
    [self.grayPoint.layer setCornerRadius:4];
    //测试数据
    {
        _isShowFiveRecord = NO;
        _stockId = @"88888888";
        self.navigationItem.title = @"YY股(88888888)";
    }
    
    [self initStockView];
    [self fetchData];
    
}

// 初始化视图
- (void)initStockView {
    [YYStockVariable setStockLineWidthArray:@[@6,@6,@6,@6]];
    
    YYStock *stock = [[YYStock alloc]initWithFrame:self.KLineBackView.frame dataSource:self];
    _stock = stock;
    [self.KLineBackView addSubview:stock.mainView];
    [stock.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.KLineBackView);
    }];
    
}

/*******************************************股票数据源获取更新*********************************************/
/**
 网络获取K线数据
 */
- (void)fetchData {
    
    [AppServer Get:@"five" params:nil success:^(NSDictionary *response) {
        if (self.isShowFiveRecord) {
            self.fiveRecordModel = [[YYFiveRecordModel alloc]initWithDict:response[@"sshq"]];
            [self.stock draw];
        }
    } fail:^(NSDictionary *info) {
        
    }];
    
    [AppServer Get:@"day" params:nil success:^(NSDictionary *response) {
        NSMutableArray *array = [NSMutableArray array];
        __block YYLineDataModel *preModel;
        [response[@"dayhqs"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YYLineDataModel *model = [[YYLineDataModel alloc]initWithDict:obj];
            model.preDataModel = preModel;
            [model updateMA:response[@"dayhqs"] index:idx];
            NSString *day = [NSString stringWithFormat:@"%@",obj[@"day"]];
            if ([response[@"dayhqs"] count] % 18 == ([response[@"dayhqs"] indexOfObject:obj] + 1 )%18 ) {
                model.showDay = [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
            }
            [array addObject: model];
            preModel = model;
        }];
        [self.stockDatadict setObject:array forKey:@"dayhqs"];
    } fail:^(NSDictionary *info) {
        
    }];
    
    [AppServer Get:@"minute" params:nil success:^(NSDictionary *response) {
        NSMutableArray *array = [NSMutableArray array];
        [response[@"minutes"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YYTimeLineModel *model = [[YYTimeLineModel alloc]initWithDict:obj];
            [array addObject: model];
        }];
        [self.stockDatadict setObject:array forKey:@"minutes"];
        [self.stock draw];
        
    } fail:^(NSDictionary *info) {
    }];
}


/*******************************************股票数据源代理*********************************************/
-(NSArray <NSString *> *) titleItemsOfStock:(YYStock *)stock {
    return self.stockTopBarTitleArray;
}

-(NSArray *) YYStock:(YYStock *)stock stockDatasOfIndex:(NSInteger)index {
    return index < self.stockDataKeyArray.count ? self.stockDatadict[self.stockDataKeyArray[index]] : nil;
}

-(YYStockType)stockTypeOfIndex:(NSInteger)index {
    return index == 0 ? YYStockTypeTimeLine : YYStockTypeLine;
}

- (id<YYStockFiveRecordProtocol>)fiveRecordModelOfIndex:(NSInteger)index {
    return self.fiveRecordModel;
}

- (BOOL)isShowfiveRecordModelOfIndex:(NSInteger)index {
    return self.isShowFiveRecord;
}


/*******************************************getter*********************************************/
- (NSMutableDictionary *)stockDatadict {
    if (!_stockDatadict) {
        _stockDatadict = [NSMutableDictionary dictionary];
    }
    return _stockDatadict;
}

- (NSArray *)stockDataKeyArray {
    if (!_stockDataKeyArray) {
        _stockDataKeyArray = @[@"minutes"
//                               ,@"dayhqs"
                               ];
    }
    return _stockDataKeyArray;
}

- (NSArray *)stockTopBarTitleArray {
    if (!_stockTopBarTitleArray) {
        _stockTopBarTitleArray = @[@"分",@"时",@"天",@"周",];
        //        _stockTopBarTitleArray = @[@"分时",@"日K",@"周K",@"月K"];
    }
    return _stockTopBarTitleArray;
}

- (NSString *)getToday {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (void)dealloc {
    NSLog(@"DEALLOC");
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end


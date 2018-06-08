//
//  SJLaunchPageView.m
//  ShouJinLiCai
//
//  Created by 宋任强 on 2018/1/17.
//

#import "SJLaunchPageView.h"
//#import "SJBannerServerTool.h"
#import <SDWebImage/UIImageView+WebCache.h>


#define SJ_NewfeatureImageCount 3

@interface SJLaunchPageView()<UIScrollViewDelegate>
// 图片
@property (strong, nonatomic) UIImageView *launchImageView;
// 倒计时按钮
@property (strong, nonatomic) UIButton *skipButton;
// 图片数据模型
//@property (strong, nonatomic)BannerImageModel *model;
// 计时器
@property (strong, nonatomic)NSTimer *countDownTimer;


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign)BOOL isNewfeature;
@end


@implementation SJLaunchPageView

// 显示视图
+ (void)showLaunchPageView{
    SJLaunchPageView *launchView = [[SJLaunchPageView alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    launchView.frame = window.bounds;
    [window addSubview:launchView];
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
//        [self requestData];
        // 取出沙盒中存储的上次使用软件的版本号
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *lastVersion = [defaults stringForKey:@"CFBundleShortVersionString"];
        // 获得当前软件的版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        // 如果跟沙盒中存储的版本一致就跳过新特性
        if ([currentVersion isEqualToString:lastVersion]) {
            self.isNewfeature = NO;
        } else {
            // 新版本，进入导航页界面
            self.isNewfeature = YES;
            [self setupScrollView];
        }
        [defaults setObject:currentVersion forKey:@"CFBundleShortVersionString"];
    }
    return self;
}

#pragma mark - 开屏广告页
// 创建子视图
- (void)creatUI{
    // 创建imageView
    self.launchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.launchImageView setImage:[UIImage imageNamed:@"lanunch"]];
    [self addSubview:self.launchImageView];
    
    // 创建倒计时按钮
//    self.skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.skipButton.frame = CGRectMake(SCREEN_WIDTH- 100, 44, 90, 30);
//    [self.skipButton setTitle:@"跳过 3s" forState:UIControlStateNormal];
//    [self.skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.skipButton addTarget:self action:@selector(skipButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.skipButton.layer.cornerRadius = 4.0;
//    self.skipButton.clipsToBounds = YES;
//    self.skipButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//    [self addSubview:self.skipButton];

    __block NSInteger countNumber = 1;
    __weak typeof(self) weakSelf = self;
    if (@available(iOS 10.0, *)) {
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (countNumber < 0) {
                [weakSelf.countDownTimer invalidate];
                weakSelf.countDownTimer = nil;
                [weakSelf dismissAnimation];
            }else{
//                NSString *title = [NSString stringWithFormat:@"跳过 %lds",(long)countNumber];
//                [self.skipButton setTitle:title forState:UIControlStateNormal];
                countNumber -= 1;
            }
        }];
    } else {
        // Fallback on earlier versions
    }
    [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
}

///**
// 请求启动图
// */
//- (void)requestData{
//    NSString *params = @"sjfinance_startup_3x";
//    [SJBannerServerTool getActivityWithImageKey:params successBlock:^(NSArray<BannerImageModel *> *responseData) {
//        if (responseData.count) {
//            self.model = responseData.firstObject;
//            [self.launchImageView sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl] placeholderImage:[UIImage imageNamed:@"App启动页"]];
//        }
//    } failBlock:^(NSError *err) {
//    }];
//}


/**
 跳过按钮点击
 */
- (void)skipButtonClick:(UIButton *)sender {
    [self dismissAnimation];
}

/**
 消息动画
 */
- (void)dismissAnimation{

    //消失动画
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //缩放修改处
        if (self.isNewfeature) {
            self.launchImageView.alpha = 0.1;
        }else{
            self.alpha = 0.1;
        }
    } completion:^(BOOL finished) {
        if (self.isNewfeature) {
            [self.launchImageView removeFromSuperview];
            [self.skipButton removeFromSuperview];
            self.isNewfeature = NO;
        }else{
            [self removeFromSuperview];
        }
    }];
}

- (void)dealloc{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
}

#pragma mark - 新特性


/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    scrollView.delegate = self;
    [self insertSubview:scrollView belowSubview:self.launchImageView];
    
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
    startButton.frame = CGRectMake(SCREEN_WIDTH-60, 30, 40, 20);
    // 3.设置文字
    [startButton setTitle:@"跳过" forState:UIControlStateNormal];
    // 4. 设置样式
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];

    
    startButton.layer.cornerRadius = 5.0f;
    // 5.添加点击事件
    [startButton addTarget:self action:@selector(dismissAnimation) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
}


/**
 *  只要UIScrollView滚动了,就会调用
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    // 2.求出页码
    if (offsetX>_scrollView.width*2) {
        [self dismissAnimation];
    }
}

@end

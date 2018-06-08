//
//  SJLaunchPageView.m
//  ShouJinLiCai
//
//  Created by 宋任强 on 2018/1/17.
//

#import "SJLaunchPageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SSCreatePurseViewController.h"
#import "SSAddPurseViewController.h"

#define SJ_NewfeatureImageCount 3

@interface SJLaunchPageView()<UIScrollViewDelegate>
// 图片
@property (strong, nonatomic) UIImageView *launchImageView;
// 底部按钮 创建钱包+导入钱包
@property (strong, nonatomic) UIButton *CreateWalletBtn;
@property (strong, nonatomic) UIButton *AddWalletBtn;
// 倒计时按钮
@property (strong, nonatomic) UIButton *skipButton;
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
    }
    return self;
}

#pragma mark - 开屏广告页
// 创建子视图
- (void)creatUI{
    // 记录不是第一次启动
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // 创建imageView
    self.launchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.launchImageView setImage:[UIImage imageNamed:@"lanunch"]];
      [self addSubview:self.launchImageView];
    
    // 创建底部按钮 - 6.8
    CGFloat BtnH = 50;
    CGFloat MarginX = 15;
    CGFloat MarginY = 10;
    // 导入钱包
    _AddWalletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _AddWalletBtn.frame = CGRectMake(MarginX, SCREEN_HEIGHT - MarginY-50, SCREEN_WIDTH-MarginX*2, BtnH);
    [_AddWalletBtn setTitle:@"导入钱包" forState:UIControlStateNormal];
    [_AddWalletBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_AddWalletBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
     [self addSubview:_AddWalletBtn];
    
    // 创建钱包
    _CreateWalletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _CreateWalletBtn.frame = CGRectMake(MarginX, SCREEN_HEIGHT - 125, SCREEN_WIDTH-MarginX*2, BtnH);
    _CreateWalletBtn.backgroundColor = [UIColor whiteColor];
    [_CreateWalletBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_CreateWalletBtn setTitle:@"创建钱包" forState:UIControlStateNormal];
    [_CreateWalletBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    [_AddWalletBtn addTarget:self action:@selector(addWallet) forControlEvents:UIControlEventTouchUpInside];
    [_CreateWalletBtn addTarget:self action:@selector(creatWallet) forControlEvents:UIControlEventTouchUpInside];
   
    [self addSubview:_CreateWalletBtn];
  
    // 创建倒计时按钮
    self.skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.skipButton.frame = CGRectMake(SCREEN_WIDTH- 100, 44, 90, 30);
    [self.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [self.skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.skipButton addTarget:self action:@selector(skipButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.skipButton.layer.cornerRadius = 4.0;
    self.skipButton.clipsToBounds = YES;
    self.skipButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self addSubview:self.skipButton];

}



#pragma mark - 底部按钮点击事件
-(void)addWallet{
    //导入钱包
    SSAddPurseViewController *vc = [[SSAddPurseViewController alloc] init];
    [self.viewController presentViewController:vc animated:YES completion:^{
        [self dismissAnimation];
    }];
    
}
-(void)creatWallet{
    // 创建钱包
    SSCreatePurseViewController *vc = [[SSCreatePurseViewController alloc] init];
    [self.viewController presentViewController:vc animated:YES completion:^{
        [self dismissAnimation];
    }];
}
/**
 跳过按钮点击
 */
- (void)skipButtonClick:(UIButton *)sender {
    [self dismissAnimation];
}

/**
 消失动画
 */
- (void)dismissAnimation{

//    //消失动画
//    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        //缩放修改处
////            self.launchImageView.alpha = 0.1;
//            self.alpha = 0.1;
//
//    } completion:^(BOOL finished) {
////            [self.launchImageView removeFromSuperview];
////            [self.skipButton removeFromSuperview];
//            [self removeFromSuperview];
//
//    }];
    [self removeFromSuperview];
}




@end

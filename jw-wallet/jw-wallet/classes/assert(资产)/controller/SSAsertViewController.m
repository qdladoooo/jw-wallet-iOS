//
//  SSAsertViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/26.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAsertViewController.h"

@interface SSAsertViewController ()

@end

@implementation SSAsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资产";
    self.view.backgroundColor = WHITCOLOR;
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 100, 30)];
    [text setText:@"资产"];
    [text setFont:[UIFont systemFontOfSize:30]];
    text.center = self.view.center;
    [text setTextColor:[UIColor blueColor]];
    [self.view addSubview:text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

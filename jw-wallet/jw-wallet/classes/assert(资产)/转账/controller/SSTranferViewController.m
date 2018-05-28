//
//  SSTranferViewController.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/5/28.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSTranferViewController.h"

@interface SSTranferViewController ()
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *transMoney;
@property (weak, nonatomic) IBOutlet UITextField *remark;
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation SSTranferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转账";
    [self setTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTextField{
//    在uitextfield 中文字最左边距离左侧边框的距离
    self.address.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 51)];
    self.transMoney.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 51)];
    self.remark.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 51)];
    
    self.address.leftViewMode=UITextFieldViewModeAlways;
    self.transMoney.leftViewMode=UITextFieldViewModeAlways;
    self.remark.leftViewMode=UITextFieldViewModeAlways;
    
}

- (IBAction)sliderChangeValue:(id)sender {
    self.value.text = [NSString stringWithFormat:@"%f",self.slider.value];
}
#pragma mark - 矿工费用说明
- (IBAction)question:(id)sender {
}
#pragma mark - 确认
- (IBAction)sureBtn:(id)sender {
}

@end

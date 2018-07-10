//
//  GTButtonTagsView.m
//  GTDynamicLabels
//
//  Created by 赵国腾 on 15/6/25.
//  Copyright (c) 2015年 zhaoguoteng. All rights reserved.
//

#import "GTButtonTagsView.h"

const CGFloat intervalWide = 10.0f;     // label间隔宽度

@interface GTButtonTagsView ()

@property (nonatomic, assign) CGRect currentLabelFrame;
@property (nonatomic, strong) UIButton *tagBtn;
//@property (nonatomic, copy) NSArray *MyDataArr;
@property (nonatomic, strong) NSIndexPath *path;
@end

@implementation GTButtonTagsView


-(void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    

//    // 布局label
//    for (NSInteger i = 0; i < dataArr.count; i++) {
//        
//        NSString *str = dataArr[i];
//        
//        CGFloat x = self.currentLabelFrame.origin.x + self.currentLabelFrame.size.width;
//        
//        CGFloat y = self.currentLabelFrame.origin.y;
//        
//        if (i != 0) {
//            x += intervalWide;
//        }else {
//            y += intervalWide;
//        }
//        
//        CGSize size = [self labelSizeFromString:str];
//        
//        // 判断label是否到视图边界
//        CGFloat minX = x;
//        CGFloat maxX = x + size.width;
//        
//        size.height = 30.0f;
//        
//        if (maxX > CGRectGetWidth(self.frame)) {
//            
//            x -= minX;
//            y = y + size.height + intervalWide;
//        }
//        
//        // 计算label的frame
//        CGRect rect = CGRectMake(x, y, size.width, size.height);
//        
//        self.currentLabelFrame = rect;
//        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = rect;
//        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
//        [button.titleLabel sizeToFit];
//        [button setTitle:str forState:UIControlStateNormal];
//        
//        //        [button setBackgroundColor:[UIColor lightGrayColor]];
//        
//        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
//       
//        button.tag = i;
//        
//        [self addSubview:button];
//        
//    }
    
}


- (void)awakeFromNib {
    
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnClick:) name:@"changeTagStatus" object:nil];
   
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
//    for (UIButton *btn in self.subviews) {
//        if ([btn isKindOfClass:[UIButton class]]) {
//            [btn removeFromSuperview];
//        }
//    }
    self.currentLabelFrame = CGRectZero;
    // 布局label
    for (NSInteger i = 0; i < _dataArr.count; i++) {
        
        NSString *str = _dataArr[i];
        
        CGFloat x = self.currentLabelFrame.origin.x + self.currentLabelFrame.size.width;
        
        CGFloat y = self.currentLabelFrame.origin.y;
        
        if (i != 0) {
            x += intervalWide;
        }else {
            y += intervalWide;
        }
        
        CGSize size = [self labelSizeFromString:str];
        
        // 判断label是否到视图边界
        CGFloat minX = x;
        CGFloat maxX = x + size.width;
        
        size.height = 30.0f;
        
        if (maxX > CGRectGetWidth(self.frame)) {
            
            x -= minX;
            y = y + size.height + intervalWide;
        }
        
        // 计算label的frame
        CGRect rect = CGRectMake(x, y, size.width, size.height);
        
        self.currentLabelFrame = rect;
        
        _tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tagBtn.frame = rect;
        [_tagBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _tagBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_tagBtn.titleLabel sizeToFit];
        [_tagBtn setTitle:str forState:UIControlStateNormal];
        
        [_tagBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
        _tagBtn.tag = i;

        [self addSubview:_tagBtn];
        
    }

    
}



// 根据文本计算label宽度
- (CGSize)labelSizeFromString:(NSString *)str {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20.0f]};
    return [str sizeWithAttributes:attributes];
}

// 标签点击事件
- (void)buttonAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(GTButtonTagsView:selectIndex:selectText:)]) {
        [self.delegate GTButtonTagsView:self selectIndex:sender.tag selectText:sender.titleLabel.text];
       [sender setBackgroundColor:BACKGROUNDCOLOR];
        sender.selected = YES;
        if (sender.selected) {
            sender.enabled = NO;
        }else{
            sender.enabled = YES;
        }

        
    }
}
// collection点击
-(void)btnClick:(NSNotification *)notif{
    
    NSString *title = [notif.userInfo objectForKey:@"title"];
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]] && [title isEqualToString:btn.titleLabel.text]) {
            btn.enabled = YES;
            [btn setSelected:NO];
            [btn setBackgroundColor:WHITCOLOR];
        }
    }

}
@end

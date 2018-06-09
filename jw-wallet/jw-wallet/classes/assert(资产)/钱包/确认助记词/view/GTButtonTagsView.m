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
@property (nonatomic, copy) NSArray *MyDataArr;
@end

@implementation GTButtonTagsView


-(void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    _MyDataArr = _dataArr;
}


- (void)awakeFromNib {
    
    [super awakeFromNib];
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"labels.plist" ofType:nil];
//    self.dataArr = [NSArray arrayWithContentsOfFile:plistPath];
    _MyDataArr = @[@"hello",@"word",@"witch",@"unblivivieble",@"touchuupinside",@"unblivivieble",@"unblivivieble",@"unblivivieble",@"unblivivieble",@"unblivivieble",@"unblivivieble",@"unblivivieble",];

    self.currentLabelFrame = CGRectZero;
    
    // 布局label
    for (NSInteger i = 0; i < self.MyDataArr.count; i++) {
        
        NSString *str = self.MyDataArr[i];
        
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
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = rect;
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [button setTitle:str forState:UIControlStateNormal];
        
//        [button setBackgroundColor:[UIColor lightGrayColor]];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        
        [self addSubview:button];
        
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    

    
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
    }
}

@end

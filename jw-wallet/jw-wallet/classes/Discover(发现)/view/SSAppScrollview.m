//
//  SSAppScrollview.m
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/3.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import "SSAppScrollview.h"
@interface SSAppScrollview()
@property (nonatomic, strong ) UIScrollView *scrollview;
@end
@implementation SSAppScrollview

// 1.重写initWithFrame:方法，创建子控件并添加到自己上面
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //    图片的宽
        CGFloat imageW = self.scrollview.frame.size.width;
        //    CGFloat imageW = 300;
        //    图片高
        CGFloat imageH = self.scrollview.frame.size.height;
        //    图片的Y
        CGFloat imageY = 0;
        CGFloat labelW = imageW;
        CGFloat labelH = 12;
        CGFloat labelY = CGRectGetMaxY(self.scrollview.frame) - 12*2;
        
        //    图片中数
        NSInteger totalCount = 5;
        //   1.添加5张图片
        for (int i = 0; i < totalCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            UILabel *label = [[UILabel alloc] init];
            //        图片X
            CGFloat imageX = i * imageW;
            CGFloat labelX = imageX;
            //        设置frame
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            label.frame = CGRectMake(labelX, labelY, labelW, labelH);
            //        设置图片
            NSString *name = [NSString stringWithFormat:@"img_0%d", i + 1];
            imageView.image = [UIImage imageNamed:name];
            label.text = [NSString stringWithFormat:@"应用_0%d", i + 1];
            //        隐藏指示条
            self.scrollview.showsHorizontalScrollIndicator = NO;
            
            [imageView addSubview:label];
            [self.scrollview addSubview:imageView];
            
            //    2.设置scrollview的滚动范围
            CGFloat contentW = totalCount *imageW;
            //不允许在垂直方向上进行滚动
            self.scrollview.contentSize = CGSizeMake(contentW, 0);
            
        }
    }
        return self;
    }

// 重写layoutSubviews，给自己内部子控件设置frame

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/

@end

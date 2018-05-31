//
//  SJNavigationController.h
//  ShouJinLiCai
//
//  Created by huangwei on 2017/10/29.
//

#import "SJNavigationBar.h"

#define SCREENWIDTH ([UIScreen mainScreen].bounds.size.width)

@interface SJNavigationBar ()
@end

@implementation SJNavigationBar


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;

    }
    return self;
}

- (void)updateConstraints{
    [super updateConstraints];
    NSArray *constrains = self.constraints;
    for(NSLayoutConstraint *constraintin in constrains){
        if(constraintin.firstAttribute == NSLayoutAttributeHeight){
            if (SCREEN_HEIGHT == 812) {
                constraintin.constant = 88;
            }else{
                constraintin.constant = 64;
            }
        }
    }
}



@end

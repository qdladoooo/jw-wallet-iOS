//
//  UIBarButtonItem+Category.h
//  SimpleAppBasicDemo
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Category)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)imageName highImage:(NSString *)highImageName;

@end

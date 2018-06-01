//
//  UIImage+Image.h

//

#import <UIKit/UIKit.h>

@interface UIImage (Image)


// 快速的返回一个最原始的图片
+ (instancetype)imageWithOriRenderingImage:(NSString *)imageName;


// 快速拉伸图片
+ (instancetype)imageWithStretchableImageName:(NSString *)imageName;
+(instancetype)grayImage:(UIImage *)sourceImage;
@end

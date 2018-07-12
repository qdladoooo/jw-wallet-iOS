//
//  DefineTheme.h

// 定义控件大小、字体大小、各类颜色

#ifndef DefineTheme_h
#define DefineTheme_h

//RGB转UIColor（不带alpha值）
#define UIColorFromRGB(rgbValue) [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB转UIColor（带alpha值）
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//颜色
#define TITLE_COLOR [UIColor blackColor]//标题颜色
#define TEXT_COLOR [UIColor grayColor]//正文颜色
#define TIPTEXT_COLOR UIColorFromRGB(0x888888)//提示语文本颜色
#define MAIN_GROUNDCOLOR UIColorFromRGB(0x000A2A)//主题景色
#define BACKGROUNDCOLOR UIColorFromRGB(0xF2F6FF)//背景颜色
#define FONT_DARKGRAYCOLOR UIColorFromRGB(0x2D5069) // 深灰主题字体
#define FONT_LIGHTGRAYCOLOR UIColorFromRGB(0xCCCCCC) // 浅色灰主题字体
#define BORDER_COLOR UIColorFromRGB(0xE6E6E6) // 边框
#define Bluecolor rgba(15, 129, 255, 1) // 蓝色
//字体大小
#define TITLEFONT [UIFont systemFontOfSize:18]
#define TEXTFONT [UIFont systemFontOfSize:16]
#define TIPTEXTFONT [UIFont systemFontOfSize:12]

//app中统一的一些size定义
#define Cell_Height 50
#define LeftOrigin 20 //控件左边距
#define Button_Height 45
#define Button_Width SCREEN_WIDTH - LeftOrigin * 2
#define ButtonLayerCornerRadius 2 //按钮圆角
#define LineColor UIColorFromRGB(0xCCCCCC) //线条颜色
#define LineWidth 0.5f //线条粗度
#define WHITCOLOR [UIColor whiteColor]
/**根据6为标准适配*/
#define ADAPTATIONIPHONE(Height) [CommonMethods adaptationIphone6Height:Height]


#endif /* DefineTheme_h */

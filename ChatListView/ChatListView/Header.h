//
//  Header.h
//  XMC
//
//  Created by sigboat on 15/4/15.
//  Copyright (c) 2015年 com.sigboat. All rights reserved.
//

#ifndef XMC_Header_h
#define XMC_Header_h

/// DEBUG模式
#ifdef DEBUG
#define Debug(format, ...)  NSLog(format, ## __VA_ARGS__)
#else
#define Debug(format, ...)
#endif



/// 屏幕宽
#define SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width

/// 屏幕高
#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height

/// 是否是ios7.0以上设备
#define IS_IOS7          ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?YES:NO)

/// 是否是ios8.0以上设备
#define IS_IOS8          [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

/// 4s 或4
#define iphone4x_3_5     ([UIScreen mainScreen].bounds.size.height==480.0f)

/// 5s 或5
#define iphone5x_4_0     ([UIScreen mainScreen].bounds.size.height==568.0f)

///  iphone6
#define iphone6_4_7      ([UIScreen mainScreen].bounds.size.height==667.0f)

///  iphone6Plus
#define iphone6Plus_5_5  ([UIScreen mainScreen].bounds.size.height==736.0f)

/// 判断是否是iPhone4或4s
#define IS_IPHONE4S       ([[UIScreen mainScreen] bounds].size.height<568?YES:NO)

/// 导航栏距离顶部高度
#define NAVGATIONBAR_HEIGHT  (IS_IOS7?64:44)

/// 导航栏高度
#define NAVBAR_HEIGHT       44

///  tabbar高度
#define TABLEBAR_HEIGHT     49

///  tabbar加navbar高度
#define NAV_TAB_HEIGHT      ( NAVGATIONBAR_HEIGHT+TABLEBAR_HEIGHT)

///  没有导航栏屏幕高度
#define SCREEN_NO_NAVBAR    (SCREEN_HEIGHT-NAVGATIONBAR_HEIGHT)

/// 没有导航栏和tabbar高度
#define SCREEN_NO_NAVTABBAR  (SCREEN_HEIGHT-NAVGATIONBAR_HEIGHT-TABLEBAR_HEIGHT)

///  圆角半径
#define CORNER_RADIUS      6

///  分割线高
#define LINE_HEIGHT        0.5

///  rgb颜色
#define GET_COLOR(r,g,b)        [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

///  宽度比率
#define WIDTH_RATE(x)     (((x)/320.0)*SCREEN_WIDTH)

///  高度比率
#define HEIGHT_RATE(x)    (SCREEN_HEIGHT<568.0f?(x):(((x)/568.0)*SCREEN_HEIGHT))

///  测试图片
#define IMAGE_TEST_URL    @"http://api.jtuntech.com/event/2015/Q2/gymax//Uploads/2015-06/1455052625.jpg"

/// 19号字体
#define FONT_19           [UIFont boldSystemFontOfSize:19]

/// 15号字体

#define FONT_15           [UIFont systemFontOfSize:15]

/// 13号字体

#define FONT_13           [UIFont systemFontOfSize:13]

/// 通用间距

#define Padding           10.0f

///  灰色字体颜色 102
#define COLOR_GRAY        GET_COLOR(102, 102, 102)

///  灰色字体颜色 153
#define COLOR_BRIGNT_GRAY GET_COLOR(153, 153, 153)

///  灰色线颜色
#define COLOR_GRAY_LINE   GET_COLOR(242, 242, 242)

///  浅蓝色
#define DEPART_COLOR      GET_COLOR(33, 175, 234)

///  浅黄色
#define YELLOW_COLOR      GET_COLOR(250, 172, 10)

///  走跑骑行分割线颜色
#define TRIM_COLOR        GET_COLOR(1, 124, 175)

///   高德地图KEY
///  04828510d2c02f8a6f59a6f656889fcd  f2b59bec582a2a7bb1f38076251d4ad8
#define GAODE_MAP_KEY_APPSTORE @"04828510d2c02f8a6f59a6f656889fcd"

/// share SDK 分享key

#define SHARE_SDK_KEY           @"69fea3d3bff6"

/// 新浪微博

#define SINA_WEIBO_APP_KEY      @"535845448"

#define SINA_WEIBO_APP_SECRET   @"2498311719294a03b50096647aecdd00"

#define SINA_REDIRECT_URL       @"http://xiangmei123.com"

/// 微信分享

#define WECHAT_APPID            @"wxf5a15f02b2ea12c8"

#define WECHAT_APP_SECRET       @"0dd69e54156e366cc80173619b3537d5"

/// QQ分享 

#define QQWHITH_APPID           @"1104341382"

#define QQWHITH_APP_SECRET      @"U3pxDkbKnCMLxxMv"

#endif

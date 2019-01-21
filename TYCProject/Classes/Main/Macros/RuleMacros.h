//
//  RuleMacros.h
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#ifndef RuleMacros_h
#define RuleMacros_h

/// 屏幕
/////////////////////////////////////////////////////////////////////////////////
// 获取当前设备屏幕的宽和高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
// 可操作区域高度
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height - kNavigationBarHeight - kStatusBarHeigth)
//屏幕比例
#define KWidth_ScaleW [UIScreen mainScreen].bounds.size.width/375.0f
#define KWidth_ScaleH [UIScreen mainScreen].bounds.size.height/667.0f

#define KFloat(a) a * KWidth_ScaleW
//刷新框架的适配iOS11,第一个参数是当下的控制器适配iOS11 一下的，第二个参数表示scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

//高度系数 812.0 是iPhoneX的高度尺寸，667.0表示是iPhone 8 的高度，如果你觉的它会变化，那我也很无奈
#define heightCoefficient (kScreenHeight == 812.0 ? 667.0/667.0 : kWJScreenHeight/667.0)
//导航的高度为64，在哪个手机上面都是不变的,iPhone X没出来之前是对的，随便写64,iPhone X出来后，导航栏高度变为88
#define SafeAreaTopHeight (kScreenHeight == 812.0 ? 88 : 64)
//底部宏，底部角圆角的距离是34，设置底部的按钮按钮底部距离底部34
#define SafeAreaBottomHeight (kScreenHeight == 812.0 ? 34 : 0)
//状态栏高度，iPhone X的状态栏由原来的20变更为现在的44,来凸现齐刘海(kScreenHeight == 812.0 ? 44 : 20)
#define kStatusBarHeigth ([UIApplication sharedApplication].statusBarFrame.size.height)
//NavBar高度
#define kNavigationBarHeight ([[UINavigationController alloc]init].navigationBar.height)
//TabBar高度
#define TabBar_HEIGHT 49




/// 颜色
/////////////////////////////////////////////////////////////////////////////////
//#FFFFFF：纯白色，通用。
//#000000：纯黑色，通用。
//#FF0000：纯红色，通用。详情页下载链接、访问网络链接。
//#00FF00：纯绿色，通用。
//#0000FF：纯蓝色，通用。详情页下载链接、访问网络链接点击状态颜色。
// 随机色
#define RandomColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define UIColorFromRGB(A,B,C) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]
#define UIColorFromRGBA(r, g, b , a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
// 使用十六进制设置颜色
#define RGB_COLOR_WITH_0x(__color0x16__)  [UIColor colorWithRed:((float)((0xFF0000&__color0x16__)>>16)/255.0) green:((float)((0xFF00&__color0x16__)>>8)/255.0) blue:((float)(0xFF&__color0x16__)/255.0) alpha:1.0]
#define RGB_COLOR_WITH_0x_alpha(__color0x16__,__alpha)  [UIColor colorWithRed:((float)((0xFF0000&__color0x16__)>>16)/255.0) green:((float)((0xFF00&__color0x16__)>>8)/255.0) blue:((float)(0xFF&__color0x16__)/255.0) alpha:__alpha]

//单元格间隔线颜色
#define kCellLineViewColor 0xeeeeee
//单元格间隙颜色
#define kSeparaterLineColor 0xeaebed
//表视图背景色
#define TableViewBJ_Color  [UIColor colorWithHexString:@"f5f5f5"]
//视图背景色
#define ViewBJ_Color  [UIColor colorWithHexString:@"f5f5f5"]
#define kRedColor 0xFF0000 //#FF3B30：所有标题栏字符、详情页拼音、拼音搜索结果页面当前搜索的拼音背景、搜索首页搜索栏背景、欢迎页Loading提示字符、欢迎页Loading失败提示字符
#define kWhiteColor 0xffffff
#define kBlackTextColor 0x2a344a //#333333：按拼音查展开中字符颜、按部首查展开中字符颜色、拼音搜索结果展开中字符颜色、搜索结果汉字中字符颜色、提示对话框字符颜色、汉字详情中字符颜色、搜索页面历史记录字符颜色、拼音搜索结果标题字符颜色、部首搜索结果标题字符颜色、搜索页面输入框字符颜色、没有搜索历史提示字符颜色。
#define kBlackText888Color 0x888888
#define kNavBgColor kWhiteColor//0xf8f8f8
#define kShadowColor 0xe5e7ed




/// 字体
/////////////////////////////////////////////////////////////////////////////////
//正常
#define kSystemFont(__arg__)[UIFont systemFontOfSize:__arg__]
//粗体
#define kSystemBordFont(__arg__)[UIFont boldSystemFontOfSize:__arg__]
//正常适配
#define kSystemFitFont(__arg__) kSystemFont(isiPhone4||isiPhone5?__arg__-1:(isiPhoneX?__arg__+1:__arg__))
//粗体适配
#define kSystemFitBordFont(__arg__) kSystemBordFont(isiPhone4||isiPhone5?__arg__-1:__arg__)
#define IconFont  @"宋体"



/// 测试专用输出
/////////////////////////////////////////////////////////////////////////////////
#ifdef DEBUG
#define DEBUG_LOG(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)//NSLog(format, ## __VA_ARGS__)//[iConsole info:format, ## __VA_ARGS__]//NSLog(format, ## __VA_ARGS__)
#else
#define DEBUG_LOG(format, ...) //NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)// [iConsole info:format, ## __VA_ARGS__]
#endif




/// 系统
/////////////////////////////////////////////////////////////////////////////////
#define isIOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
#define isIOS7 ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0)
#define isIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define isIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define isIOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define isIOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)




/// 版本号
/////////////////////////////////////////////////////////////////////////////////
//获取App的版本号 CFBundleShortVersionString  kCFBundleVersionKey build版本号
#define GET_APP_VERSION  ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
//获取App build版本号
#define GET_APP_BUILD_VERSION  ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
//获取App的版本号去掉点
#define GET_APP_VERSION_WITHOUT_DOT  ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""])




/// 获取当前文件名字
/////////////////////////////////////////////////////////////////////////////////
#define FILE_NAME [[[[[NSString stringWithFormat:@"%s",__FILE__] componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."] firstObject]




/// 路径
/////////////////////////////////////////////////////////////////////////////////
//Doucument 的路径
#define NSDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
//Cache 的路径
#define NSCachesPath   [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]




//缓存
/////////////////////////////////////////////////////////////////////////////////
#define KUserDefault [NSUserDefaults standardUserDefaults]




#define VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#endif /* RuleMacros_h */

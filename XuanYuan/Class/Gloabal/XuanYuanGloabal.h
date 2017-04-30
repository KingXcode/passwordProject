//
//  XuanYuanGloabal.h
//  XuanYuan
//
//  Created by King on 2017/4/27.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#ifndef XuanYuanGloabal_h
#define XuanYuanGloabal_h



//偏好设置
//是否启用密码  @YES--启用   @NO-关闭
#define kStartPasswordUserDefaults @"kStartPasswordUserDefaults"
//启用touchID @YES--启用   @NO-关闭
#define kStartTouchIDUserDefaults @"kStartTouchIDUserDefaults"


//通知
//刷新首页通知
#define kReloadClassification_Noti @"reloadClassification"
//刷新收藏通知
#define kReloadCollect_Noti @"reloadClassification"




//主基调
#define MainRGB RGB(0, 191, 255)
#define MainTextColor [UIColor darkGrayColor]
#define MainTextWhiteColor [UIColor whiteColor]

#define MainCollectColor [UIColor orangeColor]
#define MainTableViewBackgroundColor  [UIColor groupTableViewBackgroundColor]

//主控制器
#define MainKeyWindow [UIApplication sharedApplication].keyWindow
#define MainRootViewController [UIApplication sharedApplication].keyWindow.rootViewController
#define MainRootTabbarController (HTTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController

#define MainAppDelegate  (AppDelegate *)[UIApplication sharedApplication].delegate

//实例化故事板的控制器
#define instantiateStoryboardControllerWithIdentifier(identifier)    [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:identifier];


//屏幕宽度
#define IPHONE_WIDTH   [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define IPHONE_HEIGHT  [UIScreen mainScreen].bounds.size.height
//通知中心
#define NSNOTI_CENTER   [NSNotificationCenter defaultCenter]


//由角度获取弧度
#define ht_number_degreesToRadian(x) (M_PI * (x) / 180.0)
//由弧度获取角度
#define ht_number_radianToDegrees(radian) (radian*180.0)/(M_PI)

// 直接rgb转换
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1)

#define RGBHex(rgbValue) \
                        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                        green:((float)((rgbValue & 0xFF00) >> 8))/255.0    \
                                         blue:((float)(rgbValue & 0xFF))/255.0             \
                                        alpha:1.0]




//判断系统版本
//ios 10.0+
#define ht_IOS10_OR_LATER		( [[UIDevice currentDevice] systemVersion].integerValue>=10)
//ios 9.0+
#define ht_IOS9_OR_LATER		( [[UIDevice currentDevice] systemVersion].integerValue>=9)
//ios 8.0+
#define ht_IOS8_OR_LATER		( [[UIDevice currentDevice] systemVersion].integerValue>=8)




#define ht_number_NavigationBarHeight 44
#define ht_number_StatusBarHeight 20
#define ht_number_TopBarHeight 64
#define ht_number_ToolBarHeight 44
#define ht_number_TabBarHeight 49

#define ht_number_iPhone4_W 320
#define ht_number_iPhone4_H 480
#define ht_number_iPhone5_W 320
#define ht_number_iPhone5_H 568
#define ht_number_iPhone6_W 375
#define ht_number_iPhone6_H 667
#define ht_number_iPhone6P_W 414
#define ht_number_iPhone6P_H 736
#define ht_number_DefaultFontSize 17







//单例化一个类
#define Single_For_class(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}


#endif /* XuanYuanGloabal_h */
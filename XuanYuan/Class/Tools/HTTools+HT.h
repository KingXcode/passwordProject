//
//  HTTools+HT.h
//  XuanYuan
//
//  Created by King on 2017/4/25.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools.h"

@interface HTTools (HT)

/**
 指纹识别
 */
+(void)enableTouchIDCheck:(void(^)(BOOL success, NSError *error))reply;
+(BOOL)canOpenTouchID;
/**
 震动
 */
+(void)vibrate;
/**
 分词
 */
+ (NSArray *)stringTokenizerWithWord:(NSString *)word;

/**
 分词 不带标点
 */
+ (NSArray *)notDotStringTokenizerWithWord:(NSString *)word;
/**
 截图
 */
+(UIImage *) captureScreen;
+(UIImage *) convertViewToImage:(UIView*)v;
/**
 截图并保存相册
 */
+(void)saveScreenshotToPhotosAlbum:(UIView *)view;
/**
 高斯模糊
 */
+(UIVisualEffectView *)gaussianBlurWithFrame:(CGRect)frame;
+(UIVisualEffectView *)gaussianBlurWithFrame:(CGRect)frame andStyle:(UIBlurEffectStyle)style;

/**
 高斯模糊的主界面截屏
 */
+(UIImageView *)gaussianBlurWithMainRootView;

/**
 尺寸计算
 */
+(CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width;
+(CGSize)sizeOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width;


/*
 动画类型
 fade 淡出效果
 moveIn 新视图移动到旧视图
 push   新视图推出旧视图
 reveal 移开旧视图
 cube   立方体翻转效果
 oglFlip    翻转效果
 suckEffect 收缩效果
 rippleEffect   水滴波纹效果
 pageCurl   向下翻页
 pageUnCurl 向上翻页
 */

/**
 方向
 `fromLeft'
 `fromRight'
 `fromTop'
 `fromBottom'.
 */
+ (CATransition *)createTransitionAnimationWithType:(NSString *)type direction:(NSString *)direction time:(double)time;

/**
 从右边滑出来
 */
+(void)TransformView:(UIView *)view;

/**
 从小变大
 */
+(void)CATransform3DScaleView:(UIView *)view;


/**
 抖动
 */
+(void)shakeAnnimation:(UIView *)view completion:(void (^)(BOOL finished))completion;


/**
 获取到当前正在展示的VC
 */
+ (UIViewController *)getCurrentVC;


@end

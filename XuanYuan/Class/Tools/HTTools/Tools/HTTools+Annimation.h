//
//  HTTools+Annimation.h
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools.h"

extern NSString *const kFadeType;
extern NSString *const kMoveInType;
extern NSString *const kPushType;
extern NSString *const kRevealType;
extern NSString *const kCubeType;
extern NSString *const kOglFlipType;
extern NSString *const kSuckEffectType;
extern NSString *const kRippleEffectType;
extern NSString *const kPageCurlType;
extern NSString *const kPageUnCurlType;

extern NSString *const kFromLeftDirection;
extern NSString *const kFromRightDirection;
extern NSString *const kFromTopDirection;
extern NSString *const kFromBottomDirection;


@interface HTTools (Annimation)

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
 竖直缩放
 */
+(void)CATransform3DScaleVerticalView:(UIView *)view;
+(void)CATransform3DScaleVerticalView:(UIView *)view Duration:(NSTimeInterval)duration;


/**
 抖动
 */
+(void)shakeAnnimation:(UIView *)view completion:(void (^)(BOOL finished))completion;
@end

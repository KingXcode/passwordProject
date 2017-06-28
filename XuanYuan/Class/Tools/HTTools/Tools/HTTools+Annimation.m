//
//  HTTools+Annimation.m
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools+Annimation.h"

NSString *const kFadeType           = @"fade";
NSString *const kMoveInType         = @"moveIn";
NSString *const kPushType           = @"push";
NSString *const kRevealType         = @"reveal";
NSString *const kCubeType           = @"cube";
NSString *const kOglFlipType        = @"oglFlip";
NSString *const kSuckEffectType     = @"suckEffect";
NSString *const kRippleEffectType   = @"rippleEffect";
NSString *const kPageCurlType       = @"pageCurl";
NSString *const kPageUnCurlType     = @"pageUnCurl";


NSString *const kFromLeftDirection      = @"fromLeft";
NSString *const kFromRightDirection     = @"fromRight";
NSString *const kFromTopDirection       = @"fromTop";
NSString *const kFromBottomDirection    = @"fromBottom";

@implementation HTTools (Annimation)

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
+ (CATransition *)createTransitionAnimationWithType:(NSString *)type direction:(NSString *)direction time:(double)time
{
    //切换之前添加动画效果
    //创建CATransition动画对象
    CATransition *animation = [CATransition animation];
    //设置动画的类型:
    animation.type = type;
    //设置动画的方向
    animation.subtype = direction;
    //设置动画的持续时间
    animation.duration = time;
    //设置动画速率(可变的)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //动画添加到切换的过程中
    return animation;
}

+(void)TransformView:(UIView *)view
{
    CGFloat rotationAngleDegrees = 0;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    CGPoint offsetPositioning = CGPointMake(view.frame.size.width, 0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
    
    view.layer.transform = transform;
    view.layer.opacity = 0.8;
    
    [UIView animateWithDuration:0.4f animations:^{
        view.layer.transform = CATransform3DIdentity;
        view.layer.opacity = 1;
    }];
}

+(void)shakeAnnimation:(UIView *)view completion:(void (^)(BOOL finished))completion
{
    CATransform3D tran = view.layer.transform;
    [UIView animateWithDuration:0.025f animations:^{
        
        view.layer.transform = CATransform3DTranslate(tran, 5, 0.0, 0.0);
        
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.05f animations:^{
            
            view.layer.transform = CATransform3DTranslate(tran, -5, 0.0, 0.0);
            
        }completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.05f animations:^{
                
                view.layer.transform = CATransform3DTranslate(tran, 5, 0.0, 0.0);
                
            }completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.05f animations:^{
                    
                    view.layer.transform = CATransform3DTranslate(tran, -5, 0.0, 0.0);
                    
                }completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.05f animations:^{
                        
                        view.layer.transform = CATransform3DTranslate(tran, 5, 0.0, 0.0);
                        
                    }completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:0.025f animations:^{
                            
                            view.layer.transform = CATransform3DIdentity;
                            
                        } completion:^(BOOL finished) {
                            if (completion) {
                                completion(finished);
                            }
                        }];
                        
                    }];
                }];
                
            }];
            
        }];
        
    }];
    
}



+(void)CATransform3DScaleView:(UIView *)view
{
    [self CATransform3DScaleView:view Duration:0.4f];
}



+(void)CATransform3DScaleView:(UIView *)view Duration:(NSTimeInterval)duration
{
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(transform, 0, 0, 1);
    view.layer.transform = transform;
    
    [UIView animateWithDuration:duration animations:^{
        view.layer.transform = CATransform3DIdentity;
        view.layer.opacity = 1;
    }];
}



+(void)CATransform3DScaleVerticalView:(UIView *)view
{
    [self CATransform3DScaleVerticalView:view Duration:0.2f];
}

+(void)CATransform3DScaleVerticalView:(UIView *)view Duration:(NSTimeInterval)duration
{
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(transform, 1, 0, 1);
    view.layer.opacity = 0;
    view.layer.transform = transform;
    
    [UIView animateWithDuration:duration animations:^{
        view.layer.transform = CATransform3DIdentity;
        view.layer.opacity = 1;
    }];
}



@end

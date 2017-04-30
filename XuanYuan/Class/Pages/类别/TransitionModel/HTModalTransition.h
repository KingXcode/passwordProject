//
//  HTModalTransition.h
//  XuanYuan
//
//  Created by King on 2017/4/27.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HTModalTransitionType) {
    kHTModalTransitionPresent = 1 << 1,
    kHTModalTransitionDismiss = 1 << 2
};

@interface HTModalTransition : NSObject<UIViewControllerAnimatedTransitioning>


/*!
 *
 *  指定动画类型
 *
 *  @param type          动画类型
 *  @param duration      动画时长
 *  @param presentHeight 弹出呈现的高度
 *  @param scale         fromVC的绽放系数
 *
 */
+ (HTModalTransition *)transitionWithType:(HTModalTransitionType)type
                                  duration:(NSTimeInterval)duration
                             presentHeight:(CGFloat)presentHeight
                                     scale:(CGPoint)scale;


@end

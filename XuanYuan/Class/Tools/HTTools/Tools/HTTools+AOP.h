//
//  HTTools+AOP.h
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools.h"

@interface HTTools (AOP)

/*!
 *  替换两个方法
 *
 *   className
 *   originalSelector 原始方法
 *   swizzledSelector 替换的方法
 */
+ (void)aop_swizzlingClass:(NSString *)className
          OriginalSelector:(SEL)originalSelector
          swizzledSelector:(SEL)swizzledSelector;
@end

//
//  NSObject+HTAOP.h
//  pangu
//
//  Created by King on 2017/6/16.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HTAOP)
/*!
 *  替换两个方法
 *
 *   className
 *   originalSelector 原始方法
 *   swizzledSelector 替换的方法
 */
+ (void)aop_originalSelector:(SEL)originalSelector
            swizzledSelector:(SEL)swizzledSelector;
@end

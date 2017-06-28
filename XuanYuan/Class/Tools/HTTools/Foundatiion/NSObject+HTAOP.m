//
//  NSObject+HTAOP.m
//  pangu
//
//  Created by King on 2017/6/16.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "NSObject+HTAOP.h"
#import <objc/runtime.h>

@implementation NSObject (HTAOP)

/*!
 *  替换两个方法
 *
 *  @param originalSelector 原始方法
 *  @param swizzledSelector 替换的方法
 */
+ (void)aop_originalSelector:(SEL)originalSelector
            swizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod([self class], originalSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    
    BOOL didAddMethod = class_addMethod([self class],
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod([self class],
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end

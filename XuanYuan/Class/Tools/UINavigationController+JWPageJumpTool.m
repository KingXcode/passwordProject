//
//  UINavigationController+JWPageJumpTool.m
//  pangu
//
//  Created by 肖坚伟 on 2017/1/4.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UINavigationController+JWPageJumpTool.h"

@implementation UINavigationController (JWPageJumpTool)

/**
 返回到指定的页面
 
 @param vcClass 该页面的class
 */
-(void) popToAppiontViewController:(Class)vcClass
{
    if (![self containViewController:vcClass]) {
        return;
    }
    
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:vcClass]) {
            [self popToViewController:vc animated:YES];
            return;
        }
    }
}

/**
 返回到某个不存在的页面
 
 @param viewController 跳转页面class
 @param aClass 前一个页面class
 */
-(void) popToNoExistViewController:(UIViewController *)viewController behindOfViewController:(Class)aClass
{
    if (![self containViewController:aClass]) {
        return;
    }
    
    NSMutableArray *pageArray = [self.viewControllers mutableCopy];
    for (int i = 0; i < pageArray.count; i++)
    {
        id vc = pageArray[i];
        //找到要插入页面的前一个界面
        if ([vc isKindOfClass:aClass])
        {
            //插入界面栈
            [pageArray insertObject:viewController atIndex:i + 1];
            [self setViewControllers:pageArray animated:NO];
            [self popToViewController:viewController animated:YES];
            return;
        }
    }
}

/**
 返回到某个不存在的页面
 
 @param viewController 跳转页面class
 @param aClass 后一个页面class
 */
-(void) popToNoExistViewController:(UIViewController *)viewController inFrontOfTheViewController:(Class)aClass
{
    if (![self containViewController:aClass]) {
        return;
    }
    
    NSMutableArray *pageArray = [self.viewControllers mutableCopy];
    for (int i = 0; i < pageArray.count; i++)
    {
        id vc = pageArray[i];
        //找到要插入页面的后一个界面
        if ([vc isKindOfClass:aClass])
        {
            //插入界面栈
            [pageArray insertObject:viewController atIndex:i];
            [self setViewControllers:pageArray animated:NO];
            [self popToViewController:viewController animated:YES];
            return;
        }
    }
}

/**
 删除某一个页面
 
 @param vcClass 该页面class
 */
-(void) deleteAppiontViewController:(Class)vcClass
{
    if (![self containViewController:vcClass]) {
        return;
    }
    
    NSMutableArray *pageArray = [self.viewControllers mutableCopy];
    for (int i = 0; i < pageArray.count; i++)
    {
        id vc = pageArray[i];
        //找到要插入页面的后一个界面
        if ([vc isKindOfClass:vcClass])
        {
            //插入界面栈
            [pageArray removeObject:vc];
            [self setViewControllers:pageArray animated:NO];
            return;
        }
    }
}

- (BOOL) containViewController:(Class)aClass
{
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:aClass]) {
            return YES;
        }
    }
    NSLog(@"当前NavgationController中不存在 ----> %@ !!!",NSStringFromClass(aClass));
    return NO;
}

@end

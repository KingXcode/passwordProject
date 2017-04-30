//
//  UINavigationController+JWPageJumpTool.h
//  pangu
//
//  Created by 肖坚伟 on 2017/1/4.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (JWPageJumpTool)

/**
 返回到指定的页面

 @param vcClass 该页面的class
 */
-(void) popToAppiontViewController:(Class)vcClass;

/**
 返回到某个没有创建的页面

 @param viewController 跳转页面
 @param aClass 前一个页面class
 */
-(void) popToNoExistViewController:(UIViewController *)viewController behindOfViewController:(Class)aClass;

/**
 返回到某个没有创建的页面
 
 @param viewController 跳转页面
 @param aClass 后一个页面class
 */
-(void) popToNoExistViewController:(UIViewController *)viewController inFrontOfTheViewController:(Class)aClass;

/**
 删除已经存在的某一个页面

 @param vcClass 该页面class
 */
-(void) deleteAppiontViewController:(Class)vcClass;

@end

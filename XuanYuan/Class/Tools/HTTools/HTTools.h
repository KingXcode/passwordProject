//
//  HTTools.h
//  pangu
//
//  Created by niesiyang on 2017/2/27.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <Foundation/Foundation.h>





#pragma -mark-  这里是分割线--------------------

@interface HTTools : NSObject


/**
 生成随机数
 */
+(NSUInteger)ht_getRandomNumber:(NSUInteger)from to:(NSUInteger)to;
/**
 跳转对应的控制器
 */
+ (BOOL)ht_navigation:(UINavigationController *)navigation jumpToViewControllerForString:(NSString *)ClassVc;
/**
 获取到当前正在展示的VC
 */
+ (UIViewController *)getCurrentVC;


@end













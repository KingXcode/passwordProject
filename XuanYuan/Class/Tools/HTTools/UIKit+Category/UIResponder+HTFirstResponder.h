//
//  UIResponder+HTFirstResponder.h
//  pangu
//
//  Created by King on 2017/6/14.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (HTFirstResponder)
/**
 *  @brief  当前第一响应者
 *
 *  @return 当前第一响应者
 */
+ (id)ht_currentFirstResponder;
@end

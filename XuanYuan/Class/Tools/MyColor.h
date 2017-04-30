//
//  MyColor.h
//  zhubaoyi
//
//  Created by zby001 on 15/5/21.
//  Copyright (c) 2015年 zby001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyColor : NSObject

/**
 主题色
 
 @return 255.134.93
 */
+ (id)setOrangeColor;

/**
 tableViewCell分割线的颜色
 
 @return 235.235.235
 */
+ (id)setTableViewCellSeparatorColor;

/**
 背景的灰色
 
 @return 245.245.245
 */
+ (id)setGrayBgColor;

/**
 导航栏背景色
 
 @return 51.51.51
 */
+ (id)setNavBgColor;

/**
 深色字体颜色
 
 @return 34.34.34
 */
+ (id)setBlackTextColor;

/**
 浅色字体颜色
 
 @return 153.153.153
 */
+ (id)setLightTextColor;

@end

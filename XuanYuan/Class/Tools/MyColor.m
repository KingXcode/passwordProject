//
//  MyColor.m
//  zhubaoyi
//
//  Created by zby001 on 15/5/21.
//  Copyright (c) 2015年 zby001. All rights reserved.
//

#import "MyColor.h"
#import <UIKit/UIKit.h>

@implementation MyColor

+ (id)setOrangeColor
{
    UIColor *MyColor = RGB(255, 134, 93);
    return MyColor;
}

+ (id)setTableViewCellSeparatorColor
{
    UIColor *MyColor = RGB(235, 235, 235);
    return MyColor;
}

+ (id)setGrayBgColor
{
    UIColor *MyColor = RGBHex(0xEFEFF4);
    return MyColor;
}

+ (id)setNavBgColor
{
    UIColor *MyColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
    return MyColor;
}

+ (id)setBlackTextColor
{
    UIColor *MyColor = RGB(34, 34, 34);
    return MyColor;
}

+ (id)setLightTextColor
{
    UIColor *color = RGB(153, 153, 153);
    return color;
}

@end

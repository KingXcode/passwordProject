//
//  HTTools+Date.h
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools.h"

@interface HTTools (Date)
/**
 @param timeStr 时间戳
 @param dateFormat  the default value is (yyyy.MM.dd HH:mm:ss)
 @return 返回转换好的时间字符串
 */
+(NSString *)ht_DateWithLongTime:(NSString *)timeStr dateFormat:(NSString *)dateFormat;
/*
 时间戳转字符串
 */
+(NSString *)ht_DateWithLongTime:(NSString *)timeStr;
/**
 判断几分钟前
 */
+(NSString *)ht_DateCompareCurrentTime:(NSDate*) compareDate;
+(NSString *)ht_DateCompareCurrentTimes:(NSTimeInterval)timeInterval;

/*
 判断时间与当前时间的大小
 1: 未来
 -1:过去
 0:是当前
 */
+(int)ht_DateCompareDateTime:(NSString *)otherDateString;

/**
 任意进制转换十进制 index为0原字符串默认为十六进制
 @param str 数字字符串
 @param index 字符串原本是 几进制
 @return 转换后的十进制数
 */
+(NSNumber *)ht_DateStrToulWithStr:(NSString *)str base:(int)index;
@end

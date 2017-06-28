//
//  HTTools+Date.m
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools+Date.h"

@implementation HTTools (Date)

/**
 任意进制转换十进制 index为0原字符串默认为十六进制
 
 @param str 数字字符串
 @param index 字符串原本是 几进制
 @return 转换后的十进制数
 */
+(NSNumber *)ht_DateStrToulWithStr:(NSString *)str base:(int)index
{
    if (index<=1) {
        index = 16;
    }
    NSUInteger s =  strtoul([str UTF8String], 0, index);
    NSNumber *number = [NSNumber numberWithUnsignedInteger:s];
    return number;
}



/**
 
 @param timeStr 时间戳
 @param dateFormat the default value is (yyyy.MM.dd HH:mm:ss)
 @return 返回转换好的时间字符串
 */
+(NSString *)ht_DateWithLongTime:(NSString *)timeStr dateFormat:(NSString *)dateFormat{
    
    long long time = [timeStr longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if ([self ht_isBlankString:dateFormat]) {
        
        dateFormatter.dateFormat = @"yyyy.MM.dd HH:mm:ss";
        
    }else
    {
        dateFormatter.dateFormat = dateFormat;
    }
    
    return [dateFormatter stringFromDate:d];
}

+(int)ht_DateCompareDateTime:(NSString *)otherDateString
{
    long long time = [otherDateString longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000];
    NSDate *today = [NSDate date];
    NSComparisonResult result = [d compare:today];
    
    if (result == NSOrderedDescending) {
        return 1;
    }
    else if (result == NSOrderedAscending){
        return -1;
    }
    else
    {
        return 0;
    }
}



+(NSString *)ht_DateWithLongTime:(NSString *)timeStr{
    
    return [self ht_DateWithLongTime:timeStr dateFormat:nil];
}

+(NSString *) ht_DateCompareCurrentTimes:(NSTimeInterval)timeInterval
{
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

+(NSString *) ht_DateCompareCurrentTime:(NSDate*) compareDate  // 几分钟前
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    return [self ht_DateCompareCurrentTimes:timeInterval];
}


@end

//
//  NSDate+HTExtension.m
//  pangu
//
//  Created by King on 2017/6/15.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "NSDate+HTExtension.h"

@implementation NSDate (HTExtension)

- (NSUInteger)ht_day {
    return [NSDate ht_day:self];
}

- (NSUInteger)ht_month {
    return [NSDate ht_month:self];
}

- (NSUInteger)ht_year {
    return [NSDate ht_year:self];
}

- (NSUInteger)ht_hour {
    return [NSDate ht_hour:self];
}

- (NSUInteger)ht_minute {
    return [NSDate ht_minute:self];
}

- (NSUInteger)ht_second {
    return [NSDate ht_second:self];
}

+ (NSUInteger)ht_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)ht_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)ht_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)ht_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)ht_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)ht_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)ht_daysInYear {
    return [NSDate ht_daysInYear:self];
}

+ (NSUInteger)ht_daysInYear:(NSDate *)date {
    return [self ht_isLeapYear:date] ? 366 : 365;
}

- (BOOL)ht_isLeapYear {
    return [NSDate ht_isLeapYear:self];
}

+ (BOOL)ht_isLeapYear:(NSDate *)date {
    NSUInteger year = [date ht_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)ht_formatYMD {
    return [NSDate ht_formatYMD:self];
}

+ (NSString *)ht_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",[date ht_year],[date ht_month], [date ht_day]];
}

- (NSUInteger)ht_weeksOfMonth {
    return [NSDate ht_weeksOfMonth:self];
}

+ (NSUInteger)ht_weeksOfMonth:(NSDate *)date {
    return [[date ht_lastdayOfMonth] ht_weekOfYear] - [[date ht_begindayOfMonth] ht_weekOfYear] + 1;
}

- (NSUInteger)ht_weekOfYear {
    return [NSDate ht_weekOfYear:self];
}

+ (NSUInteger)ht_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date ht_year];
    
    NSDate *lastdate = [date ht_lastdayOfMonth];
    
    for (i = 1;[[lastdate ht_dateAfterDay:-7 * i] ht_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)ht_dateAfterDay:(NSUInteger)day {
    return [NSDate ht_dateAfterDate:self day:day];
}

+ (NSDate *)ht_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)ht_dateAfterMonth:(NSUInteger)month {
    return [NSDate ht_dateAfterDate:self month:month];
}

+ (NSDate *)ht_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)ht_begindayOfMonth {
    return [NSDate ht_begindayOfMonth:self];
}

+ (NSDate *)ht_begindayOfMonth:(NSDate *)date {
    return [self ht_dateAfterDate:date day:-[date ht_day] + 1];
}

- (NSDate *)ht_lastdayOfMonth {
    return [NSDate ht_lastdayOfMonth:self];
}

+ (NSDate *)ht_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self ht_begindayOfMonth:date];
    return [[lastDate ht_dateAfterMonth:1] ht_dateAfterDay:-1];
}

- (NSUInteger)ht_daysAgo {
    return [NSDate ht_daysAgo:self];
}

+ (NSUInteger)ht_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)ht_weekday {
    return [NSDate ht_weekday:self];
}

+ (NSInteger)ht_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)ht_dayFromWeekday {
    return [NSDate ht_dayFromWeekday:self];
}

+ (NSString *)ht_dayFromWeekday:(NSDate *)date {
    switch([date ht_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)ht_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)ht_isToday {
    return [self ht_isSameDay:[NSDate date]];
}

- (NSDate *)ht_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)ht_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)ht_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date ht_stringWithFormat:format];
}

- (NSString *)ht_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)ht_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)ht_daysInMonth:(NSUInteger)month {
    return [NSDate ht_daysInMonth:self month:month];
}

+ (NSUInteger)ht_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date ht_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)ht_daysInMonth {
    return [NSDate ht_daysInMonth:self];
}

+ (NSUInteger)ht_daysInMonth:(NSDate *)date {
    return [self ht_daysInMonth:date month:[date ht_month]];
}

- (NSString *)ht_timeInfo {
    return [NSDate ht_timeInfoWithDate:self];
}

+ (NSString *)ht_timeInfoWithDate:(NSDate *)date {
    return [self ht_timeInfoWithDateString:[self ht_stringWithDate:date format:[self ht_ymdHmsFormat]]];
}

+ (NSString *)ht_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self ht_dateWithString:dateString format:[self ht_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate ht_month] - [date ht_month]);
    int year = (int)([curDate ht_year] - [date ht_year]);
    int day = (int)([curDate ht_day] - [date ht_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate ht_month] == 1 && [date ht_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self ht_daysInMonth:date month:[date ht_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate ht_day] + (totalDays - (int)[date ht_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate ht_month];
            int preMonth = (int)[date ht_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)ht_ymdFormat {
    return [NSDate ht_ymdFormat];
}

- (NSString *)ht_hmsFormat {
    return [NSDate ht_hmsFormat];
}

- (NSString *)ht_ymdHmsFormat {
    return [NSDate ht_ymdHmsFormat];
}

+ (NSString *)ht_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)ht_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)ht_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self ht_ymdFormat], [self ht_hmsFormat]];
}

- (NSDate *)ht_offsetYears:(int)numYears {
    return [NSDate ht_offsetYears:numYears fromDate:self];
}

+ (NSDate *)ht_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)ht_offsetMonths:(int)numMonths {
    return [NSDate ht_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)ht_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)ht_offsetDays:(int)numDays {
    return [NSDate ht_offsetDays:numDays fromDate:self];
}

+ (NSDate *)ht_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)ht_offsetHours:(int)hours {
    return [NSDate ht_offsetHours:hours fromDate:self];
}

+ (NSDate *)ht_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}
@end

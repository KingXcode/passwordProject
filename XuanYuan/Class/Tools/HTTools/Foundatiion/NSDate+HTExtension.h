//
//  NSDate+HTExtension.h
//  pangu
//
//  Created by King on 2017/6/15.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HTExtension)

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)ht_day;
- (NSUInteger)ht_month;
- (NSUInteger)ht_year;
- (NSUInteger)ht_hour;
- (NSUInteger)ht_minute;
- (NSUInteger)ht_second;
+ (NSUInteger)ht_day:(NSDate *)date;
+ (NSUInteger)ht_month:(NSDate *)date;
+ (NSUInteger)ht_year:(NSDate *)date;
+ (NSUInteger)ht_hour:(NSDate *)date;
+ (NSUInteger)ht_minute:(NSDate *)date;
+ (NSUInteger)ht_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)ht_daysInYear;
+ (NSUInteger)ht_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)ht_isLeapYear;
+ (BOOL)ht_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)ht_weekOfYear;
+ (NSUInteger)ht_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)ht_formatYMD;
+ (NSString *)ht_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)ht_weeht_weekOfYearksOfMonth;
+ (NSUInteger)ht_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)ht_begindayOfMonth;
+ (NSDate *)ht_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)ht_lastdayOfMonth;
+ (NSDate *)ht_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)ht_dateAfterDay:(NSUInteger)day;
+ (NSDate *)ht_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)ht_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)ht_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)ht_offsetYears:(int)numYears;
+ (NSDate *)ht_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)ht_offsetMonths:(int)numMonths;
+ (NSDate *)ht_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)ht_offsetDays:(int)numDays;
+ (NSDate *)ht_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)ht_offsetHours:(int)hours;
+ (NSDate *)ht_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)ht_daysAgo;
+ (NSUInteger)ht_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)ht_weekday;
+ (NSInteger)ht_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)ht_dayFromWeekday;
+ (NSString *)ht_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)ht_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)ht_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)ht_dateByAddingDays:(NSUInteger)days;

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
+ (NSString *)ht_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)ht_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)ht_stringWithFormat:(NSString *)format;
+ (NSDate *)ht_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)ht_daysInMonth:(NSUInteger)month;
+ (NSUInteger)ht_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)ht_daysInMonth;
+ (NSUInteger)ht_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)ht_timeInfo;
+ (NSString *)ht_timeInfoWithDate:(NSDate *)date;
+ (NSString *)ht_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)ht_ymdFormat;
- (NSString *)ht_hmsFormat;
- (NSString *)ht_ymdHmsFormat;
+ (NSString *)ht_ymdFormat;
+ (NSString *)ht_hmsFormat;
+ (NSString *)ht_ymdHmsFormat;

@end

//
//  NSDate+YL.h
//  YLCalender
//
//  Created by DreamHand on 15/7/31.
//  Copyright (c) 2015年 WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    Sunday = 1,
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,

}Weekday;

@interface NSDate (YL)

/**
 *  今天所在的周是一年中的第几周
 */
+ (NSUInteger)indexOfWeekInYearWithToday;

/**
 *  当前月的第一天
 */
+ (NSDate *)firstDayOfCurrentMonth;

/**
 *  当前月的最后一天
 */
+ (NSDate *)lastDayOfCurrentMonth;

/**
 *  根据日期格式和字符串 创建日期实例
 *
 *  @param format 例如 @"yyyy-MM-dd"
 *  @param date   @"2015-07-31"
 */
+ (NSDate *)dateWithFormat:(NSString *)format string:(NSString *)date;



/**
 *  获取当前日期增加dayCount天的日期
 *
 *  @param dayCount 相差的天数（可为负数）
 *
 *  @return 对应的日期
 */
- (NSDate *)dateAddDays:(NSInteger)dayCount;
/**
 *  获取今天日期(系统设置的时区)
 */
+ (NSDate *)today;
/**
 *  获取昨天的日历
 */
- (NSDate *)yesterday;

/**
 *  根据传入的某个日期，获取整个星期的日期
 *
 *  @return 存放7个日期的数组（从周一到周日）
 */
- (NSArray *)datesForWholeWeek;

/**
 *  计算当前月的第一天是礼拜几
 */
- (Weekday)dayOfFirstDayInCurrentMonth;

/**
 *  当前时间对应的周是当前年中的第几周
 */
- (NSUInteger)indexOfWeekInYear;

/**
 *  所选日期所在月的第一天
 */
- (NSDate *)firstDayOfMonth;

/**
 *  所选日期所在月的最后一天
 */
- (NSDate *)lastDayOfMonth;

/**
 *  上个月的这一天
 */
- (NSDate *)dayInThePreviousMonth;

/**
 *  下个月的这一天
 */
- (NSDate *)dayInTheNextMonth;

/**
 *  计算当前日期的月份有多少天
 */
- (NSUInteger)numberOfDaysInMonth;

/**
 *  将日期转换成对应格式的字符串
 *
 *  @param format 例如：@"yyyy-MM-dd"
 */
- (NSString *)dateToStringWithFormat:(NSString *)format;

/**
 *  获取日期对应的年份
 *
 *  @return 如：2015
 */
- (NSUInteger)year;

/**
 *  获取日期对应的月份
 *
 *  @return 如：8
 */
- (NSUInteger)month;

/**
 *  获取日期对应的号
 *
 *  @return 如：13
 */
- (NSUInteger)day;

/**
 *  获取日期对应的小时数
 *
 *  @return 如：11
 */
- (NSUInteger)hour;
/**
 *  获取日期对应的分钟数
 *
 *  @return 如：25
 */
- (NSUInteger)minute;

/**
 *  获取日期对应的秒数
 *
 *  @return 如： 59
 */
- (NSUInteger)second;
/**
 *  获取日期为星期几
 */
- (Weekday)weekday;

/**
 *  是否为同一天
 *
 *  @param otherDate 另一个日期
 */
- (BOOL)sameDayWithDate:(NSDate *)otherDate;

/**
 *  是否在同一周
 *
 *  @param otherDate 另一个日期
 */
- (BOOL)sameWeekWithDate:(NSDate *)otherDate;

/**
 *  是否在同一个月
 *
 *  @param otherDate 另一个日期
 */
- (BOOL)sameMonthWithDate:(NSDate *)otherDate;





/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

@end

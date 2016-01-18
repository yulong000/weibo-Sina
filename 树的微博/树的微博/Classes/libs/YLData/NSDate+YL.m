//
//  NSDate+YL.m
//  YLCalender
//
//  Created by DreamHand on 15/7/31.
//  Copyright (c) 2015年 WYL. All rights reserved.
//

#import "NSDate+YL.h"

@implementation NSDate (YL)


#pragma mark 根据日期格式和字符串 创建日期实例
+ (NSDate *)dateWithFormat:(NSString *)format string:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateStr];
}
#pragma mark 计算当前月的第一天是礼拜几
- (Weekday)dayOfFirstDayInCurrentMonth
{
    return [[NSDate firstDayOfCurrentMonth] weekday];
}

#pragma mark 当前时间对应的周是当前年中的第几周
- (NSUInteger)indexOfWeekInYear
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSWeekOfYearCalendarUnit inUnit:NSYearCalendarUnit forDate:self];
}
#pragma mark 今天所在的周是一年中的第几周
+ (NSUInteger)indexOfWeekInYearWithToday
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSWeekCalendarUnit inUnit:NSYearCalendarUnit forDate:[NSDate date]];
}

#pragma mark 所选日期所在月的第一天
- (NSDate *)firstDayOfMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}
#pragma mark 所选日期所在月的最后一天
- (NSDate *)lastDayOfMonth
{
    NSCalendarUnit calendarUnit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:calendarUnit fromDate:self];
    dateComponents.day = [self numberOfDaysInMonth];
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

#pragma mark 当前月的第一天
+ (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:[NSDate date]];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}
#pragma mark 当前月的最后一天
+ (NSDate *)lastDayOfCurrentMonth
{
    NSCalendarUnit calendarUnit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:calendarUnit fromDate:[NSDate date]];
    dateComponents.day = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]].length;;
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

#pragma mark 上个月的这一天
- (NSDate *)dayInThePreviousMonth
{
    NSDateComponents *dateComponents = [self dateComponents];
    dateComponents.month = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

#pragma mark 下个月的这一天
- (NSDate *)dayInTheNextMonth
{
    NSDateComponents *dateComponents = [self dateComponents];
    dateComponents.month = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

#pragma mark 计算当前日期的月份有多少天
- (NSUInteger)numberOfDaysInMonth
{
    // 频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
}

#pragma mark 将日期转换成对应格式的字符串  如："yyyy-MM-dd"
- (NSString *)dateToStringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    [formatter setDateFormat:format];
//    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    return [formatter stringFromDate:self];
}

#pragma mark 获取日期对应的年份
- (NSUInteger)year
{
    return [self dateComponents].year;
}

#pragma mark 获取日期对应的月份
- (NSUInteger)month
{
    return [self dateComponents].month;
}

#pragma mark 获取日期对应的天
- (NSUInteger)day
{
    return [self dateComponents].day;
}

#pragma mark 获取日期对应的小时数
- (NSUInteger)hour
{
    return [self dateComponents].hour;
}


#pragma mark 获取日期对应的分钟数
- (NSUInteger)minute
{
    return [self dateComponents].minute;
}

#pragma mark 获取日期对应的秒数
- (NSUInteger)second
{
    return [self dateComponents].second;
}

#pragma mark 获取日期为星期几
- (Weekday)weekday
{
    NSDateComponents *dateComponents = [self dateComponents];
    Weekday day;
    switch ([dateComponents weekday]) {
        case 1:
            day = Sunday;
            break;
        case 2:
            day = Monday;
            break;
        case 3:
            day = Tuesday;
            break;
        case 4:
            day = Wednesday;
            break;
        case 5:
            day = Thursday;
            break;
        case 6:
            day = Friday;
            break;
        case 7:
            day = Saturday;
            break;
        default:
            break;
    }
//    YLLog(@"self : %@,  weekday : %d  day  : %d  timezone : %@, 星期几: %d" , self,dateComponents.weekday, dateComponents.day, dateComponents.timeZone.name, day);
    return day;
}

#pragma mark 获取一个NSDateComponents实例
- (NSDateComponents *)dateComponents
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    dateComponents.timeZone = [NSTimeZone systemTimeZone];
    return dateComponents;
}
#pragma mark 获取今天日期(系统设置的时区)
+ (NSDate *)today
{
    // 对时区引起的差别进行转换
    NSDate *date = [NSDate date];
//    NSString *dateStr = [date dateToStringWithFormat:@"yyyy-MM-dd hh:mm:ss"];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSTimeInterval interval = [zone secondsFromGMTForDate:date];
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    formatter.dateStyle = NSDateFormatterFullStyle;
//    formatter.timeZone = [NSTimeZone systemTimeZone];
//    NSString *dateStr = [formatter stringFromDate:date];
//    NSDate *today = [formatter dateFromString:dateStr];
//    return today;
    
//    return [formatter dateFromString:dateStr];
//    NSDate *today = [date dateByAddingTimeInterval:interval];
    return date;
}

#pragma mark 获取某个日期对应的前一天的日期
- (NSDate *)yesterday
{
    NSDateComponents *dateComponents = [self dateComponents];
    dateComponents.day -= 1;
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

#pragma mark 获取当前日期增加dayCount天的日期
- (NSDate *)dateAddDays:(NSInteger)dayCount
{
    NSDateComponents *dateComponents = [self dateComponents];
    dateComponents.day += dayCount;
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

#pragma mark 根据传入的某个日期，获取整个星期的日期
- (NSArray *)datesForWholeWeek
{
    // 星期几
    Weekday weekday = [self weekday];
    // 星期一
    NSDate *monday = [self dateAddDays: - weekday + 1];
    NSTimeInterval timeInterval = 24 * 60 * 60;
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:7];
    for(int i = 0; i < 7; i++)
    {
        NSDate *date = [NSDate dateWithTimeInterval:timeInterval * i  sinceDate:monday];
        [arr addObject:date];
    }
    return [NSArray arrayWithArray:arr];
}

#pragma mark 是否为同一天
- (BOOL)sameDayWithDate:(NSDate *)otherDate
{
    return  self.year == otherDate.year && self.month == otherDate.month && self.day == otherDate.day;
}

#pragma mark 是否在同一周
- (BOOL)sameWeekWithDate:(NSDate *)otherDate
{
    return self.year == otherDate.year && self.indexOfWeekInYear == otherDate.indexOfWeekInYear;
}

#pragma mark 是否在同一个月
- (BOOL)sameMonthWithDate:(NSDate *)otherDate
{
    return self.year == otherDate.year && self.month == otherDate.month;
}


#pragma mark 是否为今天
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

#pragma mark 是否为昨天
- (BOOL)isYesterday
{
    // 2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    // 2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}


#pragma mark 是否为今年
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

@end

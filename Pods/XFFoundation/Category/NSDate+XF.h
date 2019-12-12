//
//  NSDate+XF.h
//  MoreFollows
//
//  Created by xiaoniu on 2019/1/18.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XF)

+ (void)initializeStatics;

+ (NSCalendar *)sharedCalendar;
+ (NSDateFormatter *)sharedDateFormatter;
- (NSUInteger)daysAgo;
- (NSUInteger)daysAgoAgainstMidnight;
- (NSString *)stringDaysAgo;
- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag;
- (NSUInteger)weekday;
- (NSUInteger)weekNumber;
- (NSUInteger)hour;
- (NSUInteger)minute;
- (NSUInteger)second;
- (NSUInteger)day;
- (NSUInteger)month;
- (NSUInteger)year;
- (long int)utcTimeStamp; //full seconds since
+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed alwaysDisplayTime:(BOOL)displayTime;
- (NSString *)string;
- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSDate *)beginningOfWeek;
- (NSDate *)beginningOfDay;
- (NSDate *)endOfWeek;
+ (NSString *)dateFormatString;
+ (NSString *)timeFormatString;
+ (NSString *)timestampFormatString;
+ (NSString *)dbFormatString;

+(NSString *)stringWithFormatISO86011:(NSString *)ddate;
+ (NSString *)stringWithFormatMillSecond:(NSString*)actDate;

/**
 yyyy-MM-dd HH:mm:ss -> yyyy年MM月dd日

 @param dateStr yyyy-MM-dd HH:mm:ss 
 @return yyyy年MM月dd日
 */
+ (NSString *)formatToYMD:(NSString *)dateStr;

/**
 转换成 几分钟前，几天前
 
 @param timeStr yyyy-MM-DD HH:mm:ss
 @return 
 */
+ (NSString *)liveTimeAgoWithTimeStr:(NSString *)timeStr;
-(NSString *)liveTimeAgo:(NSDate *)anotherDate;

+ (NSString *)currentYear;
+ (NSString *)currentYearMonth;
+ (NSString *)currentYearMonthDay;

/**
 当前这个月有多少天

 @return 当前这个月有多少天
 */
+ (NSUInteger)currentMonthDays;

+ (NSString *)yearMonthDayForCurrentMonthFirstDay;
+ (NSString *)yearMonthDayForCurrentMonthLastDay;

@end



//
//  DAYUtils.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/12.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "DAYUtils.h"

@implementation DAYUtils
+ (NSCalendar *)localCalendar {
    static NSCalendar *Instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    });
    return Instance;
}

+ (NSDate *)dateWithMonth:(NSUInteger)month year:(NSUInteger)year {
    return [self dateWithMonth:month day:1 year:year];
}

+ (NSDate *)dateWithMonth:(NSUInteger)month day:(NSUInteger)day year:(NSUInteger)year {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = year;
    comps.month = month;
    comps.day = day;
    
    return [self dateFromDateComponents:comps];
}

+ (NSDate *)dateFromDateComponents:(NSDateComponents *)components {
    return [[self localCalendar] dateFromComponents:components];
}

+ (NSUInteger)daysInMonth:(NSUInteger)month ofYear:(NSUInteger)year {
    NSDate *date = [self dateWithMonth:month year:year];
    return [[self localCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}

+ (NSUInteger)firstWeekdayInMonth:(NSUInteger)month ofYear:(NSUInteger)year {
    NSDate *date = [self dateWithMonth:month year:year];
    return [[self localCalendar] component:NSCalendarUnitWeekday fromDate:date];
}

+ (NSString *)stringOfWeekdayInEnglish:(NSUInteger)weekday {
    NSAssert(weekday >= 1 && weekday <= 7, @"Invalid weekday: %lu", (unsigned long) weekday);
    static NSArray *Strings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Strings = @[@"日", @"月", @"火", @"水", @"木", @"金", @"土"];
    });
    
    return Strings[weekday - 1];
}

+ (NSString *)stringOfMonthInEnglish:(NSUInteger)month {
    NSAssert(month >= 1 && month <= 12, @"Invalid month: %lu", (unsigned long) month);
    static NSArray *Strings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Strings = @[@"1 月", @"2 月", @"3 月", @"4 月", @"5 月", @"6 月", @"7 月", @"8 月", @"9 月", @"10 月", @"11 月", @"12 月"];
    });
    
    return Strings[month - 1];
}

+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)date {
    return [[self localCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
}

+ (BOOL)isDateTodayWithDateComponents:(NSDateComponents *)dateComponents {
    NSDateComponents *todayComps = [self dateComponentsFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    return todayComps.year == dateComponents.year && todayComps.month == dateComponents.month && todayComps.day == dateComponents.day;
}
@end

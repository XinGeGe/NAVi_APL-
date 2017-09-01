//
//  DAYUtils.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/12.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAYUtils : NSObject
+ (NSCalendar *)localCalendar;

+ (NSDate *)dateWithMonth:(NSUInteger)month year:(NSUInteger)year;

+ (NSDate *)dateWithMonth:(NSUInteger)month day:(NSUInteger)day year:(NSUInteger)year;

+ (NSDate *)dateFromDateComponents:(NSDateComponents *)components;

+ (NSUInteger)daysInMonth:(NSUInteger)month ofYear:(NSUInteger)year;

+ (NSUInteger)firstWeekdayInMonth:(NSUInteger)month ofYear:(NSUInteger)year;

+ (NSString *)stringOfWeekdayInEnglish:(NSUInteger)weekday;

+ (NSString *)stringOfMonthInEnglish:(NSUInteger)month;

+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)date;

+ (BOOL)isDateTodayWithDateComponents:(NSDateComponents *)dateComponents;
@end

//
//  DateUtil.m
//  naviKomei
//
//  Created by xiaoyu.zhang on 15/9/8.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+(NSString *)getSystemDate {
    NSDate *systemDate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
    [dateformatter setLocale:locale];
    [dateformatter setDateFormat:@"yyyyMMdd"];
    
    return [dateformatter stringFromDate:systemDate];
}

+(NSString *)addDays:(NSDate *)date days:(NSInteger)days {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSDateComponents *adcomps = [[NSDateComponents alloc] init];

    [adcomps setDay:days];

    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
//    [dateformatter setLocale:locale];
    [dateformatter setDateFormat:@"yyyyMMdd"];
    
    return [dateformatter stringFromDate:newdate];
}
+(NSString *)addDaysWithSetLocale:(NSDate *)date days:(NSInteger)days {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setDay:days];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
    [dateformatter setLocale:locale];
    [dateformatter setDateFormat:@"yyyyMMdd"];
    
    return [dateformatter stringFromDate:newdate];
}

+(NSString *)addDaysForDayJourn:(NSDate *)date days:(NSInteger)days {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setDay:days];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
    [dateformatter setLocale:locale];
    [dateformatter setDateFormat:@"yyyyMMdd"];
    
    return [dateformatter stringFromDate:newdate];
}
/**
 * format date
 *
 */
+(NSString *)formatUpdatetime:(NSString *)updatetime{
    
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@" " withString:@""];
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    return updatetime;
}
+(NSString *)formateDateWithSlash:(NSString *)date{
    if (date.length == 8) {
        date = [NSString stringWithFormat:@"%@/%@/%@",[date substringToIndex:4],[date substringWithRange:NSMakeRange(4, 2)],[date substringFromIndex:6]];
    }else if (date.length == 6){
        date = [NSString stringWithFormat:@"%@/%@",[date substringToIndex:4],[date substringFromIndex:4]];
    }
    return date;
}
+(NSString *)formateDateWithYear:(NSString *)date{
    NSInteger year = date.integerValue -1989 +1;
    date = [NSString stringWithFormat:@"%ld",(long)year];
    return date;
}
+(NSString *)formateDateWithMonthDay:(NSString *)date{
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
    [dateformatter setLocale:locale];
    [dateformatter setDateFormat:@"yyyyMMdd"];
    NSDate * date1 = [dateformatter dateFromString:date];
    
    NSArray *weekdays = [NSArray arrayWithObjects:@"日", @"月", @"火", @"水", @"木", @"金", @"土",nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *theComponents = [calendar components:NSWeekdayCalendarUnit fromDate:date1];

    NSInteger inde = theComponents.weekday;
    date = [weekdays objectAtIndex:inde-1];

    return date;
}

@end

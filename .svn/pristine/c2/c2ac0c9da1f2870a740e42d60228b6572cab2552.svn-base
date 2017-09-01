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

    NSDateComponents *comps = nil;

    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];

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
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    
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
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    
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
@end

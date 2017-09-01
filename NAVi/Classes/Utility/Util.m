//
//  Util.m
//  NAVi
//
//  Created by y fs on 15/5/29.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "Util.h"

@implementation Util
+ (CGSize)screenSize {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    return screenSize;
}
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
+(NSString *)getSystemDate{
    NSDate *systemDate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
    [dateformatter setLocale:locale];
    [dateformatter setDateFormat:@"yyyyMMdd"];
    
    return [dateformatter stringFromDate:systemDate];
}
+(NSString *)getLabelName:(NAClipDoc *)doc{
    
    NSString *str;
    str=[NSString stringWithFormat:@"%@-%@-%@-%@",doc.publishDate,doc.publisherInfoName,doc.editionInfoName,doc.pageInfoName];
    return str;
}
+(NSString *)getTheFormatString:(NSString *)datestr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [dateFormatter dateFromString:datestr];
    
    NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
    [mydateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDateStr = [mydateFormatter stringFromDate:date];
    return currentDateStr;
}
+(double)getTimeDvalue:(NSDate *)date1 Date2:(NSDate *)date2{
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    
//    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    
//    NSDateComponents *d = [cal components:unitFlags fromDate:date1 toDate:date2 options:0];
//    
//    NSInteger sec = [d hour]*3600+[d minute]*60+[d second];
//    NSLog(@"second = %ld",(long)[d hour]*3600+[d minute]*60+[d second]);
    NSString *timestr1 = [NSString stringWithFormat:@"%f", (double)[date1 timeIntervalSince1970]];
    NSString *timestr2 = [NSString stringWithFormat:@"%f", (double)[date2 timeIntervalSince1970]];
    double dvalue=([timestr2 doubleValue] - [timestr1 doubleValue]) * 1000;
    //NSLog(@"sec%.f",dvalue);
    
    return dvalue;
}
+(NSString *)getYYMMDateString:(NSString *)datestr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:datestr];
    
    NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
    [mydateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentDateStr = [mydateFormatter stringFromDate:date];
    return currentDateStr;
}
+(NSString *)getMP4Url:(NSString *)weburl Prams:(NSString *)pramStr{
    NSString *string2 = @".";
    NSRange range = [weburl rangeOfString:string2 options:NSBackwardsSearch];
    NSRange subRange=NSMakeRange(0, range.location);
    NSString *strUrl =[weburl substringWithRange:subRange];
    NSString *tureUrl=[strUrl stringByAppendingString:[NSString stringWithFormat:@".mp4?%@",pramStr]];
    return tureUrl;
}
+(BOOL) webFileExists:(NSString *)urlStr{

    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    NSHTTPURLResponse* response = nil;
    NSError* error = nil;
    NSData *responseData= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //NSLog(@"statusCode = %d", [response statusCode]);
   
    
    if ([response statusCode] == 404){
        return NO;
    }else{
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        //NSLog(@"responseData = %@", responseString);
        if ([responseString rangeOfString:@"</body>"].location ==NSNotFound) {
            return NO;
        }else{
            NSString *getBodystr=[responseString substringFromIndex:[responseString rangeOfString:@"<body>"].location+6];
            getBodystr=[getBodystr substringToIndex:[getBodystr rangeOfString:@"</body>"].location];
            getBodystr = [getBodystr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            getBodystr = [getBodystr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            getBodystr = [getBodystr stringByReplacingOccurrencesOfString:@" " withString:@""];
            //NSLog(@"getBodystr = %@", getBodystr);
            if(getBodystr&&getBodystr.length>0){
                return YES;
            }else{
                return NO;
            }
           
        }
    }

}

+ (void)showAlert:(NSString *)alertTitle okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle okAction:(void (^)(UIAlertAction *_Nonnull action))okBlock cancelAction:(void (^)(UIAlertAction *_Nonnull action))cancelBlock controller:(UIViewController *)controller {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:okBlock];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [controller presentViewController:alert animated:YES completion:nil];
}

@end

//
//  Util.h
//  NAVi
//
//  Created by y fs on 15/5/29.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAClipDoc.h"

@interface Util : NSObject
+ (CGSize)screenSize;
+ (UIColor *) colorWithHexString: (NSString *)color;
+(NSString *)getLabelName:(NAClipDoc *)doc;
+(NSString *)getTheFormatString:(NSString *)datestr;
+(double)getTimeDvalue:(NSDate *)date1 Date2:(NSDate *)date2;
+(NSString *)getMP4Url:(NSString *)weburl Prams:(NSString *)pramStr;
+(NSString *)getYYMMDateString:(NSString *)datestr;
+(NSString *)getSystemDate;
+(BOOL) webFileExists:(NSString *)urlStr;
+ (void)showAlert:(nonnull NSString *)alertTitle okTitle:(nullable NSString *)okTitle cancelTitle:(nullable NSString *)cancelTitle okAction:(nonnull void (^)(UIAlertAction *_Nonnull action))okBlock cancelAction:(nullable void (^)(UIAlertAction *_Nonnull action))cancelBlock controller:(nonnull UIViewController *)controller;
@end


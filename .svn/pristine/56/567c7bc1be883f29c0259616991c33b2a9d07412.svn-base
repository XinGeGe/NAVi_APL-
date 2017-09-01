//
//  TAGManagerUtil.m
//  NAVi
//
//  Created by y fs on 15/6/18.
//  Copyright (c) 2015年 dxc. All rights reserved.
//


#import "AppDelegate.h"
#import "TAGDataLayer.h"
#import "TAGManager.h"
#import "TAGManagerUtil.h"

@implementation TAGManagerUtil

+ (void)pushOpenScreenEvent:(NSString *)eventName ScreenName:(NSString *)screenName{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.tagManager.dataLayer push:@{@"event":eventName,
                                              @"screenName": screenName}];
    });
}

+ (void)pushButtonClickEvent:(NSString *)eventName label:(NSString *)label {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.tagManager.dataLayer push:@{@"event": eventName,
                                              @"label": label}];
    });
}

@end

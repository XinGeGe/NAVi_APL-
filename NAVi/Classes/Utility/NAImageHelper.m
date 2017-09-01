//
//  NAImageHelper.m
//  NAVi
//
//  Created by y fs on 15/8/5.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NAImageHelper.h"

@implementation NAImageHelper
@synthesize whichstyle;
+ (NAImageHelper *)sharedInstance
{
    static NAImageHelper *_sharedInstance = nil;
    static dispatch_once_t managerPredicate;
    dispatch_once(&managerPredicate, ^{
        _sharedInstance = [[self alloc] init];
        _sharedInstance.whichstyle=NABlueStyle;
    });
    
    return _sharedInstance;
}
- (NSString *)getImageName:(NSString *)name{
    return [NSString stringWithFormat:@"%@.png",name];
}
- (UIColor *)getToolBarColor{
    if ([whichstyle isEqualToString:NABlueStyle]) {
        return [UIColor colorWithRed:0 green:32.0f / 255.0f blue:96.0f / 255.0f alpha:1];
    }else if([whichstyle isEqualToString:NAWhiteStyle]){
        return [UIColor whiteColor];
    }else{
        return [UIColor colorWithRed:0 green:32.0f / 255.0f blue:96.0f / 255.0f alpha:1];
    }
}
- (UIColor *)getNavTitleColor{
    if ([whichstyle isEqualToString:NABlueStyle]) {
        return [UIColor whiteColor];
    }else if([whichstyle isEqualToString:NAWhiteStyle]){
        return [UIColor blackColor];
    }else{
        return [UIColor blackColor];
    }
}
- (UIColor *)getPageTitleColor{
    if ([whichstyle isEqualToString:NABlueStyle]) {
        return [UIColor whiteColor];
    }else if([whichstyle isEqualToString:NAWhiteStyle]){
        return [UIColor blueColor];
    }else{
        return [UIColor blueColor];
    }
}
- (UIColor *)getPageDetailTitleColor{
    if ([whichstyle isEqualToString:NABlueStyle]) {
        return [UIColor whiteColor];
    }else if([whichstyle isEqualToString:NAWhiteStyle]){
        return [UIColor blackColor];
    }else{
        return [UIColor blackColor];
    }
}
@end

//
//  UITableView+NASeparatorInset.m
//  naviKomei
//
//  Created by y fs on 15/11/5.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import "UITableView+NASeparatorInset.h"
#import <objc/runtime.h>

@implementation UITableView (NASeparatorInset)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(initWithFrame:style:);
        SEL swizzledSelector = @selector(initWithNAFrame:style:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
-(instancetype)initWithNAFrame:(CGRect)frame style:(UITableViewStyle)style{
    UITableView *tableView=nil;
    
    if ([self respondsToSelector:@selector(initWithNAFrame:style:)]) {
         tableView= [self initWithNAFrame:frame style:style];
    }
    if([tableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)])
    {
        tableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }

    return tableView;
}
@end

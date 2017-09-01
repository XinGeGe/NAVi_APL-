//
//  NAHomeDataShare.m
//  naviKomei
//
//  Created by y fs on 15/11/30.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import "NAHomeDataShare.h"

@implementation NAHomeDataShare

+ (NAHomeDataShare *)sharedInstance
{
    static NAHomeDataShare *_sharedInstance = nil;
    static dispatch_once_t managerPredicate;
    dispatch_once(&managerPredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

@end

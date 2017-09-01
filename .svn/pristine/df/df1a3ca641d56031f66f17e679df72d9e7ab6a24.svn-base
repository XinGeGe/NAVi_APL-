//
//  NACheckNetwork.h
//  NAVi
//
//  Created by y fs on 15/6/9.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIAlertViewWithBlock.h"
typedef void(^checkNetworkBlock)(BOOL isNetwork);
@interface NACheckNetwork : NSObject

@property(nonatomic,readwrite) BOOL isHavenetwork;
@property(nonatomic,readwrite) BOOL notCallBack;
@property(nonatomic,readwrite) BOOL isViaWWAN;
@property (nonatomic, strong) checkNetworkBlock checkBlock;
+ (NACheckNetwork *)sharedInstance;
-(void)getTheNetworkCompletionBlock:(void(^)(BOOL isNetwork))completion;
@end

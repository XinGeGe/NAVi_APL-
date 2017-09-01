//
//  NASendTokeClient.h
//  NAVi
//
//  Created by y fs on 15/12/25.
//  Copyright © 2015年 dxc. All rights reserved.
//
#import "AFNetworking.h"

#import <Foundation/Foundation.h>


@interface NASendTokeClient : AFHTTPRequestOperationManager

+ (NASendTokeClient *)sharedClient;

/**
 *  sendTokenWithParam
 *
 *  @param param
 *  @param completion
 */
- (void)sendTokenWithParam:(NSDictionary *)param
             completionBlock:(void(^)(id response, NSError *error))completion;
@end

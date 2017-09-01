//
//  NASendTokeClient.m
//  NAVi
//
//  Created by y fs on 15/12/25.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import "NASendTokeClient.h"

@implementation NASendTokeClient
+ (NASendTokeClient *)sharedClient
{
    /// Override at subclass
    static NASendTokeClient *_sharedClient = nil;
    NSURL * url = [NSURL URLWithString:[NSString pushURLPath]];
    
    _sharedClient = [[self alloc] initWithBaseURL:url];
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    
    
    return self;
}
- (void)sendTokenWithParam:(NSDictionary *)param
           completionBlock:(void(^)(id master, NSError *error))completion{
    
    [self POST:[NSString sendTokenPath] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion (responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
@end

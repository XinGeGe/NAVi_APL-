 //
//  NACheckNetwork.m
//  NAVi
//
//  Created by y fs on 15/6/9.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NACheckNetwork.h"

@implementation NACheckNetwork
@synthesize isHavenetwork;

+ (NACheckNetwork *)sharedInstance
{
    static NACheckNetwork *_sharedInstance = nil;
    static dispatch_once_t managerPredicate;
    dispatch_once(&managerPredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)getTheNetworkCompletionBlock:(void(^)(BOOL isNetwork))completion{
    NSURL *baseURL = [NSURL URLWithString:HostName];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                isHavenetwork=YES;
                self.isViaWWAN=YES;
                 NSLog(@"REACHABLE!");

            case AFNetworkReachabilityStatusReachableViaWiFi:
                isHavenetwork=YES;
                self.isViaWWAN=NO;
                 NSLog(@"REACHABLE!");
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                isHavenetwork=NO;
                self.isViaWWAN=NO;
                 NSLog(@"UNREACHABLE!");
            default:
                [operationQueue setSuspended:YES];
                break;
        }
        
        if (status==AFNetworkReachabilityStatusReachableViaWWAN) {
            isHavenetwork=YES;
            NSLog(@"REACHABLE!");
            /*
            UIAlertViewWithBlock *alert= [[UIAlertViewWithBlock alloc] initWithTitle:@"" message:NSLocalizedString(@"WiFi Check Message", nil) cancelButtonTitle:@"はい" otherButtonTitles:@"いいえ", nil];
            [alert showWithDismissHandler:^(NSInteger selectedIndex) {
                switch (selectedIndex) {
                    case 1: {
                        isHavenetwork=NO;
                    } break;
                    case 0: {
                        isHavenetwork=YES;
                        
                    }
                    default:
                        NSLog(@"case default:");
                        break;
                }
                
                
            }];
            */

        }else if (status==AFNetworkReachabilityStatusReachableViaWWAN){
            isHavenetwork=YES;
            NSLog(@"REACHABLE!");
            [operationQueue setSuspended:NO];
           
        }else if (status==AFNetworkReachabilityStatusNotReachable){
            isHavenetwork=NO;
            NSLog(@"UNREACHABLE!");
           
        }else{
            [operationQueue setSuspended:YES];
           
        }
        if (!self.notCallBack) {
            completion(isHavenetwork);
        }
        
    }];
    
    [manager.reachabilityManager startMonitoring];
    
}

 @end

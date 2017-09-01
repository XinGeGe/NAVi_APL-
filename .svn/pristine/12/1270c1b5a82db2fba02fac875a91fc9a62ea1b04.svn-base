//
//  NANetworkClient.m
//  NAVi
//
//  Created by y fs on 15/9/18.
//  Copyright (c) 2015年 hyc. All rights reserved.
//

#import "NANetworkClient.h"

@implementation NANetworkClient

+ (NANetworkClient *)sharedClient
{
    static NANetworkClient *_sharedClient = nil;
    NSURL * url = [NSURL URLWithString:[NSString baseURLPath]];
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
#pragma mark -
#pragma mark Public

- (void)postDefaultUseridMasterWithDevice:(NSString *)useDevice completionBlock:(void(^)(id master, NSError *error))completion
{
    NSString *userId = [NASaveData getDefaultUserID];
    NSDictionary *param = @{
                            @"Userid"     :  userId,
                            @"UseDevice"  :  useDevice,
                            };
    [self postPath:[NSString masterPath] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion (responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ///ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        [ProgressHUD dismiss];
    }];
    
}
- (void)postCheckUserid:(NSDictionary *)param completionBlock:(void(^)(id master, NSError *error))completion
{
    [self postPath:[NSString loginPath] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion (responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        [ProgressHUD dismiss];
    }];
    
}

- (void)postMasterWithDevice:(NSDictionary *)param completionBlock:(void(^)(id master, NSError *error))completion
{
       [self postPath:[NSString masterPath] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion (responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        [ProgressHUD dismiss];
    }];
    
}
- (void)postSearch:(NSDictionary *)param completionBlock:(void(^)(id search, NSError *error))completion
{
    [self postPath:[NSString searchPath] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion (responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion (nil, error);
        [ProgressHUD dismiss];
    }];
    
}
- (void)postFavoritesSave:(NSDictionary *)param completionBlock:(void(^)(id favorites, NSError *error))completion
{
    [self getPath:[NSString favoritesSavePath] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion (responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        [ProgressHUD dismiss];
    }];
    
}
- (void)postFavoritesSearch:(NSDictionary *)param completionBlock:(void(^)(id favorites, NSError *error))completion
{
    [self getPath:[NSString favoritesSearchPath] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion (responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        completion (nil, error);
        [ProgressHUD dismiss];
    }];
    
}
//searchTagList
- (void)postTagFavoritesSearch:(NSDictionary *)param
               completionBlock:(void(^)(id favorites, NSError *error))completion{
    [self getPath:[NSString favoritesTagSearchPath] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion (responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        completion (nil, error);
        [ProgressHUD dismiss];
    }];
}
//searchFavoritesList
- (void)postTagFavoritesListSearch:(NSDictionary *)param
                   completionBlock:(void(^)(id favorites, NSError *error))completion{
    [self getPath:[NSString searchFavoritesListPath] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion (responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        completion (nil, error);
        [ProgressHUD dismiss];
    }];
}
- (void)postRelevantPhoto:(NSDictionary *)param
          completionBlock:(void(^)(id favorites, NSError *error))completion
{
    [self getPath:[NSString relevantPhotoPath] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion (responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        [ProgressHUD dismiss];
    }];
    
}
- (void)postLogoutWithDevice:(NSString *)useDevice completionBlock:(void(^)(NALogoutModel *logout, NSError *error))completion
{
    NSString *userId = [NASaveData getLoginUserId];
    NSDictionary *param = @{
                            @"Userid"     :  userId,
                            @"UseDevice"  :  useDevice,
                            };
    [self postPath:[NSString logoutPath] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SHXMLParser *parser = [[SHXMLParser alloc] init];
        NSDictionary *dic = [parser parseData:responseObject];
        NSDictionary *logoutInfo = [dic objectForKey:@"response"];
        NALogoutModel *logoutModel = nil;
        if (logoutInfo) {
            logoutModel = [[NALogoutModel alloc] init];
            logoutModel.status = [logoutInfo objectForKey:@"status"];
            logoutModel.message = [logoutInfo objectForKey:@"message"];
        }
        
        if (completion) {
            completion (logoutModel, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        if (completion) {
            completion(nil, error);
        }
    }];
}

- (void)postFavoritesDelete:(NSDictionary *)param completionBlock:(void(^)(id favorites, NSError *error))completion
{
    [self getPath:[NSString avoritesDeletePath] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion (responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        [ProgressHUD dismiss];
    }];
    
}
- (void)deleteTag:(NSDictionary *)param completionBlock:(void(^)(id favorites, NSError *error))completion{
    [self getPath:[NSString deleteTag] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion (responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        [ProgressHUD dismiss];
    }];
}
- (void)renameTag:(NSDictionary *)param completionBlock:(void(^)(id favorites, NSError *error))completion{
    [self getPath:[NSString renameTag] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion (responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        [ProgressHUD dismiss];
    }];
}
- (void)saveTag:(NSDictionary *)param completionBlock:(void(^)(id favorites, NSError *error))completion{
    [self getPath:[NSString saveTag] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion (responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        [ProgressHUD dismiss];
    }];
}
- (void)ClipMemo:(NSDictionary *)param completionBlock:(void(^)(id favorites, NSError *error))completion{
    [self getPath:[NSString ClipMemo] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion (responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        [ProgressHUD dismiss];
    }];
}
- (void)changeClipInfo:(NSDictionary *)param completionBlock:(void(^)(id favorites, NSError *error))completion{
    [self getPath:[NSString changeClipInfo] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion (responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        [ProgressHUD dismiss];
    }];
}
@end


#import "NADownLoadImageClient.h"

@implementation NADownLoadImageClient

+ (NADownLoadImageClient *)sharedClient
{
    static NADownLoadImageClient *_sharedClient = nil;
    _sharedClient= [self manager];
    return _sharedClient;
}


- (void)postDownLoadImage:(NSString *)path completionBlock:(void(^)(id image, NSError *error))completion
{
    self.responseSerializer = [AFImageResponseSerializer serializer];
    [self POST:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion (responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion (nil, error);
    }];
    
}

@end

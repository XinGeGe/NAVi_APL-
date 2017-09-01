
#import "NABaseClient.h"
#import "AFNetworking.h"

@interface NADownLoadImageClient : AFHTTPRequestOperationManager

+ (NADownLoadImageClient *)sharedClient;
/**
 *  紙面 download
 *
 *  @param path
 *  @param completion
 */
- (void)postDownLoadImage:(NSString *)path completionBlock:(void(^)(id image, NSError *error))completion;
@end

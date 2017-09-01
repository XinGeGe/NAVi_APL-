
#import "NABaseClient.h"
#import "NALoginModel.h"
#import "NASendTokeClient.h"

@interface NALoginClient : NABaseClient

- (void)postLoginwithUserId:(NSString *)userId
               withPassword:(NSString *)password
            withDeviceModel:(NSString *)deviceModel
            completionBlock:(void(^)(NALoginModel *login, NSError *error))completion;

@end

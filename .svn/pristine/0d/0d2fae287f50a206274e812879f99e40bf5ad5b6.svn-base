
#import "AFNetworking.h"
#import "SHXMLParser.h"
#import "NSString+NAAPI.h"
#import "NASaveData.h"
#import "NADefine.h"
#import "NAFileManager.h"
#import "DataModels.h"

@interface NABaseClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;


- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end


#import "NABaseClient.h"

@implementation NABaseClient

+ (instancetype)sharedClient
{
    /// Override at subclass
    return [self manager];
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
    }
    return self;
}

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestSerializer * requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setTimeoutInterval:30];
    AFHTTPResponseSerializer * responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *ua = @"Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25";
    [requestSerializer setValue:ua forHTTPHeaderField:@"User-Agent"];
    //    [requestSerializer setValue:@"application/xml" forHTTPHeaderField:@"Content-type"];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", nil];
    self.responseSerializer = responseSerializer;
    self.requestSerializer = requestSerializer;
    
    //NSString *myurl=[NSString stringWithFormat:@"%@%@",[NSString baseLoginURLPath],path];
    NSString *myurl=[NSString stringWithFormat:@"%@%@",[self.baseURL absoluteString],path];
    
    [self GET:myurl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            success(operation, responseObject);;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            NSLog(@"error==%@",[self showError:error]);
            ITOAST_BOTTOM(NSLocalizedString(@"networkerror", nil));
            failure(operation, error);;
        }
    }];

    
}
-(NSString *)showError:(NSError *)error{
    NSString *titleString = @"network Error:";
    NSString *messageString = [error localizedDescription];
    NSString *moreString = [error localizedFailureReason] ?
    [error localizedFailureReason]:NSLocalizedString(@"Try typing the URL again.", nil);
    messageString = [NSString stringWithFormat:@"%@. %@", messageString, moreString];
    return [NSString stringWithFormat:@"%@%@%@",titleString,messageString,moreString];
}
- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    AFHTTPRequestSerializer * requestSerializer = [AFHTTPRequestSerializer serializer];
    //requestSerializer.timeoutInterval=[NASaveData getTimeoutInterval];
    //requestSerializer.timeoutInterval=20;
    [requestSerializer setTimeoutInterval:30];
    AFHTTPResponseSerializer * responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *ua = @"Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25";
    [requestSerializer setValue:ua forHTTPHeaderField:@"User-Agent"];
    //    [requestSerializer setValue:@"application/xml" forHTTPHeaderField:@"Content-type"];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", nil];
    self.responseSerializer = responseSerializer;
    self.requestSerializer = requestSerializer;
    //NSString *myurl=[NSString stringWithFormat:@"%@%@",[NSString baseURLPath],path];
    [self POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            success(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            //NSLog(@"error==%@",[self showError:error]);
           
            failure(operation, error);;
        }
    }];

    
}

@end

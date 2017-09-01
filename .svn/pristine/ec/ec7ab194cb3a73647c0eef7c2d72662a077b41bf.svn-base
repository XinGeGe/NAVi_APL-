
#import "NALoginClient.h"

NSString * const kNALoginUserIdKey  = @"Userid";
NSString * const kNALoginPasswordKey = @"Pass";
NSString * const kNALoginUseDeviceKey   = @"UseDevice";
NSString * const kNALoginTimeStampKey   = @"timestamp";
NSInteger const MyStatus_success =1;
NSInteger const MyStatus_loginfail = 2;
NSInteger const MyStatus_fail =0;

@implementation NALoginClient

+ (NALoginClient *)sharedClient
{
    static NALoginClient *_sharedClient = nil;
    NSURL * url = [NSURL URLWithString:[NSString baseLoginURLPath]];
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

- (void)postLoginwithUserId:(NSString *)userId
               withPassword:(NSString *)password
            withDeviceModel:(NSString *)deviceModel
            completionBlock:(void(^)(NALoginModel *login, NSError *error))completion
{
    NSLog(@"Login start") ;
    
    NSString *now;
    if ([NASaveData isSaveTimeStamp]) {
        now = [NASaveData saveTimeStamp];
    }else {
        now = [NSString nowDate];
        [NASaveData saveTimeStamp:now];
    }
    if ([NACheckNetwork sharedInstance].isHavenetwork) {
    
            NSDictionary *param = @{
                                    kNALoginUserIdKey      : userId,
                                    kNALoginPasswordKey    : password,
                                    kNALoginUseDeviceKey   : deviceModel,
                                    kNALoginTimeStampKey   : @"20150311083937195",
                                    };
            [self postPath:[NSString loginPath] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
                SHXMLParser *parser = [[SHXMLParser alloc] init];
                NSDictionary *dic = [parser parseData:responseObject];
                NSDictionary *loginInfo = [dic objectForKey:@"response"];
                NALoginModel *loginModel = nil;
                if (loginInfo) {
                    loginModel = [[NALoginModel alloc] init];
                    loginModel.status = [loginInfo objectForKey:@"status"];
                    loginModel.userId = userId;
                    loginModel.password = password;
                    loginModel.timeStamp = now;
                    loginModel.userClass = [loginInfo objectForKey:@"UserClass"];
                
                }
                if (loginModel.status.integerValue == 1) {
                    [NASaveData saveIsVisitorModel:NO];
                    //save user
                    NSDictionary *alluserdic=[NASaveData getALLUser];
                    NSMutableDictionary *alldic;
                    if (alluserdic) {
                        NSDictionary *alluserdic=[NASaveData getALLUser];
                        NSDictionary *valuedic=[alluserdic objectForKey:loginModel.userId];
                        NSMutableDictionary *changevaluedic=[NSMutableDictionary dictionaryWithDictionary:valuedic];
                        [changevaluedic setObject:loginModel.password forKey:userpassword];
                        
                        NSMutableDictionary *changealluser=[NSMutableDictionary dictionaryWithDictionary:alluserdic];
                        [changealluser setObject:changevaluedic forKey:loginModel.userId];
                        [NASaveData saveALLUser:changealluser];
                    }else{
                        alldic=[[NSMutableDictionary alloc]init];
                        NSDictionary *valuedic=[NSDictionary dictionaryWithObjectsAndKeys:loginModel.password,userpassword,[NSNumber numberWithBool:NO],ishavenote, nil];
                        [alldic setValue:valuedic forKey:loginModel.userId];
                        [NASaveData saveALLUser:alldic];
                    }
                    
                      [self sendToken];
                }
                if (completion) {
                    completion (loginModel, nil);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (completion) {
                    completion(nil, error);
                }
                
            }];

        
   
    }else{
   
        NSDictionary *dic;
        if (dic==nil) {
            dic=[NASaveData getALLUser];
            
        }
        
        NALoginModel *loginModel = loginModel = [[NALoginModel alloc] init];
        loginModel.status=[NSNumber numberWithInteger:MyStatus_loginfail];
        NSDictionary *valuedic=[dic objectForKey:userId];
        NSString *pass=[valuedic objectForKey:userpassword];
        if (pass) {
            if ([pass isEqualToString:password]) {
                loginModel.status = [NSNumber numberWithInteger:MyStatus_success];
                loginModel.userId = userId;
                loginModel.password = password;
                loginModel.timeStamp = now;
                
            }
            if (loginModel.status.integerValue == 1){
                [NASaveData saveIsVisitorModel:NO];
            }
            if (loginModel.status.integerValue == 1&&![NASaveData getIsSendTokenSuccess]) {
                [self sendToken];
            }
        }else{
            loginModel.status=[NSNumber numberWithInteger:MyStatus_loginfail];
        }
        
        if (completion) {
            completion (loginModel, nil);
        }
   
    }
}
-(void)sendToken{
    if ([NASaveData getToken]==nil) {
        return;
    }
    NSDictionary *dic= @{
                         @"tokenId"     :  [NASaveData getToken],
                         @"osType"  :  @"ios"
                         };
    [[NASendTokeClient sharedClient]sendTokenWithParam:dic completionBlock:^(id response, NSError *error) {
        NSDictionary *rdic=(NSDictionary *)response;
        NSNumber *isSuccess=[rdic objectForKey:@"success"];
        if (isSuccess.boolValue) {
            [NASaveData saveIsSendTokenSuccess:YES];
        }
    }];
}
@end

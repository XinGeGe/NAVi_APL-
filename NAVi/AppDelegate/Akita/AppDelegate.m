
#import "AppDelegate.h"
#import "TAGContainer.h"
#import "TAGContainerOpener.h"
#import "TAGLogger.h"
#import "TAGManager.h"


@interface AppDelegate ()<TAGContainerOpenerNotifier>
@property(nonatomic, assign) BOOL okToWait;
@property(nonatomic, copy) void (^dispatchHandler)(TAGDispatchResult result);
@end

@implementation AppDelegate{
    NABaseNavigationController *navigation;
    NALoginAlertView *myalertview;
    BOOL isTempAutoLogin;
    BOOL isTempAllDownload;
    BOOL isMyAlertViewShow;
}

@synthesize tagManager = _tagManager;
@synthesize container = _container;
void UncaughtExceptionHandler(NSException *exception) {
    /**
     *  exception messge
     */
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *content = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[callStack componentsJoinedByString:@"\n"]];
    NSLog(@"%@",content);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //注册推送
    //clear badge
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    self.tagManager = [TAGManager instance];
    [self.tagManager.logger setLogLevel:kTAGLoggerLogLevelNone];
    self.tagManager.dispatchInterval=10;
    
    NSURL *url = [launchOptions valueForKey:UIApplicationLaunchOptionsURLKey];
    if (url != nil) {
        [self.tagManager previewWithUrl:url];
    }
    
    [TAGContainerOpener openContainerWithId:TagMangagerId
                                 tagManager:self.tagManager
                                   openType:kTAGOpenTypePreferFresh
                                    timeout:nil
                                   notifier:self];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [NAFileManager CopyFileToDocument:NAplist];
    [NASaveData saveIsPublication:NO];
    [self initTheplist];
    [[NASQLHelper sharedInstance] CreateMyPaperTable];
    [[NADownloadHelper sharedInstance] initTask];
    NAHomeViewController *topPage=[[NAHomeViewController alloc]init];
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:topPage];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
    isTempAutoLogin=[NASaveData isSaveUserInfo];
    isTempAllDownload=[NASaveData isAlldownload];
    
    [NASaveData saveIsVisitorModel:YES];
    
    [[NACheckNetwork sharedInstance]getTheNetworkCompletionBlock:^(BOOL isNetwork) {
        [NACheckNetwork sharedInstance].notCallBack=YES;
        if ([NACheckNetwork sharedInstance].isViaWWAN) {
            UIAlertViewWithBlock *alert= [[UIAlertViewWithBlock alloc] initWithTitle:@"" message:NSLocalizedString(@"not agreement", nil) cancelButtonTitle:@"いいえ" otherButtonTitles:@"はい", nil];
            [alert showWithDismissHandler:^(NSInteger selectedIndex) {
                switch (selectedIndex) {
                    case 1: {
                        [NACheckNetwork sharedInstance].isHavenetwork=YES;
                    } break;
                    case 0: {
                        [NACheckNetwork sharedInstance].isHavenetwork=NO;
                    } break;
                    default:
                        NSLog(@"case default:");
                        break;
                }
                
                
            }];

        }
        
        NSDictionary *dic=[NAFileManager ChangePlistTodic];
        NSString *version=[dic objectForKey:NAAGREEMENTVERSION];


        if([NASaveData getIsShowAgreeMent]&&(![[NASaveData agreeMentVersion]isEqualToString:version]||![NASaveData isAgreeMent]))
        {
            [self doLogin];

        }else{
            if (![NASaveData getIsShowAgreeMent]) {
                if ([NASaveData isLogin]) {
                    NAHomeViewController *topPage=[[NAHomeViewController alloc]init];
                    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:topPage];
                    [self.window setRootViewController:nav];
                    [self.window makeKeyAndVisible];
                }else{
                    [self doLogin];
                }
                
            }else{
                [self doLogin];
            }
            
        }
        
        
        
        UIImage *image = [UIImage imageNamed:@"bg_normal_header"];
        [[UINavigationBar appearance]  setBackgroundImage:image
                                            forBarMetrics:UIBarMetricsDefault];
        //[[UINavigationBar appearance]  setShadowImage:image];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        if ([NACheckNetwork sharedInstance].isHavenetwork) {
            [self ClearTheoldfile];
        }

    }];
    
    [self printAllFonts];
    return YES;
}
-(void)doLogin{
    if ([NASaveData isLogin]) {
        NAHomeViewController *topPage=[[NAHomeViewController alloc]init];
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:topPage];
        [self.window setRootViewController:nav];
        [self.window makeKeyAndVisible];
        [self getLoginAPIWithUsername:[NASaveData getLoginUserId] ThePassword:[NASaveData getLoginPassWord]];
    }else{
        NAHomeViewController *topPage=[[NAHomeViewController alloc]init];
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:topPage];
        [self.window setRootViewController:nav];
        [self.window makeKeyAndVisible];
    }

}
-(void)IAgree{
     NAHomeViewController *topPage=[[NAHomeViewController alloc]init];
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:topPage];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
}
-(void)loginClick:(NSString *)username Password:(NSString *)password{
   
    [self getLoginAPIWithUsername:username ThePassword:password];
}
-(void)switchDidChange:(BOOL)isAutoLogin TheAllDownload:(BOOL)isAllDownload{
    isTempAutoLogin=isAutoLogin;
    isTempAllDownload=isAllDownload;
}

-(void)cancelLoginClick{
    NAHomeViewController *topPage=[[NAHomeViewController alloc]init];
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:topPage];
    [self.loginViewController presentViewController:nav animated:YES completion:nil];
}
-(void)ClearTheoldfile{
    NSDictionary *dic=[NASaveData getALLUser];
    NSArray *myusersarray=[dic allKeys];
    for (NSInteger index=0; index<myusersarray.count; index++) {
        NSArray *notClearDateArray=[[NAFileManager sharedInstance]getNotClearFileDateArray:[myusersarray objectAtIndex:index]];
        [[NAFileManager sharedInstance] clearOldFileWithNotClearArray:notClearDateArray WithUserid:[myusersarray objectAtIndex:index]];
    }
}
- (void)containerAvailable:(TAGContainer *)container {
    // Important note: containerAvailable may be called from a different thread, marshall the
    // notification back to the main thread to avoid a race condition with viewDidAppear.
    dispatch_async(dispatch_get_main_queue(), ^{
        self.container = container;
        // Register two custom function call macros to the container.
    });
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    if ([self.tagManager previewWithUrl:url]) {
        return YES;
    }
    
    // Code to handle other urls.
    
    return NO;
}
// In case the app was sent into the background when there was no network connection, we will use
// the background data fetching mechanism to send any pending Google Analytics data.  Note that
// this app has turned on background data fetching in the capabilities section of the project.
-(void)application:(UIApplication *)application
performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self sendHitsInBackground];
    completionHandler(UIBackgroundFetchResultNewData);
}


// This method sends hits in the background until either we're told to stop background processing,
// we run into an error, or we run out of hits.
- (void)sendHitsInBackground {
    self.okToWait = YES;
    __weak AppDelegate *weakSelf = self;
    __block UIBackgroundTaskIdentifier backgroundTaskId =
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        weakSelf.okToWait = NO;
    }];
    
    if (backgroundTaskId == UIBackgroundTaskInvalid) {
        return;
    }
    
    self.dispatchHandler = ^(TAGDispatchResult result) {
        // If the last dispatch succeeded, and we're still OK to stay in the background then kick off
        // again.
        if (result == kTAGDispatchGood && weakSelf.okToWait ) {
            [[TAGManager instance] dispatchWithCompletionHandler:weakSelf.dispatchHandler];
        } else {
            [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskId];
        }
    };
    [[TAGManager instance] dispatchWithCompletionHandler:self.dispatchHandler];
}


-(void)initTheplist{
    NSDictionary *dic=[NAFileManager ChangePlistTodic];
    //[NASaveData saveUserInfo:autonum];
    NSNumber *allnum=[dic objectForKey:NALLDownloadKey];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"NAAlldownload"] == nil) {
        [NASaveData saveAlldownload:allnum];
    }
    
    NSNumber *fontnum=[dic objectForKey:NAFontnumkey];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"NAFRONTNUM"] == nil) {
        [NASaveData saveFontNum:fontnum.integerValue];
    }
    
    NSDictionary *changedic=[NAFileManager ChangePlistTodic];
    
    [NASaveData saveWuliaoPublicationInfoId:[dic objectForKey:NAWULIAOPUBLICATIONINFOID]];
    
    NSString *expansion_rate  =[[NSUserDefaults standardUserDefaults]objectForKey:@"Expansion_rate"];
    if (expansion_rate==nil) {
        [NASaveData saveExpansion_rate:[changedic objectForKey:[NSString stringWithFormat:@"%@%d",NAPapersize,fontnum.intValue]]];
    }
    
    NSString *fontsize=[dic objectForKey:NAFontsizekey];
    NSString *isfontsize  =[[NSUserDefaults standardUserDefaults]objectForKey:@"NAFRONTSIZE"];
    if (isfontsize==nil) {
        [NASaveData saveFontSize:fontsize];
    }
    
    NSString *spans=[dic objectForKey:NASpanskey];
    NSString *isspans =[[NSUserDefaults standardUserDefaults]objectForKey:@"Spans"];
    if (isspans==nil) {
        [NASaveData saveSpans:spans];
    }
    
    NSString *sokuhofontsize=[dic objectForKey:NASokuhoFontsizekey];
    NSString *isSokuhofontsize  =[[NSUserDefaults standardUserDefaults]objectForKey:@"NASOKUHOFRONTSIZE"];
    if (isSokuhofontsize==nil) {
        [NASaveData saveSokuhoFontSize:sokuhofontsize];
    }
    
    NSNumber *autologinnum=[dic objectForKey:NAAutologinkey];
    NSNumber *isautologinnum  =[[NSUserDefaults standardUserDefaults]objectForKey:@"NASaveUserInfo"];
    if (isautologinnum==nil) {
        [NASaveData saveUserInfo:autologinnum];
    }
    
    NSNumber *isShowHigh=[dic objectForKey:NAISSWIPEVIEWSHOWHIGHIMAGE];
    [NASaveData saveIsSwipeViewShowHighImage:isShowHigh];
    
    NSNumber *isHaveWeb=[dic objectForKey:NAISHAVEWEBBTN];
    [NASaveData saveIsHaveWebBtn:isHaveWeb];
    
    NSNumber *isHaveExtraImage=[dic objectForKey:NAISHAVEEXTRAIMAGE];
    [NASaveData saveIsHaveExtraImage:isHaveExtraImage];
    
    NSNumber *isSearchPage=[dic objectForKey:NAISSHOWSEARCHPAGE];
    [NASaveData saveIsShowSearchPage:isSearchPage];
    
    NSNumber *isHaveSearchNum=[dic objectForKey:NAISHAVESEARCHORDERNO];
    [NASaveData saveIsHaveSearchOrderNO:isHaveSearchNum];
    
    NSNumber *notClearDaysNum=[dic objectForKey:NANOTCLEARDAYSKEY];
    [NASaveData saveNotClearDays:notClearDaysNum];
    
    NSNumber *isShowAgreement=[dic objectForKey:NAISSHOWAGREEMENT];
    [NASaveData saveIsShowAgreeMent:isShowAgreement];
    
    NSString *infourl=[dic objectForKey:NAInformationUrlkey];
    [NASaveData InformationUrl:infourl];
    
    NSString *tokenUrl=[dic objectForKey:NASENDTOKENURL];
    [NASaveData saveSendTokenUrl:tokenUrl];
    
    NSString *kei=[dic objectForKey:NALandscapekeikey];
    [NASaveData saveLandscapekei:[NSNumber numberWithFloat:[kei floatValue]]];
    
    
    NSString *barin=[dic objectForKey:NABarShowIntervalkey];
    [NASaveData saveBarShowInterval:[NSNumber numberWithFloat:[barin floatValue]]];
    
     NSString *fastrows=[dic objectForKey:NAFastNewsRowskey];
    [NASaveData saveFastNewsRows:[NSNumber numberWithFloat:[fastrows floatValue]]];
    
    NSString *searchfastrows=[dic objectForKey:NASearchFastNewsRowskey];
    [NASaveData saveSearchFastNewsRows:[NSNumber numberWithFloat:[searchfastrows floatValue]]];
    

    NSString *webUrl=[dic objectForKey:NAWEBURL];
    [NASaveData saveWebUrl:webUrl];
    
    NSString *topUrl=[dic objectForKey:TOPURL];
    [NASaveData saveTopUrl:topUrl];
    
    NSString *extraUrl=[dic objectForKey:NAEXTRAURL];
    [NASaveData saveExtraUrl:extraUrl];
    
    NSString *defaultuserid=[dic objectForKey:NADEFAULTUSERID];
    [NASaveData saveDefaultUserID:defaultuserid];
//    if ([NASaveData getLoginUserId]==nil) {
//         [NASaveData saveUserId:defaultuserid];
//    }
    NSString *defaultuserPass=[dic objectForKey:NADEFAULTUSERPASS];
    [NASaveData saveDefaultUserPass:defaultuserPass];
    
    NSNumber *isUseCurrentDoc=[dic objectForKey:NAISUSECURRENTDOC];
   [NASaveData saveFastNewsTate:isUseCurrentDoc];
   
    
    NSNumber *detailTate=[dic objectForKey:NADetailTatekey];
    NSNumber *isdetailTate  =[[NSUserDefaults standardUserDefaults]objectForKey:@"detailTate"];
    if (isdetailTate==nil) {
        [NASaveData saveDetailTate:detailTate];
    }
    
    NSNumber *fastNewsTatekey=[dic objectForKey:NAFastNewsTatekey];
    NSNumber *isfastNewsTate  =[[NSUserDefaults standardUserDefaults]objectForKey:@"fastNewsTate"];
    if (isfastNewsTate==nil) {
        [NASaveData saveFastNewsTate:fastNewsTatekey];
    }
    
    NSNumber *firstdownloadkey=[dic objectForKey:NAFirstDownload];
    NSNumber *isfirstdownload  =[[NSUserDefaults standardUserDefaults]objectForKey:@"setting.firstDownload"];
    if (isfirstdownload==nil) {
        [NASaveData saveFirstDownload:firstdownloadkey];
    }
    
    NSNumber *fastNewskey=[dic objectForKey:NAISFastNewskey];
    NSNumber *isfastNewskey  =[[NSUserDefaults standardUserDefaults]objectForKey:@"sokuho.select.serviceFlg"];
    if (isfastNewskey==nil) {
        [NASaveData saveISFastNews:fastNewskey];
    }
    NSNumber *timeout=[dic objectForKey:NATimeoutIntervalkey];
    [NASaveData saveTimeoutInterval:timeout];
    
    NSString *isloginAndSearch=[dic objectForKey:NADataServerProtocol];
   [NASaveData saveDataServerProtocol:isloginAndSearch];
 
    
    NSString *isdownloadImage=[dic objectForKey:NAImageServerProtocol];
    [NASaveData saveImageServerProtocol:isdownloadImage];
 
}
-(void)registerTokeforiosEight{
     if  ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0) {
         if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
             UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
             [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
         }  else {
             UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
             [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
         }
         
     }else{
         [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
     }

}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"userInfo%@",userInfo);
    if(application.applicationState == UIApplicationStateActive){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                       delegate:self
                                              cancelButtonTitle:@"ok"
                                              otherButtonTitles:nil];
        //alert.tag=8887;
        [alert show];
    }

}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *token= [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //self.tokens = token;
    NSLog(@"devicetoken2=%@",token );
    [NASaveData saveToken:token];
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //注册远程通知
    [application registerForRemoteNotifications];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:NASAVETOKENKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self sendHitsInBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (isPad) {
        return UIInterfaceOrientationMaskAll;
    }else{
        return UIInterfaceOrientationMaskAll;
    }
    return 0;
}


- (void)getLoginAPIWithUsername:(NSString *)username ThePassword:(NSString *)password
{
    NSString *deviceModel = isPad ? @"N01" : @"N02";
    
//    [ProgressHUD show:NSLocalizedString(@"logininloading", nil)];
    
    [[NALoginClient sharedClient] postLoginwithUserId:username
                                         withPassword:password
                                      withDeviceModel:deviceModel
                                      completionBlock:^(NALoginModel *login, NSError *error) {
                                          
                                          if (error == nil) {
                                              if (login.status.integerValue == 1) {
                                                  [myalertview dismissMyview];
                                                  [NASaveData saveIsVisitorModel:NO];
                                                  [NASaveData SaveLoginWithID:login.userId withPassWord:login.password];
                                                  [NASaveData saveTimeStamp:login.timeStamp];
                                                  
                                                  [NASaveData saveUserInfo:[NSNumber numberWithBool:isTempAutoLogin]];
                                                  [NASaveData saveAlldownload:[NSNumber numberWithBool:isTempAllDownload]];
                                                  [NASaveData saveDataUserClass:login.userClass];

                                                  
                                              }else if (login.status.integerValue == 2) {
                                                  
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UserId or Password", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  
                                                  [ProgressHUD dismiss];
                                              }else if (login.status.integerValue == 3) {
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UserId", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }else if (login.status.integerValue == 4) {
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With Password", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }else if (login.status.integerValue == 5) {
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UseDevice", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }else if (login.status.integerValue == 6) {
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UseDevice nil", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }else{
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UseDevice nil", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }
                                              
                                          }else{
                                              ITOAST_BOTTOM(error.localizedDescription);
                                              [ProgressHUD dismiss];
                                              
                                          }
//                                          NASettingViewController *setvc = [[NASettingViewController alloc] init];
//                                          NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:setvc];
//                                          [self.loginViewController presentViewController:nav animated:NO completion:nil];
                                      }];
}

- (void)printAllFonts
{
    NSArray *fontFamilies = [UIFont familyNames];
    for (NSString *fontFamily in fontFamilies)
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:fontFamily];
        NSLog (@"%@: %@", fontFamily, fontNames);
    }
}

@end

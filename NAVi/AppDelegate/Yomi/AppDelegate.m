
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
    
    
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    self.tagManager = [TAGManager instance];
    
    // Modify the log level of the logger to print out not only
    // warning and error messages, but also verbose, debug, info messages.
    [self.tagManager.logger setLogLevel:kTAGLoggerLogLevelNone];
    //send the magager messages every the dispatchInterval
    self.tagManager.dispatchInterval=10;
    
    // Following provides ability to support preview from Tag Manager.
    // You need to make these calls before opening a container to make
    // preview works.
    NSURL *url = [launchOptions valueForKey:UIApplicationLaunchOptionsURLKey];
    if (url != nil) {
        [self.tagManager previewWithUrl:url];
    }
    
    // Open a container.
    [TAGContainerOpener openContainerWithId:TagMangagerId
                                 tagManager:self.tagManager
                                   openType:kTAGOpenTypePreferFresh
                                    timeout:nil
                                   notifier:self];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //self.loginViewController = [[NALoginViewController alloc] init];
    [NAFileManager CopyFileToDocument:NAplist];
    [self initTheplist];
    [[NASQLHelper sharedInstance] CreateMyPaperTable];
    [[NADownloadHelper sharedInstance] initTask];
    
     UIImageView *mylogoview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [Util screenSize].width, [Util screenSize].height)];
    if ([Util screenSize].width>[Util screenSize].height) {
        mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_1024_768.png"];
    }else{
        mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue.png"];
    }
    UIViewController *imagecontroller=[[UIViewController alloc]init];
    imagecontroller.view.frame=CGRectMake(0, 0, [Util screenSize].width, [Util screenSize].height);
    [imagecontroller.view addSubview:mylogoview];
    [self.window setRootViewController:imagecontroller];
    [self.window makeKeyAndVisible];
    [[NACheckNetwork sharedInstance]getTheNetworkCompletionBlock:^(BOOL isNetwork) {
        self.loginViewController=[[NALoginViewController alloc]init];
        if ([NASaveData isLogin]) {
            //navigation = [[NABaseNavigationController alloc] initWithRootViewController:self.loginViewController];
            [self.window setRootViewController:self.loginViewController];
            [self.window makeKeyAndVisible];
            //[[NAFileManager sharedInstance] deleteDetailInfo];
            [self getLoginAPI];
        }else{
//            NASettingViewController *naset = [[NASettingViewController alloc]init];
            NAHomeViewController *naset = [[NAHomeViewController alloc]init];
            naset.isfromWhere=@"login";
            NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:naset];
            //navigation = [[NABaseNavigationController alloc] initWithRootViewController:naset];
            [self.window setRootViewController:nav];
            [self.window makeKeyAndVisible];
            
            //[self.loginViewController presentViewController:nav animated:NO completion:nil];
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
    
    
    return YES;
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
    NSString *infourl=[dic objectForKey:NAInformationUrlkey];
    [NASaveData InformationUrl:infourl];
    
    NSString *kei=[dic objectForKey:NALandscapekeikey];
    [NASaveData saveLandscapekei:[NSNumber numberWithFloat:[kei floatValue]]];
    
    
    NSString *barin=[dic objectForKey:NABarShowIntervalkey];
    [NASaveData saveBarShowInterval:[NSNumber numberWithFloat:[barin floatValue]]];
    
     NSString *fastrows=[dic objectForKey:NAFastNewsRowskey];
    [NASaveData saveFastNewsRows:[NSNumber numberWithFloat:[fastrows floatValue]]];
    
    NSString *searchfastrows=[dic objectForKey:NASearchFastNewsRowskey];
    [NASaveData saveSearchFastNewsRows:[NSNumber numberWithFloat:[searchfastrows floatValue]]];
    
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
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"data.server.protocol"] == nil) {
        [NASaveData saveDataServerProtocol:isloginAndSearch];
    }
    
    NSString *isdownloadImage=[dic objectForKey:NAImageServerProtocol];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"image.server.protocol"] == nil) {
        [NASaveData saveImageServerProtocol:isdownloadImage];
    }

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

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (isPad) {
        return UIInterfaceOrientationMaskAll;
    }else{
        return UIInterfaceOrientationMaskAll;
    }
    return 0;
}
- (void)getLoginAPI
{
    NSString *deviceModel = isPad ? @"N01" : @"N02";
    
    [ProgressHUD show:NSLocalizedString(@"logininloading", nil)];
    
    [[NALoginClient sharedClient] postLoginwithUserId:[NASaveData getLoginUserId]
                                         withPassword:[NASaveData getLoginPassWord]
                                      withDeviceModel:deviceModel
                                      completionBlock:^(NALoginModel *login, NSError *error) {
                                          
                                          if (error == nil) {
                                              if (login.status.integerValue == 1) {
                                                  NAHomeViewController *home = [[NAHomeViewController alloc] init];
                                                  NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
                                                  [self.loginViewController presentViewController:nav animated:NO completion:nil];
                                                  return ;
                                                  //navigation = [[NABaseNavigationController alloc] initWithRootViewController:home];
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
                                          NASettingViewController *setvc = [[NASettingViewController alloc] init];
                                          NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:setvc];
                                          [self.loginViewController presentViewController:nav animated:NO completion:nil];
                                      }];
}

@end


#import "NALoginViewController.h"

@interface NALoginViewController ()

@property (nonatomic, strong) UIImageView *mylogoview;

@end

@implementation NALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = NSLocalizedString(@"NAVi", nil);
    _mylogoview=[[UIImageView alloc]initWithFrame:self.view.frame];
    _mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue.png"];
    [self.view addSubview:_mylogoview];
}
-(void)showLogin{
        myalertview=[[NALoginAlertView alloc]init];
        [myalertview setCancelBtnHidden];
//        isTempAutoLogin=myalertview.saveIDSwitch.isOn;
//        isTempAllDownload=myalertview.allDownloadSwitch.isOn;
        myalertview.delegate=self;
        myalertview.isBgToDismiss=NO;
        myalertview.isShowCancelBtn=NO;
        [myalertview show];
        
}
-(void)loginClick:(NSString *)username Password:(NSString *)password{
    
    [self getLoginAPIWithUsername:username ThePassword:password];
}
-(void)cancelLoginClick{
    
}
- (void)getLoginAPIWithUsername:(NSString *)username ThePassword:(NSString *)password
{
    NSString *deviceModel = isPad ? @"N01" : @"N02";
    
    [ProgressHUD show:NSLocalizedString(@"logininloading", nil)];
    
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
                                                  
                                                  //                                                  NAHomeViewController *home = [[NAHomeViewController alloc] init];
                                                  NATopPageUIViewController *topPage=[[NATopPageUIViewController alloc]init];
                                                  NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:topPage];
                                                  [self presentViewController:nav animated:NO completion:nil];
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
                                          //                                          NASettingViewController *setvc = [[NASettingViewController alloc] init];
                                          //                                          NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:setvc];
                                          //                                          [self.loginViewController presentViewController:nav animated:NO completion:nil];
                                      }];
}

-(void)switchDidChange:(BOOL)isAutoLogin TheAllDownload:(BOOL)isAllDownload{
    isTempAutoLogin=isAutoLogin;
    isTempAllDownload=isAllDownload;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self updateViews];
}

#pragma mark - Orientation
- (BOOL)shouldAutorotate {
    return YES;
}
#pragma mark - utility -
#pragma mark

- (void)initViews
{
    [super initViews];
    
}

- (void)updateViews
{
     self.mylogoview.frame=self.view.bounds;
    if ([self isLandscape]) {
        _mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_1024_768.png"];
    }else{
        _mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue.png"];
    }
}

- (BOOL)isLandscape
{
    return (isPad && (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft | self.interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}



@end

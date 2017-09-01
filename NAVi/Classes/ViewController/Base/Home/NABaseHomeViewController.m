
#import "NABaseHomeViewController.h"

#import "NAClipViewController.h"
#import "NASearchViewController.h"
#import "NASettingViewController.h"
#import "NADownLoadImageClient.h"
#import "NASubImageScrollView.h"
#import "NADayJournalViewController.h"
#import "NANewsViewController.h"
#import "NAPublicationViewController.h"
#import "NANoteListViewController.h"
#import "NADetailViewController.h"
#import "NATopPageUIViewController.h"
#import "NANoteListViewController.h"
#import "NADeatilSelectedAlertView.h"
#import "NALoginReminAlertView.h"
#import "NANewDayJournalViewController.h"
#import "NANewSearchViewController.h"
#import "NANewSettingViewController.h"
#import "YJDatePickerView.h"
#import "JXButton.h"
#import "FontUtil.h"
#import "DateUtil.h"
#import "NADetailBaseViewController.h"
@interface NABaseHomeViewController () <SwipeViewDataSource, SwipeViewDelegate, UIScrollViewDelegate,NADeatilSelectedAlertViewDelegate,YJDatePickerDelegate>{
    NALoginAlertView *myalertview;
    NALoginReminAlertView *remindView;
    BOOL isTempAutoLogin;
    BOOL isTempAllDownload;
    NADeatilSelectedAlertView *detailSelectView;
    BOOL detailCancel;
    UIView *btnView;
    UIButton *localBtn;
    YJDatePickerView *localPickView;
    NSInteger isChooseDay;
    NSArray *regionArr;
    NSArray *regionArr2;
    UIView *btnView2;
    UIButton *localBtn2;
    YJDatePickerView *localPickView2;
    NSInteger local1;
    NSInteger local2;
    NSMutableArray *localPageArr;//可切换的纸面
    NSInteger changeNo;
    NSInteger isHaveRegion;//是否有地域版
}
@end

@implementation NABaseHomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchPublicationArray = [NSMutableArray array];
//    _NotePageArray = [[NSMutableDictionary alloc]init];
    self.pageArray = [NSMutableArray array];
    localPageArr = [NSMutableArray array];
    regionArr = [[NSArray alloc]init];
    regionArr2 = [[NSArray alloc]init];

    [self showLogo];
    firstDownloadNum = 5;
    isAllDownload=[NASaveData isAlldownload];
    isTempAutoLogin=[NASaveData isSaveUserInfo];
    isTempAllDownload=[NASaveData isAlldownload];

    if (_homePageArray.count != 0 && _dayNumber ==0) {
        self.pageArray = _homePageArray;
        [self showMainView];
        //[self getNoteAPI];
    }else if (_homePageArray.count != 0 && _dayNumber ==1) {
//        if (_regionFlg == 1) {
            [self searchCurrentApi:_dayDoc  ByUserid:[NASaveData getDefaultUserID]];
//        }else{
//            [self searchCurrentApiNoRegion:_dayDoc  ByUserid:[NASaveData getDefaultUserID]];
//        }
        
    }else{
        [self getmasterAPI:[NASaveData getDefaultUserID]];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUser) name:@"changeUser" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateMymodel:) name:@"UpdateMymodel" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getListselectindex:) name:@"getListselectindex" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singleClickNoty) name:@"singleClickNoty" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doubleClickNoty) name:@"doubleClickNoty" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawFirstnote) name:NOTYDrawFirstnote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toSerachLastNewsList) name:NOTYReloadPage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noteChanged:) name:NOTYNOTECHANGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toPublicationViewController) name:NOTYToPublicationViewController object:nil];
    
    isHavenet=[NACheckNetwork sharedInstance].isHavenetwork;
    //mytimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    //[mytimer fire];
    //myhidebartimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerHidebarFired) userInfo:nil repeats:YES];
    
    UIImage *image = [UIImage imageNamed:@"bg_navigation_header"];
    [self.navigationController.navigationBar  setBackgroundImage:image
                                                   forBarMetrics:UIBarMetricsDefault];
    
    //地方版
    btnView = [[UIView alloc]init];
    [self.view addSubview:btnView];
    if (isPhone) {
        [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_right).offset(-5);
            make.bottom.equalTo(self.view.mas_bottom).offset(-50);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(30);
        }];
    }else{
        [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_right).offset(-5);
            make.bottom.equalTo(self.view.mas_bottom).offset(-60);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(30);
        }];
    }
    btnView.backgroundColor = [UIColor whiteColor];
    btnView.layer.cornerRadius = 5;
    btnView.layer.masksToBounds = YES;
    
    localBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnView addSubview:localBtn];
    [localBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btnView.mas_right).offset(-2);
        make.left.equalTo(btnView.mas_left).offset(2);
        make.top.equalTo(btnView.mas_top).offset(2);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(26);
    }];
    localBtn.layer.cornerRadius = 5;
    localBtn.layer.masksToBounds = YES;
    //[localBtn setTitle:@"地方版 北海道" forState:UIControlStateNormal];
    [localBtn.titleLabel setFont:[FontUtil systemFontOfSize:13]];
    localBtn.backgroundColor = [UIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:250.0/255.0 alpha:1];
    [localBtn addTarget:self action:@selector(chooseLocal) forControlEvents:UIControlEventTouchUpInside];
    btnView.hidden = YES;
    localBtn.hidden = YES;
    _toolBarStyle = 0;
    [self setRiliview];
    
    btnView2 = [[UIView alloc]init];
    [self.view addSubview:btnView2];
    if (isPhone) {
        [btnView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(self.view.frame.size.width/2-120);
            make.bottom.equalTo(self.view.mas_bottom).offset(-50);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(30);
        }];
    }else{
        [btnView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(self.view.frame.size.width/2-120);
            make.bottom.equalTo(self.view.mas_bottom).offset(-60);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(30);
        }];
    }
    btnView2.backgroundColor = [UIColor whiteColor];
    btnView2.layer.cornerRadius = 5;
    btnView2.layer.masksToBounds = YES;
    
    localBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnView2 addSubview:localBtn2];
    [localBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btnView2.mas_right).offset(-2);
        make.left.equalTo(btnView2.mas_left).offset(2);
        make.top.equalTo(btnView2.mas_top).offset(2);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(26);
    }];
    localBtn2.layer.cornerRadius = 5;
    localBtn2.layer.masksToBounds = YES;
    //[localBtn setTitle:@"地方版 北海道" forState:UIControlStateNormal];
    [localBtn2.titleLabel setFont:[FontUtil systemFontOfSize:13]];
    localBtn2.backgroundColor = [UIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:250.0/255.0 alpha:1];
    [localBtn2 addTarget:self action:@selector(chooseLocal2) forControlEvents:UIControlEventTouchUpInside];
    btnView2.hidden = YES;
    localBtn2.hidden = YES;
}
- (void)chooseLocal2{
    if ([self isLogin]) {
        localPickView2 = [YJDatePickerView pickCustomDataWithArray:regionArr2 completionHandle:^(NSInteger index, id  _Nullable value) {
            NSLog(@"block: index :%ld, %@", (long)index, value);
            [localBtn2 setTitle:[NSString stringWithFormat:@"地方版%@",value] forState:UIControlStateNormal];
        }];
        localPickView2.delegate = self;
    }else{
        [self notLoginAction];
    }
    
}
- (void)chooseLocal{
    if ([self isLogin]) {
        localPickView = [YJDatePickerView pickCustomDataWithArray:regionArr completionHandle:^(NSInteger index, id  _Nullable value) {
            NSLog(@"block: index :%ld, %@", (long)index, value);
            [localBtn setTitle:[NSString stringWithFormat:@"地方版%@",value] forState:UIControlStateNormal];
        }];
        localPickView.delegate = self;
    }else{
        [self notLoginAction];
    }
    
}
- (void)selectedData:(NSString *_Nullable)pageNo doc:(NADoc * _Nullable )doc{
    NSLog(@"%@",pageNo);
    for (int i = 0;i< self.pageArray.count ;i++) {
        NADoc *doc2 = [self.pageArray objectAtIndex:i];
        if ([doc2.pageno isEqualToString:doc.pageno]) {
            [self.pageArray replaceObjectAtIndex:i withObject:doc];
            if ([self isLandscape]) {
                changeNo = i-1;
            }else{
                changeNo = self.pageArray.count -i-1;
            }
        }
        
    }
    self.mainScrollView.currentItemIndex = changeNo;
    [self.mainScrollView scrollToItemAtIndex: changeNo duration:0.1];
    // 後処理
    [self swipeViewCurrentItemIndexDidChange:self.mainScrollView];
    [self swipeViewDidEndDecelerating:self.mainScrollView];
}
//媒体選択
- (void)chooseDay{
    [detailSelectView dismissMyview];
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    if (![NACheckNetwork sharedInstance].isHavenetwork) {
        
        [[[iToast makeText:NSLocalizedString(@"networkerror", @"")]
          setGravity:iToastGravityBottom] show];
        return;
    }
    if (self.pageArray.count ==0) {
        
    }else{
        if ([self isLogin]) {
            if ([[NASaveData getDataUserClass] isEqualToString:@"10"]) {
                NANewDayJournalViewController *day = [[NANewDayJournalViewController alloc] init];
                day.currDoc = self.pageArray[0];
                day.regionDic = _regionDic;
                day.selectedDocCompletionBlock = ^(NADoc *doc) {
                    [NASaveData saveIsPublication:NO];
                    [self controlTheBlockWithdoc:doc];
                };
                day.selectedIsHaveRegionBlock = ^(NSInteger isHaveRegion2){
                    isHaveRegion = isHaveRegion2;
                };
                NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:day];
                [self presentViewController:nav animated:YES completion:^{
                    [[NADownloadHelper sharedInstance] stopNoty];
                }];
                // GA(tag manager)
                [TAGManagerUtil pushButtonClickEvent:ENDateListBtn label:[self getLabelName]];
            }else if([[NASaveData getDataUserClass] isEqualToString:@"11"]){
                [self notLoginAction];
            }else{
                [self notLoginAction];
            }

        }else{
            [self notLoginAction];
        }
    }
}

-(void)noteChanged:(NSNotification *)noty{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    NSNumber *myCurrent=[noty object];
    NSInteger tempPageIndex = 0;
    
    if ([self isLandscape]) {    // 後処理
        NSArray *pages = [self padLandscapeCount];
        if (pages.count > 0) {
            tempPageIndex = [self currentIndex:myCurrent.integerValue];
            tempPageIndex = pages.count - 1 - tempPageIndex;
        }
        
    }else{
        if (self.pageArray.count > 0) {
            tempPageIndex=self.pageArray.count - 1 - myCurrent.integerValue;
        }
    }
    
    // 第１面を表示
    self.mainScrollView.currentItemIndex = tempPageIndex;
    [self.mainScrollView scrollToItemAtIndex: tempPageIndex duration:0.1];
    
    
    
    // 後処理
    [self swipeViewCurrentItemIndexDidChange:self.mainScrollView];
    [self swipeViewDidEndDecelerating:self.mainScrollView];
}
-(void)drawFirstnote{
    [self swipeViewDidEndDecelerating:self.mainScrollView];
}
-(void)singleClickNoty{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    [UIView animateWithDuration:0.5 animations:^{
        [self.homeToolBar setHidden:!self.homeToolBar.hidden];
        if ( detailCancel == YES) {
            _toolBarStyle = 0;
            if ([self isLandscape]) {
                [self setHorToolBar];
            }else{
                [self resetHomeToolBar];
            }
        }
    } completion:^(BOOL finished) {
        
    }];
    
    if (self.homeToolBar.hidden == NO) {
        if (self.progressViewBar.progressData.progress != 1.0f) {
            [self.progressViewBar setHidden:NO];
        }
        currentdate=nil;
        _toolBarStyle = 0;
        if ([self isLandscape]) {
            [self setHorToolBar];
        }else{
            [self resetHomeToolBar];
        }
        if (local1 == 1) {
            btnView.hidden = NO;
            localBtn.hidden = NO;
        }else{
            btnView.hidden = YES;
            localBtn.hidden = YES;
        }
        if (local2 == 1) {
            btnView2.hidden = NO;
            localBtn2.hidden = NO;
        }else{
            btnView2.hidden = YES;
            localBtn2.hidden = YES;
        }
    } else {
        [self.progressViewBar setHidden:YES];
        _toolBarStyle = 0;
        if ([self isLandscape]) {
            [self setHorToolBar];
        }else{
            [self resetHomeToolBar];
        }
        if (local1 == 1) {
            btnView.hidden = NO;
            localBtn.hidden = NO;
        }else{
            btnView.hidden = YES;
            localBtn.hidden = YES;
        }
        if (local2 == 1) {
            btnView2.hidden = NO;
            localBtn2.hidden = NO;
        }else{
            btnView2.hidden = YES;
            localBtn2.hidden = YES;
        }
    }
}

-(void)doubleClickNoty{
    btnView.hidden = YES;
    localBtn.hidden = YES;
    btnView2.hidden = YES;
    localBtn2.hidden = YES;
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    NASubImageScrollView *view = (NASubImageScrollView *)[self.mainScrollView itemViewAtIndex:self.mainScrollView.currentItemIndex];
    [self scrollViewDidEndZooming:view withView:view atScale:1];
    if (view.indexHaveOrNo == 0) {
        _toolBarStyle = 2;
    }else{
        _toolBarStyle = 0;
    }
    if ([self isLandscape]) {
        [self setHorToolBar];
    }else{
        [self resetHomeToolBar];
    }
    
}
-(void)notLoginAction{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    remindView=[[NALoginReminAlertView alloc]init];
    NSString *str =[NASaveData getDataUserClass];
    if ([str isEqualToString:@"10"]) {
        remindView.haveJurisdiction = 0;
    }else if([str isEqualToString:@"11"]){
        remindView.haveJurisdiction = 1;
    }else{
        remindView.haveJurisdiction = 0;
    }
    remindView.delegate=self;
    [remindView show];
}
-(BOOL)isLogin{
    if(![NASaveData getIsVisitorModel]){
        if ([NASaveData isSaveUserInfo]) {
            NSString *str =[NASaveData getDataUserClass];
            if ([str isEqualToString:@"10"]) {
                return YES;
            }
            return YES;
        }else{
            return NO;
        }
        
    }else{
        return NO;
    }
    
}

#pragma mark - NALoginReminAlertViewDelegate delegate -
#pragma mark
-(void)loginClick{
    [remindView dismissMyview];
    myalertview=[[NALoginAlertView alloc]init];
    myalertview.delegate=self;
    [myalertview show];
    isAllDownload = YES;
    isTempAutoLogin = YES;
}
-(void)cancelAction{

}
#pragma mark - NALoginAlertView delegate -
#pragma mark
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
                                                  [NASaveData saveUserInfo:[NSNumber numberWithBool:isTempAutoLogin]];
                                                  [NASaveData saveAlldownload:[NSNumber numberWithBool:isTempAllDownload]];
                                                  [NASaveData SaveLoginWithID:login.userId withPassWord:login.password];
                                                  [NASaveData saveTimeStamp:login.timeStamp];
                                                  [ProgressHUD dismiss];
                                                  self.mainScrollView.wrapEnabled = YES;
                                                  self.mainScrollView.scrollEnabled = YES;
                                                  [NASaveData saveDataUserClass:login.userClass];
                                                  if ([self isLandscape]) {
                                                      _riliView.hidden = YES;
                                                      [self setHorToolBar];
                                                  }else{
                                                      [self resetRiliview];
                                                      [self resetHomeToolBar];
                                                      _riliView.hidden = NO;
                                                  }
                                                  if ([self isLogin]) {
                                                      [_btnChooseDay setImage:[UIImage imageNamed:@"08_blue"] forState:UIControlStateNormal];
                                                  }else{
                                                      [_btnChooseDay setImage:[UIImage imageNamed:@"08_glay"] forState:UIControlStateNormal];
                                                  }
                                                  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                                                  if ([self isLogin]) {
                                                      [button setBackgroundImage:[UIImage imageNamed:@"06_blue"]
                                                                        forState:UIControlStateNormal];
                                                  }else{
                                                      [button setBackgroundImage:[UIImage imageNamed:@"06_glay"]
                                                                        forState:UIControlStateNormal];
                                                  }
                                                  [button addTarget:self action:@selector(searchBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
                                                  button.frame = CGRectMake(0, 0, 25, 25);
                                                  _searchBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
                                                self.navigationItem.leftBarButtonItem = _searchBarItem;
                                              }else if (login.status.integerValue == 2) {
                                                  self.mainScrollView.wrapEnabled = NO;
                                                  self.mainScrollView.scrollEnabled = NO;
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UserId or Password", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                              }else if (login.status.integerValue == 3) {
                                                  self.mainScrollView.wrapEnabled = NO;
                                                  self.mainScrollView.scrollEnabled = NO;
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UserId", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }else if (login.status.integerValue == 4) {
                                                  self.mainScrollView.wrapEnabled = NO;
                                                  self.mainScrollView.scrollEnabled = NO;
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With Password", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }else if (login.status.integerValue == 5) {
                                                  self.mainScrollView.wrapEnabled = NO;
                                                  self.mainScrollView.scrollEnabled = NO;
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UseDevice", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }else if (login.status.integerValue == 6) {
                                                  self.mainScrollView.wrapEnabled = NO;
                                                  self.mainScrollView.scrollEnabled = NO;
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UseDevice nil", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }else{
                                                  self.mainScrollView.wrapEnabled = NO;
                                                  self.mainScrollView.scrollEnabled = NO;
                                                  [[[iToast makeText:NSLocalizedString(@"Login Error With UseDevice nil", nil)]
                                                    setGravity:iToastGravityBottom] show];
                                                  [ProgressHUD dismiss];
                                                  
                                              }
                                              
                                          }else{
                                              self.mainScrollView.wrapEnabled = NO;
                                              self.mainScrollView.scrollEnabled = NO;
                                              ITOAST_BOTTOM(error.localizedDescription);
                                              [ProgressHUD dismiss];
                                              
                                          }
                                          
                                      }];
}


//-(void)timerFired{
//    
//    if (isHavenet==NO&[NACheckNetwork sharedInstance].isHavenetwork==YES) {
//        
//        [ProgressHUD show:NSLocalizedString(@"networkok", @"")];
//        [self refreshBarItemAction];
//    }
//    isHavenet=[NACheckNetwork sharedInstance].isHavenetwork;
//}
//-(void)timerHidebarFired{
//    if (currentdate) {
//        if ([Util getTimeDvalue:currentdate Date2:[NSDate date]]>=[NASaveData getBarShowInterval]) {
//            [UIView animateWithDuration:0.5 animations:^{
//                [self.homeToolBar setHidden:YES];
//                [self.progressViewBar setHidden:YES];
//            } completion:^(BOOL finished) {
//                
//            }];
//            //pasue timer
//            [myhidebartimer setFireDate:[NSDate distantFuture]];
//            currentdate=nil;
//        }
//    }
//}
-(void)getListselectindex:(NSNotification *)notify
{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    NSDictionary *dic=[notify userInfo];
    NSString *noteIndexNo=[dic objectForKey:@"noteIndexNo"];
    NSString *paperIndexNo=[dic objectForKey:@"paperIndexNo"];
    if (paperIndexNo) {
        NSInteger docIndex;
        for (docIndex = 0; docIndex < self.pageArray.count; docIndex++) {
            if ([paperIndexNo isEqualToString:((NADoc *)self.pageArray[docIndex]).indexNo]) {
                break;
            }
        }
        
        double delayInSeconds = 0.0;
        if ([self isLandscape]) {
            NSArray *array = [self padLandscapeCount];
            NSInteger index = [self currentIndex:docIndex];
            
            if (index != array.count - 1 - self.mainScrollView.currentItemIndex) {
                [self.mainScrollView scrollToPage:(array.count - 1 - index) duration:0];
                [self swipeViewDidEndDecelerating:self.mainScrollView];
                delayInSeconds = 0.5;
            }
            
        }else{
            if (docIndex != self.pageArray.count - 1 - self.mainScrollView.currentItemIndex) {
                [self.mainScrollView scrollToPage:(self.pageArray.count - 1 - docIndex) duration:0];
                [self swipeViewDidEndDecelerating:self.mainScrollView];
                delayInSeconds = 0.3;
            }
        }
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NASubImageScrollView *imageScroll=(NASubImageScrollView *)self.mainScrollView.currentItemView;
            CGRect noteRect = [imageScroll showNoteViewByIndexNo:noteIndexNo];
            [imageScroll moveWithNote:noteRect];
        });
        
    } else {
        NASubImageScrollView *imageScroll=(NASubImageScrollView *)self.mainScrollView.currentItemView;
        CGRect noteRect = [imageScroll showNoteViewByIndexNo:noteIndexNo];
        [imageScroll moveWithNote:noteRect];
    }
}
-(void)showLogo{
    _mylogoview=[[UIImageView alloc]initWithFrame:self.view.frame];
    if ([Util screenSize].width>[Util screenSize].height) {
        if(isPad){
            _mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_1024_768.png"];
        }else{
            _mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_667.png"];
        }
        
    }else{
        _mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue.png"];
    }
    
    [self.view insertSubview:_mylogoview aboveSubview:self.mainScrollView];
}
-(void)changeUser{
    [self showLogo];
//    if (![[ProgressHUD shared] isShowing]) {
//        [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
//    }
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    self.searchPublicationArray = [NSMutableArray array];
    [self getmasterAPI:[NASaveData getDefaultUserID]];
    
    [self updateViews];
    
    [NASaveData saveIsPublication:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    // 紙面情報を編集
//    if (![self isLandscape]) {
//        self.orientationPageIndex = self.pageArray.count - 1 - self.mainScrollView.currentItemIndex;
//    } else {
//        self.orientationPageIndex = [[self padLandscapeCount] count] - 1 - self.mainScrollView.currentItemIndex;
//    }
//    
//    //    NSLog(@"willRotateToInterfaceOrientation %d", toInterfaceOrientation);
//    
//    NASubImageScrollView *view=(NASubImageScrollView *)self.mainScrollView.currentItemView;
//    //    curNoteIndexNo = view.imageView.noteView.curNoteIndexNo;
//    curPaperIndexNo = view.imageView.noteView.curPaperIndexNo;
//    
//    [self.mainScrollView removeFromSuperview];
//    _mainScrollView = nil;
//    _mainScrollView = self.mainScrollView;
//
//    
//    if (!self.presentedViewController && [[ProgressHUD shared] isShowing]) {
//        return;
//    }
//    
//    
//    isChangeScreen=YES;
//    
//    
//    [self.view addSubview:self.mainScrollView];
//    [self.view sendSubviewToBack:self.mainScrollView];
//    
//    NSInteger tempPageIndex = 0;
//    _toolBarStyle = 0;
//    if ([self isLandscape]) {    // 後処理
//        NSArray *pages = [self padLandscapeCount];
//        if (pages.count > 0) {
//            tempPageIndex = [self currentIndex:self.orientationPageIndex];
//            tempPageIndex = pages.count - 1 - tempPageIndex;
//        }
//        _riliView.hidden = YES;
//        [self setHorToolBar];
//    }else{
//        [self resetRiliview];
//        [self resetHomeToolBar];
//        _riliView.hidden = NO;
//        
//        // 1紙面を表示
//        if (self.pageArray.count > 0) {
//            tempPageIndex = [self currentIndexInPages:self.orientationPageIndex curPagerIndexNo:curPaperIndexNo];
//            tempPageIndex = self.pageArray.count - 1 - tempPageIndex;
//            
//        }
//    }
//    if ([self isLogin]) {
//        if (self.pageArray.count == 1) {
//            self.mainScrollView.wrapEnabled = NO;
//            self.mainScrollView.scrollEnabled = NO;
//        }
//    }else{
//        self.mainScrollView.wrapEnabled = NO;
//        self.mainScrollView.scrollEnabled = NO;
//    }
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    if ([self isLogin]) {
//        [button setBackgroundImage:[UIImage imageNamed:@"06_blue"]
//                          forState:UIControlStateNormal];
//    }else{
//        [button setBackgroundImage:[UIImage imageNamed:@"06_glay"]
//                          forState:UIControlStateNormal];
//    }
//    [button addTarget:self action:@selector(searchBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(0, 0, 25, 25);
//    self.searchBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.leftBarButtonItem = self.searchBarItem;
//    // 第１面を表示
//    self.mainScrollView.currentItemIndex = tempPageIndex;
//    [self.mainScrollView scrollToItemAtIndex: tempPageIndex duration:0.3];
//    
//    // 後処理
//    [self swipeViewCurrentItemIndexDidChange:self.mainScrollView];
//    
//    
//    
//    
//    
//    
    [[NADownloadHelper sharedInstance] startNoty];
    isHavenet=[NACheckNetwork sharedInstance].isHavenetwork;
    NASubImageScrollView *imageScroll = (NASubImageScrollView *)self.mainScrollView.currentItemView;
    
    NSString *myratestr=[NASaveData getExpansion_rate];
    NSArray *ratearray=[myratestr componentsSeparatedByString:@","];
    imageScroll.minimumZoomScale = [[ratearray objectAtIndex:0]floatValue];
    if ([self isLandscape]) {
        _riliView.hidden = YES;
        [self setHorToolBar];
        imageScroll.maximumZoomScale = [[ratearray objectAtIndex:3]floatValue]*[NASaveData getLandscapekei];
    }else{
        [self resetRiliview];
        _riliView.hidden = NO;
        [self resetHomeToolBar];
        imageScroll.maximumZoomScale = [[ratearray objectAtIndex:3]floatValue];
    }
    
    MAIN(^{
        if ([NASaveData isAlldownload]&&!isDoneImageTask) {
            [self.progressViewBar setHidden:NO];
        }else{
            [self.progressViewBar setHidden:YES];
        }
    });
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self updateViews];
}

/**
 * 画面回転の前処理
 *
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [remindView dismissMyview];
    [myalertview dismissMyview];
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    [self.popoverBackground hidePopoverView];
    if (self.oldToInterfaceOrientation == toInterfaceOrientation) {
        return;
    }
    self.oldToInterfaceOrientation = toInterfaceOrientation;
    
    if (!self.presentedViewController && [[ProgressHUD shared] isShowing]) {
        return;
    }
    _toolBarStyle = 0;
    // 紙面情報を編集
    if (![self isLandscape]) {
        self.orientationPageIndex = self.pageArray.count - 1 - self.mainScrollView.currentItemIndex;
    } else {
        self.orientationPageIndex = [[self padLandscapeCount] count] - 1 - self.mainScrollView.currentItemIndex;
    }
    
    //    NSLog(@"willRotateToInterfaceOrientation %d", toInterfaceOrientation);
    
    NASubImageScrollView *view=(NASubImageScrollView *)self.mainScrollView.currentItemView;
    //    curNoteIndexNo = view.imageView.noteView.curNoteIndexNo;
    curPaperIndexNo = view.imageView.noteView.curPaperIndexNo;
    
    [self.mainScrollView removeFromSuperview];
    _mainScrollView = nil;
    _mainScrollView = self.mainScrollView;
   
}

/**
 * 画面回転の後処理
 *
 */
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [remindView dismissMyview];
    [myalertview dismissMyview];
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    [self.popoverBackground hidePopoverView];
    if (self.oldFromInterfaceOrientation == fromInterfaceOrientation) {
        // 後処理
        if (self.presentedViewController || ![[ProgressHUD shared] isShowing]) {
            [self swipeViewDidEndDecelerating:self.mainScrollView];
            [self swipeViewCurrentItemIndexDidChange:self.mainScrollView];
        }
        
        return;
    }
    
    
    
    self.oldFromInterfaceOrientation = fromInterfaceOrientation;
    
    if (!self.presentedViewController && [[ProgressHUD shared] isShowing]) {
        return;
    }
    
    
    isChangeScreen=YES;
  
        
        [self.view addSubview:self.mainScrollView];
        [self.view sendSubviewToBack:self.mainScrollView];
        
        NSInteger tempPageIndex = 0;
        _toolBarStyle = 0;
        if ([self isLandscape]) {    // 後処理
            NSArray *pages = [self padLandscapeCount];
            if (pages.count > 0) {
                tempPageIndex = [self currentIndex:self.orientationPageIndex];
                tempPageIndex = pages.count - 1 - tempPageIndex;
            }
            _riliView.hidden = YES;
            [self setHorToolBar];
        }else{
            [self resetRiliview];
            [self resetHomeToolBar];
            _riliView.hidden = NO;
            
            // 1紙面を表示
            if (self.pageArray.count > 0) {
                tempPageIndex = [self currentIndexInPages:self.orientationPageIndex curPagerIndexNo:curPaperIndexNo];
                tempPageIndex = self.pageArray.count - 1 - tempPageIndex;
                
            }
        }
    if ([self isLogin]) {
        if (self.pageArray.count == 1) {
            self.mainScrollView.wrapEnabled = NO;
            self.mainScrollView.scrollEnabled = NO;
        }
    }else{
        self.mainScrollView.wrapEnabled = NO;
        self.mainScrollView.scrollEnabled = NO;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([self isLogin]) {
        [button setBackgroundImage:[UIImage imageNamed:@"06_blue"]
                          forState:UIControlStateNormal];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"06_glay"]
                          forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(searchBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 25, 25);
    self.searchBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = self.searchBarItem;
    // 第１面を表示
    self.mainScrollView.currentItemIndex = tempPageIndex;
    [self.mainScrollView scrollToItemAtIndex: tempPageIndex duration:0.3];
    
    // 後処理
    [self swipeViewCurrentItemIndexDidChange:self.mainScrollView];
 
    
    
}
- (void)getItemView:(UIView *)view forIndex:(NSInteger)index{
    
    // 後処理
    //[self swipeViewCurrentItemIndexDidChange:self.mainScrollView];
    [self swipeViewDidEndDecelerating:self.mainScrollView];
    
    
}
- (void)swipeViewDidEndScrollingAnimation:(SwipeView *)swipeView{
    MAIN(^{
        self.mainScrollView.hidden=NO;
        [ProgressHUD dismiss];
        [self.mylogoview removeFromSuperview];
    });
    
}
#pragma mark - layout -
#pragma markf
/**
 * homeToolBar初期化（ツールbar）
 *
 */
- (NAHomeToobar *)homeToolBar
{
    if (!_homeToolBar) {
        _homeToolBar = [[NAHomeToobar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - TOOLBAR_HEIGHT, self.view.frame.size.width, TOOLBAR_HEIGHT)];
        _homeToolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _homeToolBar.homeBarDelegate = self;
        _homeToolBar.barTintColor = BaseToolBarColor;
        _homeToolBar.hidden=NO;
    }
    return _homeToolBar;
}

/**
 * progressViewBar初期化
 *
 */
-(UIView *)progressViewBar
{
    if(!_progressViewBar)
    {
        _progressViewBar= [[NAHomeProgressView alloc]initWithFrame:CGRectZero];
        _progressViewBar.hidden=NO;
    }
    return _progressViewBar;
}

/**
 * rightCustomView初期化
 *
 */
- (UIView *)rightCustomView
{
    if (!_rightCustomView) {
        _rightCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
    }
    return _rightCustomView;
}
/**
 * popoverBackground初期化（ペッジ一覧用view）
 *
 */
- (NAPopoverBackgroundView *)popoverBackground
{
    if (!_popoverBackground) {
        //        _popoverBackground = [[NAPopoverBackgroundView alloc] initWithFrame:CGRectZero];
        _popoverBackground = [[NAPopoverBackgroundView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _popoverBackground.delegate = self;
    }
    return _popoverBackground;
}
/**
 * mainScrollView初期化（紙面表示用view）
 *
 */
- (SwipeView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[SwipeView alloc] initWithFrame:CGRectZero];
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.alignment = SwipeViewAlignmentCenter;
        _mainScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.wrapEnabled = YES;
        _mainScrollView.itemsPerPage = 1;
        _mainScrollView.truncateFinalPage = YES;
        _mainScrollView.dataSource = self;
        _mainScrollView.delegate = self;
        _mainScrollView.opaque = YES;
        _mainScrollView.hidden=YES;
        
    }
    return _mainScrollView;
}

/**
 * searchBarItem初期化（検索ボタン）
 *
 */
- (UIBarButtonItem *)searchBarItem
{
    if (!_searchBarItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([self isLogin]) {
            [button setBackgroundImage:[UIImage imageNamed:@"06_blue"]
                              forState:UIControlStateNormal];
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"06_glay"]
                              forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(searchBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 25, 25);
        _searchBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }
    return _searchBarItem;
}
/**
 * webBarItem初期化(webView画面へ遷移)
 *
 */
- (UIBarButtonItem *)webBarItem
{
    if (!_webBarItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"webBar"]
                          forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showWeb) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 25, 25);
        
        _webBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }
    return _webBarItem;
}
#pragma mark - utility -
#pragma mark
/**
 * view初期化
 *
 */
- (void)initViews
{
    [super initViews];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = self.searchBarItem;
    self.navigationItem.rightBarButtonItem = self.webBarItem;
    [self.view addSubview:self.progressViewBar];
    self.popoverBackground.hidden = YES;
}

- (void) pushItem:(UIButton *)sender
{
    [detailSelectView dismissMyview];
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    if (self.pageArray.count == 0) {
        
    }else{
        if (sender.tag == 1001) {
            if ([self isLogin]) {
                _toolBarStyle = 0;
                if ([self isLandscape]) {
                    [self setHorToolBar];
                }else{
                    [self resetHomeToolBar];
                }
                
            }else{
                [self notLoginAction];
            }
        }else if (sender.tag == 1002){
            if ([self isLogin]) {
                [self toGripViewController];
            }else{
                [self notLoginAction];
            }
        }else if (sender.tag == 1003){
            if ([self isLogin]) {
                [self toNoteListViewController];
            }else{
                [self notLoginAction];
            }
        }else if (sender.tag == 1004){
            if ([self isLogin]) {
                if ([self isLandscape]) {
                    [self setHorToolBar];
                    self.popoverBackground.currentindex=[self currentIndexInPages:self.mainScrollView.currentItemIndex curPagerIndexNo:nil];
                }else{
                    [self resetHomeToolBar];
                    self.popoverBackground.currentindex=self.mainScrollView.currentItemIndex;
                }
                
                [self.popoverBackground showPopoverView:NAPopoverPaper withInfo:self.pageArray];
                // GA(tag manager)
                [TAGManagerUtil pushButtonClickEvent:ENPageListBtn label:[self getLabelName]];
                _toolBarStyle = 1;
                
            }else{
                [self notLoginAction];
            }
        }else if (sender.tag == 1005){
            [self toSettingViewContreller];
            
        }else if (sender.tag == 1006){
            if ([self isLogin]) {
                [self detailbtnClick];
            }else{
                [self notLoginAction];
            }
            
        }else if (sender.tag == 1007){
            if ([self isLogin]) {
                detailSelectView=[[NADeatilSelectedAlertView alloc]init];
                detailSelectView.delegate=self;
                [detailSelectView show];

            }else{
                [self notLoginAction];
            }
            
        }

    }
    
}
#pragma NADeatilSelectedAlertView --delegate
- (void)clipClick{
    [self saveClipbtnClick];
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
}
- (void)printClick{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    NASubImageScrollView *imageScroll=(NASubImageScrollView *)self.mainScrollView.currentItemView;
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger index = 0;
    if (imageScroll.otherPageDocs) {
        [array addObjectsFromArray:imageScroll.pageDocs];
        [array addObjectsFromArray:imageScroll.otherPageDocs];
    }else{
        [array addObjectsFromArray:imageScroll.pageDocs];
    }
    
    for (NADoc *d in array) {
        if ([d.indexNo isEqualToString:imageScroll.imageView.noteView.curNoteIndexNo]) {
            break;
        }
        
        index++;
    }
    if (index <= array.count-1) {
        NADoc *doc= [array objectAtIndex:index];
        NSString *imagePath = doc.clippingImgPath;;
        // 記事画像を設定
        if ([imagePath isKindOfClass:[NSString class]] && imagePath.length > 0) {
            NSArray *urlarray=[imagePath componentsSeparatedByString:@","];
            NSString *urlstr=[urlarray objectAtIndex:0];
            imagePath =[CharUtil convHttps2Image:urlstr] ;
        }else {
            imagePath = nil;
        }
        
        UIPrintInteractionController *printC = [UIPrintInteractionController sharedPrintController];
        UIPrintInfo *printInfo = [NSClassFromString(@"UIprintInfo") printInfo ];
        printInfo.duplex= UIPrintInfoDuplexLongEdge;
        NSData *data;
        if (imagePath) {
            data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:imagePath]];
        }else{
            data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:@"http://ac-eq8ixesr.clouddn.com/pD3UKfN8diRRlGkzHv60PKB.png"]];
        }
        
        printC.printingItem= data;
        printC.printInfo= printInfo;
        printC.showsPageRange = YES;
        
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
            if (!completed && error) {
                NSLog(@"FAILED! due to error in domain %@ with error code %lu", error.domain, error.code);
            }
        };
        
        
        if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            [printC presentFromRect:self.view.frame inView:self.view animated:YES completionHandler:completionHandler];
        }
        else {
            [printC presentAnimated:YES completionHandler:completionHandler];
        }

    }
    
}
-(void)shareClick:(UIButton *)sender{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    NASubImageScrollView *imageScroll=(NASubImageScrollView *)self.mainScrollView.currentItemView;
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger index = 0;
    if (imageScroll.otherPageDocs) {
        [array addObjectsFromArray:imageScroll.pageDocs];
        [array addObjectsFromArray:imageScroll.otherPageDocs];
    }else{
        [array addObjectsFromArray:imageScroll.pageDocs];
    }
    
    for (NADoc *d in array) {
        if ([d.indexNo isEqualToString:imageScroll.imageView.noteView.curNoteIndexNo]) {
            break;
        }
        
        index++;
    }
    if (index <= array.count-1) {
        NADoc *doc= [array objectAtIndex:index];
        if ([doc.clippingImgPath isEqualToString:@""]) {
            [[[iToast makeText:NSLocalizedString(@"NO Note", nil)]
              setGravity:iToastGravityBottom] show];
        } else {
            
            [ProgressHUD show:NSLocalizedString(@"imageloading", nil)];
            //进入异步线程
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //异步下载图片
                NSString *imagePath = doc.clippingImgPath;
                
                NSRange range = [imagePath rangeOfString:@".jpg"];//匹配得到的下标
                imagePath = [imagePath substringToIndex:range.location];//截取范围类的字符串
                NSString *shareImagePath = [imagePath stringByAppendingString:@"_share.jpg"];
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:shareImagePath]];
                //网络请求之后进入主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    //关闭loading
                    [ProgressHUD dismiss];
                    if (imageData) {
                        UIImage *image = [UIImage imageWithData:imageData];
                        //初始化分享控件
                        UIActivityViewController *activeViewController = [[UIActivityViewController alloc]initWithActivityItems:@[image] applicationActivities:nil];
                        //不显示哪些分享平台(具体支持那些平台，可以查看Xcode的api)
                        activeViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
                        UIView *sourceView = [[UIView alloc] init];
                        [self.view addSubview:sourceView];
                        [sourceView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.mas_equalTo(-30);
                            make.width.height.mas_equalTo(30);
                            make.bottom.mas_equalTo(-10);
                        }];
                        activeViewController.popoverPresentationController.sourceView = sourceView;
                        activeViewController.popoverPresentationController.sourceRect = sourceView.bounds;
                        
                        [self presentViewController:activeViewController animated:YES completion:nil];
                        //分享结果回调方法
                        UIActivityViewControllerCompletionHandler myblock = ^(NSString *type,BOOL completed){
                            if (completed) {
                                [[[iToast makeText:NSLocalizedString(@"Share succeed", nil)]
                                  setGravity:iToastGravityBottom] show];
                            } else {
                                [[[iToast makeText:NSLocalizedString(@"Share fail", nil)]
                                  setGravity:iToastGravityBottom] show];
                            }
                        };
                        activeViewController.completionHandler = myblock;
                    } else {
                        [[[iToast makeText:NSLocalizedString(@"Load image fail", nil)]
                          setGravity:iToastGravityBottom] show];
                    }
                });
            });
        }
    }
    
}
- (void)showWeb{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    [self toWebViewController];
}
-(void)toWebViewController{
    NSURL *url =[NSURL URLWithString:[NASaveData getWebUrl]];
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    //webViewController.navigationButtonsHidden=YES;
    webViewController.showActionButton=NO;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
}
// 記事詳細画面へ遷移
-(void)detailbtnClick{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    NASubImageScrollView *imageScroll=(NASubImageScrollView *)self.mainScrollView.currentItemView;
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger index = 0;
    if (imageScroll.otherPageDocs) {
        [array addObjectsFromArray:imageScroll.pageDocs];
        [array addObjectsFromArray:imageScroll.otherPageDocs];
    }else{
        [array addObjectsFromArray:imageScroll.pageDocs];
    }
    
    for (NADoc *d in array) {
        if ([d.indexNo isEqualToString:imageScroll.imageView.noteView.curNoteIndexNo]) {
            break;
        }
        
        index++;
    }
    if (index <= array.count-1) {
        [self toNoteDetailViewController:array index:index];
    }
    
}
/**
 * ペッジ一覧画面に、１ペッジを選択後、紙面を表示する
 *
 */
- (void)popoverDelegateWithType:(NAPopoverBackgroundType)aType withDataSource:(id)object
{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    if (aType == NAPopoverPaper) {
        
        [self.popoverBackground hidePopoverView];
        NSInteger tag = ((NSNumber *)object).integerValue;
        _toolBarStyle = 0;
        if ([self isLandscape]) {
            _riliView.hidden = YES;
            [self setHorToolBar];
            NSArray *array = [self padLandscapeCount];
            NSInteger index = [self currentIndex:tag - 1];
            [self.mainScrollView scrollToPage:(array.count - 1 - index) duration:0];
            [self swipeViewDidEndDecelerating:self.mainScrollView];
        }else{
            [self resetRiliview];
            [self resetHomeToolBar];
            _riliView.hidden = NO;
            [self.mainScrollView scrollToPage:(self.pageArray.count - tag) duration:0];
            [self swipeViewDidEndDecelerating:self.mainScrollView];
        }
    }else if (aType == NAPopoverDate) {
        
    }else if (aType == NAPopoverArticle) {
        
    }
    
}
- (void)resetToolBar{
    _toolBarStyle = 0;
    if ([self isLandscape]) {
        _riliView.hidden = YES;
        [self setHorToolBar];
    }else{
        [self resetRiliview];
        [self resetHomeToolBar];
        _riliView.hidden = NO;
    }

}
//add clip
-(void)saveClipbtnClick{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
     [ProgressHUD show:NSLocalizedString(@"note saving", nil)];
    NASubImageScrollView *imageScroll=(NASubImageScrollView *)self.mainScrollView.currentItemView;
    NSDictionary *param = @{
                            //@"Fl"         :  [NSString addclipListFl],
                            //@"Mode"       :  @"1",
                            @"IndexNo"       :  imageScroll.imageView.noteView.curNoteIndexNo,
                            //@"K002"       :  @"4",
                            //@"Rows"       :  @"999",
                            @"Userid"     :  [NASaveData getLoginUserId]
                            //@"UseDevice"  :  @"N05"
                            };
    NSLog(@"clipDoc.indexNo==%@",imageScroll.imageView.noteView.curNoteIndexNo);
    [[NANetworkClient sharedClient] postFavoritesSave:param completionBlock:^(id favorites, NSError *error) {
        if (!error) {
            SHXMLParser *parser = [[SHXMLParser alloc] init];
            NSDictionary *dic = [parser parseData:favorites];
            NSDictionary *resposeDic=[dic objectForKey:@"response"];
            NSString *statusMessage=[resposeDic objectForKey:@"status"];
            if ([statusMessage isEqualToString:@"0"]) {
                MAIN(^{
                    [ProgressHUD dismiss];
                    [[[iToast makeText:NSLocalizedString(@"note saved", nil)]
                      setGravity:iToastGravityBottom] show];
                    [TAGManagerUtil pushButtonClickEvent:ENClipSaveBtn label:[self getLabelName]];
                });
            }else if([statusMessage isEqualToString:@"1"]){
                MAIN(^{
                    [ProgressHUD dismiss];
                    [[[iToast makeText:NSLocalizedString(@"note indexNo error", nil)]
                      setGravity:iToastGravityBottom] show];
                });
            }else if([statusMessage isEqualToString:@"9"]){
                MAIN(^{
                    [ProgressHUD dismiss];
                    [[[iToast makeText:NSLocalizedString(@"note Max", nil)]
                      setGravity:iToastGravityBottom] show];
                });
            }else{
                MAIN(^{
                    [ProgressHUD dismiss];
                    [[[iToast makeText:NSLocalizedString(@"note do save error", nil)]
                      setGravity:iToastGravityBottom] show];
                });
            }
            
            
            
            
        }else{
            MAIN(^{
                [ProgressHUD dismiss];
                [[[iToast makeText:NSLocalizedString(@"note do save error", nil)]
                  setGravity:iToastGravityBottom] show];
            });
        }
    }];
    
}

/**
 * view更新
 *
 */
- (void)updateViews
{
    
    CGFloat screenWidth = [Util screenSize].width;
    CGFloat screenHeight = [Util screenSize].height;
    
    CGFloat barHeight = self.homeToolBar.frame.size.height;
    CGFloat progressHeight = PROGRESS_HEIGHT;
    if (isPhone) {
        self.toolBar.frame=CGRectMake(0, screenHeight - 44, self.view.frame.size.width, 44);
        self.progressViewBar.frame = CGRectMake(0, screenHeight - 44 - progressHeight, screenWidth, progressHeight);
    }else{
        self.toolBar.frame=CGRectMake(0, screenHeight - 49, self.view.frame.size.width, 49);
        self.progressViewBar.frame = CGRectMake(0, screenHeight - 49 - progressHeight, screenWidth, progressHeight);
    }
    self.homeToolBar.frame = CGRectMake(0, screenHeight - barHeight, self.view.frame.size.width, barHeight);
    //self.mainScrollView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    // download barを設定
    [self.progressViewBar updateViews];
    [_progressViewBar setStatus:NSLocalizedString(@"imageloading", nil)];
    
    // パージ一覧
    self.popoverBackground.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    self.mylogoview.frame=self.view.bounds;
    if ([Util screenSize].width>[Util screenSize].height) {
        //横屏
        if(isPad){
            self.mainScrollView.frame = CGRectMake(0, 0, [Util screenSize].width, [Util screenSize].height-64-49);
            self.mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_1024_768.png"];
        }else{
            self.mainScrollView.frame = CGRectMake(0, 0, [Util screenSize].width, [Util screenSize].height-34-44);
            self.mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_667.png"];
        }
    }else{
        //竖屏
        if(isPad){
            self.mainScrollView.frame = CGRectMake(0, 40, [Util screenSize].width, [Util screenSize].height-64-49-40);
            self.mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_1024_768.png"];
        }else{
            self.mainScrollView.frame = CGRectMake(0, -30, [Util screenSize].width, [Util screenSize].height-10);
            self.mylogoview.image=[UIImage imageNamed:@"nextep_logo_blue_667.png"];
        }
    }


    
}
#pragma mark - button action -
#pragma mark

/**
 * 検索ボタンクリック
 *
 */
- (void)searchBarItemAction:(id)sender
{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    if ([self isLogin]) {
        if ([[NASaveData getDataUserClass] isEqualToString:@"10"]) {
            [self toSearchViewController];
        }else if([[NASaveData getDataUserClass] isEqualToString:@"11"]){
            [self notLoginAction];
        }else{
            [self notLoginAction];
        }
        
    }else{
        [self notLoginAction];
    }
    
}

/**
 * 更新ボタンクリック
 *
 */
- (void)refreshBarItemAction
{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
//    if (![[ProgressHUD shared] isShowing]) {
//        [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
//    }
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    if (self.pageArray.count == 0) {
        [self getmasterAPI:[NASaveData getDefaultUserID]];
    }else {
        [self searchCurrentApi:self.pageArray[0] ByUserid:[NASaveData getDefaultUserID]];
    }
    // GA(tag manager)
    [TAGManagerUtil pushButtonClickEvent:ENRefreshBtn label:[self getLabelName]];
}



/**
 * 検索画面を表示
 *
 */
- (void)toSearchViewController
{
    if (self.pageArray==nil||self.pageArray.count==0) {
        return;
    }
    NANewSearchViewController *search = [[NANewSearchViewController alloc]init];
    search.currDoc = self.pageArray[0];
    search.pageArray = _pageArray;
    search.topPageDoc = _topPageDoc;
    search.clipDataSource = _clipDataSource;
    search.regionDic =_regionDic;
//    NSInteger count2 =_NotePageArray.allKeys.count;
//    search.noteNumber = count2;
//    search.NoteArray = _NoteArray;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:search];
    [self presentViewController:nav animated:YES completion:^{
        
    }];


}
/**
 *SerachNewsList
 *
 */

- (void)toSerachLastNewsList{
    [NASaveData saveIsPublication:NO];
//    if (![[ProgressHUD shared] isShowing]) {
//        [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
//    }
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    self.forwardPage=@"toSerachLastNewsList";
    if (self.pageArray.count == 0) {
        [self getmasterAPI:[NASaveData getDefaultUserID]];
    }else {
        NADoc *currentDoc = self.pageArray[0];
        NSArray *masterArray=[NASaveData sharedInstance].masterArray;
        
        NSMutableArray *publicationArray=[[NSMutableArray alloc]init] ;
        for (NAPublisherGroupInfo *publisherGroupInfo in masterArray) {
            if ([currentDoc.publisherGroupInfoId isEqualToString:publisherGroupInfo.publisherGroupInfoIdentifier]) {
                for (NAPublisherInfo *publisherInfo in publisherGroupInfo.publisherInfo) {
                    if ([currentDoc.publisherInfoId isEqualToString:publisherInfo.publisherInfoIdentifier]) {
                        for (NAPublicationInfo *publicationInfo in publisherInfo.publicationInfo) {
                            [publicationArray addObject:publicationInfo];
                        }
                    }
                }
            }
        }
        NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"dispOrder4" ascending:NO];
        NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"dispOrder1" ascending:YES];
        [publicationArray sortUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor1,sortDescriptor2, nil]];
        NAPublicationInfo *publicationInfo=publicationArray[0];
        NSDictionary *param = @{
                                @"Userid"     :  [NASaveData getDefaultUserID],
                                @"UseDevice"  :  NAUserDevice,
                                @"K090"       :  @"010",
                                @"Rows"       :  @"1",
                                @"K003"       :  [NSString stringWithFormat:@"20000101:%@",[Util getSystemDate]],
                                @"K004"       :  currentDoc.publisherGroupInfoId,
                                @"K005"       :  currentDoc.publisherInfoId,
                                @"K006"       :  publicationInfo.publicationInfoIdentifier,
                                //                                @"K008"       :  doc.editionInfoId,
                                @"K002"       :  @"2",
                                @"Mode"       :  @"1",
                                @"Sort"       :  @"K003:desc,K032:desc,K006:asc",
                                @"Fl"         :  [NSString searchWithPublicationInfoId]
                                };
        NSMutableDictionary *muDic=[NSMutableDictionary dictionaryWithDictionary:param];
        if ([NASaveData getIsVisitorModel]) {
            [muDic setObject:currentDoc.publicationInfoId forKey:@"K006"];
        }
        [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
            if (!error) {
                SHXMLParser *parser = [[SHXMLParser alloc] init];
                NSDictionary *dic = [parser parseData:search];
                NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                if (searchBaseClass.response.doc.count > 0) {
                    NADoc *tmpdoc=searchBaseClass.response.doc[0];
                    tmpdoc.publication_disOrder1=currentDoc.publication_disOrder1;
                    tmpdoc.publication_disOrder3=currentDoc.publication_disOrder3;
                    [self searchCurrentApi:tmpdoc ByUserid:[NASaveData getDefaultUserID]];
                }
                
            }else{
                ITOAST_BOTTOM(error.localizedDescription);
                [ProgressHUD dismiss];
            }
        }];
        
    }
    
    
    
    
    // GA(tag manager)
    [TAGManagerUtil pushButtonClickEvent:ENRefreshBtn label:[self getLabelName]];
}

/**
 * まとめ読み画面を表示
 *
 */
- (void)toPublicationViewController
{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    NAPublicationViewController *publication = [[NAPublicationViewController alloc] init];
    publication.currDoc = self.pageArray[0];
    publication.selectedDocCompletionBlock = ^(NADoc *doc) {
        [NASaveData saveIsPublication:YES];
        [self controlTheBlockWithdoc:doc];
    };
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:publication];
    [self presentViewController:nav animated:YES completion:^{
        [[NADownloadHelper sharedInstance] stopNoty];
    }];
    
    // GA(tag manager)
    [TAGManagerUtil pushButtonClickEvent:ENSummaryReadBtn label:[self getLabelName]];
}


/**
 * 選択した紙面を表示
 *
 */
-(void)controlTheBlockWithdoc:(NADoc *)doc{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    NADoc *tempdoc = self.pageArray[0];
    if ( [tempdoc.editionInfoId isEqualToString:doc.editionInfoId]
        &&[tempdoc.publicationInfoId isEqualToString:doc.publicationInfoId]
        &&[tempdoc.publisherInfoId isEqualToString:doc.publisherInfoId]
        &&[tempdoc.publisherGroupInfoId isEqualToString:doc.publisherGroupInfoId]
        &&[tempdoc.publishDate isEqualToString:doc.publishDate]) {
        [ProgressHUD dismiss];
        isChooseDay = 0;
    }else{
        
        [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
        isChooseDay = 1;
//        if (isHaveRegion == 1) {
            [self searchCurrentApi:doc ByUserid:[NASaveData getDefaultUserID]];
//        }else{
//            [self searchCurrentApiNoRegion:doc ByUserid:[NASaveData getDefaultUserID]];
//        }
    
    }
    
}
    //没有地域版全纸面检索
//    - (void)searchCurrentApiNoRegion:(NADoc *)doc ByUserid:(NSString *)myUserid
//    {
//        [self.mainScrollView removeFromSuperview];
//        isDoneImageTask=NO;
//        _mainScrollView = nil;
//        _mainScrollView = self.mainScrollView;
//        
//        if (!self.homeToolBar.isHidden) {
//            MAIN(^{
//                if ([NASaveData isAlldownload]) {
//                    [self.progressViewBar setHidden:NO];
//                }else{
//                    [self.progressViewBar setHidden:YES];
//                }
//            });
//            
//        }
//        
//        [_progressViewBar setProgressNum:0.0f];
//        [_progressViewBar setTitleText:@""];
//        
//        [[NADownloadHelper sharedInstance] cancel];
//        [[NADownloadHelper sharedInstance] initImageTask];
//        
//        if ([NACheckNetwork sharedInstance].isHavenetwork){
//            
//            // 1~5紙面mini imageをdownload see the MSearchcondition.h
//            NSDictionary *param = @{
//                                    @"K008"       :  doc.editionInfoId,
//                                    @"Userid"     :  myUserid,
//                                    @"UseDevice"  :  NAUserDevice,
//                                    @"Rows"       :  [NSString stringWithFormat:@"%ld", (long)firstDownloadNum],
//                                    @"K004"       :  doc.publisherGroupInfoId,
//                                    @"K003"       :  [NSString stringWithFormat:@"%@:%@",doc.publishDate,doc.publishDate],
//                                    @"K006"       :  doc.publicationInfoId,
//                                    @"K005"       :  doc.publisherInfoId,
//                                    @"K014"       :  @"1",
//                                    @"K002"       :  @"2",
//                                    @"Mode"       :  @"1",
//                                    @"Sort"       :  @"K006:asc,K090:asc,K012:asc",
//                                    @"Fl"         :  [NSString searchCurrentFl]
//                                    };
//            [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
//                
//                if (!error) {
//                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                        
//                        SHXMLParser *parser = [[SHXMLParser alloc] init];
//                        NSDictionary *dic = [parser parseData:search];
//                        NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
//                        
//                        if (searchBaseClass.response.doc&&searchBaseClass.response.doc.count>0) {
//                            // 紙面image
//                            [[NADownloadHelper sharedInstance] downloadThumb:searchBaseClass.response.doc index:0];
//                            
//                            //　記事
//                            if ([NASaveData isHaveNote]) {
//                                [[NADownloadHelper sharedInstance] downloadNote:searchBaseClass.response.doc start:0 end: searchBaseClass.response.doc.count isSetInDoc:FALSE];
//                            }
//                        }
//                    });
//                }
//            }];
//            // 全紙面を検索
//            param = @{
//                      @"K008"       :  doc.editionInfoId,
//                      @"Userid"     :  myUserid,
//                      @"UseDevice"  :  NAUserDevice,
//                      @"Rows"       :  @"100",
//                      @"K004"       :  doc.publisherGroupInfoId,
//                      @"K003"       :  [NSString stringWithFormat:@"%@:%@",doc.publishDate,doc.publishDate],
//                      @"K006"       :  doc.publicationInfoId,
//                      @"K005"       :  doc.publisherInfoId,
//                      @"K014"       :  @"1",
//                      @"K002"       :  @"2",
//                      @"Mode"       :  @"1",
//                      @"Sort"       :  @"K006:asc,K090:asc,K012:asc",
//                      @"Fl"         :  [NSString searchCurrentFl],
//                      };
//            doc.user_id=[NASaveData getLoginUserId];
//            if (![[NASQLHelper sharedInstance]isHavePaperInfoByDoc:doc]) {
//                [[NASQLHelper sharedInstance]addPaperInfo:doc];
//            }
//            
//            [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
//                
//                if (!error) {
//                    SHXMLParser *parser = [[SHXMLParser alloc] init];
//                    NSDictionary *dic = [parser parseData:search];
//                    NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
//                    if (searchBaseClass.response.doc==nil||searchBaseClass.response.doc.count<=0) {
//                        NADoc *doc = self.searchPublicationArray[0];
//                        [self searchCurrentApi:doc ByUserid:[NASaveData getDefaultUserID]];
//                        return ;
//                    }
//                    // 紙面XMLを格納
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        [[NAFileManager sharedInstance] saveSearchFileWithData:search Mydoc:doc];
//                    });
//                    
//                    // 紙面情報初期化
//                    [self.pageArray removeAllObjects];
//                    [self.pageArray addObjectsFromArray:searchBaseClass.response.doc];
//                    [NADownloadHelper sharedInstance].docs=self.pageArray;
//                    
//                    
//                    //                [self.pageArray removeAllObjects];
//                    //                NSInteger dicCount= _regionDic.allKeys.count;
//                    //                for (int i = 1; i < dicCount+1; i++) {
//                    //                    NSArray *arr = [_regionDic objectForKey:[NSString stringWithFormat:@"%d",i]];
//                    //                    if (arr.count == 1) {
//                    //                        [self.pageArray addObject:[arr objectAtIndex:0]];
//                    //                    }else{
//                    //                        for(int i = 0; i < arr.count; i++) {
//                    //                            NADoc *doc = [arr objectAtIndex:i];
//                    //                            NSString *area = doc.releaseAreaInfo;
//                    //                            if (area.length != 0) {
//                    //                                if ([area isEqualToString:areaCode]) {
//                    //                                    [_pageArray addObject:[arr objectAtIndex:i]];
//                    //                                }else{
//                    //                                    [localPageArr addObject:[arr objectAtIndex:i]];
//                    //                                }
//                    //                            }
//                    //
//                    //                        }
//                    //                    }
//                    //                }
//                    
//                    
//                    // 紙面 download task始め
//                    BACK(^{
//                        NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
//                        
//                        if ([NASaveData getFirstDownload] == 1) {
//                            [tmpdic setObject:NASOKUHO forKey:@"downloadtype"];
//                            [tmpdic setObject:@"" forKey:@"genreId"];
//                            [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadSokuhoTask" object:nil userInfo:tmpdic];
//                        }
//                        
//                        // 紙面
//                        if ([NASaveData getFirstDownload] != 1) {
//                            [tmpdic setObject:NAThumbimage forKey:@"downloadtype"];
//                            [tmpdic setObject:[NSNumber numberWithInteger:firstDownloadNum] forKey:@"imageindex"];
//                            [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadImageTask" object:nil userInfo:tmpdic];
//                        }
//                    });
//                    
//                    // 画面表示
//                    [self showMainView];
//                    if (![NASaveData getIsVisitorModel]) {
//                        [NASaveData saveCurrentDoc:doc];
//                    }
//                    
//                    
//                    //　記事
//                    if ([NASaveData isHaveNote]) {
//                        [[NADownloadHelper sharedInstance] downloadNote:self.pageArray start:firstDownloadNum end:self.pageArray.count isSetInDoc:FALSE];
//                    }
//                    //                [self getNoteAPI];
//                }else{
//                    ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
//                    [ProgressHUD dismiss];
//                }
//            }];
//            
//        }else{
//            //        MAIN(^{
//            //            ITOAST_BOTTOM(NSLocalizedString(@"networkerror", nil));
//            //        });
//            NSData *mydata=[[NAFileManager sharedInstance] readSearchFileWithdoc:doc];
//            
//            if (mydata) {
//                SHXMLParser *parser = [[SHXMLParser alloc] init];
//                NSDictionary *dic = [parser parseData:mydata];
//                NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
//                
//                
//                // 紙面情報初期化
//                [self.pageArray removeAllObjects];
//                [self.pageArray addObjectsFromArray:searchBaseClass.response.doc];
//                
//                [NADownloadHelper sharedInstance].docs=self.pageArray;
//                
//                // download task始め
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                    NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
//                    [tmpdic setObject:NAThumbimage forKey:@"downloadtype"];
//                    [tmpdic setObject:[NSNumber numberWithInteger:firstDownloadNum] forKey:@"imageindex"];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadImageTask" object:nil userInfo:tmpdic];
//                });
//                
//                // 画面表示
//                [self showMainView];
//                MAIN(^{
//                    [ProgressHUD dismiss];
//                });
//                //            [self getNoteAPI];
//            }else{
//                [self showMainView];
//                MAIN(^{
//                    [ProgressHUD dismiss];
//                });
//            }
//            
//        }
//    }
//- (void)getNoteAPI
//{
//    NSDictionary *param = @{
//                            @"Start"      :  @"0",
//                            @"Userid"     :  [NASaveData getDefaultUserID],
//                            @"UseDevice"  :  NAUserDevice,
//                            @"K002"       :  @"4",
//                            @"Rows"       :  @"75",
//                            @"Mode"       :  @"1",
//                            @"Fl"         :  [NSString clipListFl],
//                            @"Sort"       :  @"K053:desc,K032:desc",
//                            };
//    [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
//        if (!error) {
//            SHXMLParser *parser = [[SHXMLParser alloc] init];
//            NSDictionary *dic = [parser parseData:search];
//            NASearchBaseClass *clipBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
//            NSArray *array = clipBaseClass.response.doc;
//            for (int i = 1; i < self.pageArray.count; i++) {
//                NSMutableArray *_mianArray= [[NSMutableArray alloc]init];
//                for(NADoc *doc in array) {
//                    if ([doc.pageno hasPrefix:@"0"]) {
//                        if (i == [doc.pageno substringWithRange:NSMakeRange(1, 1)].integerValue) {
//                            [_mianArray addObject:doc];
//                            
//                        }
//                    }else{
//                        if (i == doc.pageno.integerValue) {
//                            [_mianArray addObject:doc];
//                            
//                        }
//                    }
//                    
//                    
//                }
//                [_NotePageArray setObject:_mianArray forKey:[NSString stringWithFormat:@"%d",i-1]];
//                //NSLog(@"%@",_NotePageArray.allKeys);
//            }
//
//        }else{
//            ITOAST_BOTTOM(error.localizedDescription);
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//    }];
//}
/**
 * 記事リスト画面を表示
 *
 */
- (void)toNoteListViewController
{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    if (!self.pageArray || !self.pageArray.count || self.pageArray.count == 0) {
        return;
    }
    
    NADoc *doc = nil;
    NADoc *other = nil;
    NSInteger count = self.pageArray.count;
    NANoteListViewController *note;
    note = [[NANoteListViewController alloc]init];
    if (![self isLandscape]) {
        doc = self.pageArray[count - 1 - self.mainScrollView.currentItemIndex];
        NSInteger otherindex=[self findParterIndex:count - 1 - self.mainScrollView.currentItemIndex];
        if (otherindex!=-1) {
            other=self.pageArray[otherindex];
        }
        if ( other.notearray.count== 0) {
            NSString *path = [[NAFileManager sharedInstance] searchNoteName:other withNoteName:NoteFileName];
            NSFileManager *fileManage = [NSFileManager defaultManager];
            if ([fileManage fileExistsAtPath:path isDirectory:FALSE]) {
                NSData *data = [NSData dataWithContentsOfFile:path];
                other.notearray = [[NAFileManager sharedInstance] arrayWithData:data];
                
                for (NSInteger index=0; index<other.notearray.count; index++) {
                    NADoc *temdoc=[other.notearray objectAtIndex:index];
                    temdoc.miniPagePath=other.miniPagePath;
                    temdoc.lastUpdateDateAndTime=other.lastUpdateDateAndTime;
                }
            }
        }
        
        note.myselectIndex=count - 1 - self.mainScrollView.currentItemIndex;
        
        
    }else{
        NSArray *pageSort = [self padLandscapeCount];
        NSInteger landCount = pageSort.count;
        NSArray *sort = pageSort[landCount - 1 - self.mainScrollView.currentItemIndex];
        if (sort.count == 1) {
            NSNumber *aDocIndex = sort[0];
            doc = self.pageArray[aDocIndex.integerValue];
            note.myselectIndex=aDocIndex.integerValue;
        }else{
            NSNumber *aDocIndex = sort[0];
            NSNumber *otherDocIndex = sort[1];
            doc = self.pageArray[aDocIndex.integerValue];
            other =  self.pageArray[otherDocIndex.integerValue];
            
            if (istwo==1) {
                note.myselectIndex=aDocIndex.integerValue;
            }else{
                note.myselectIndex=otherDocIndex.integerValue;
            }
            
        }
        
    }
    //note.NotePageArray=self.pageArray;
    
    note.doc=doc;
    note.other=other;
    note.topPageDoc = _topPageDoc;
    note.pageArray = _pageArray;
    note.regionDic = _regionDic;
    note.clipDataSource = _clipDataSource;
//    NSInteger count2 =_NotePageArray.allKeys.count;
//    note.noteNumber = count2;
//    note.NotePageArray = _NoteArray;
    note.selectmynoteCompletionBlock = ^(NADoc *doc) {
        isNotelistChange=YES;
        [self controlTheBlockWithdoc:doc];
    };
    
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:note];
    [self presentViewController:nav animated:NO completion:^{
        
    }];
    // GA(tag manager)
    //[TAGManagerUtil pushButtonClickEvent:ENKijiListBtn label:ENKijiListLab];
}

/**
 * クリップリスト画面を表示
 *
 */
- (void)toGripViewController
{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
   [detailSelectView dismissMyview];
    if (![NACheckNetwork sharedInstance].isHavenetwork) {
        
        [[[iToast makeText:NSLocalizedString(@"networkerror", @"")]
          setGravity:iToastGravityBottom] show];
        return;
    }
    NAClipViewController *grip =  [[NAClipViewController alloc] init];
    grip.pageArray = _pageArray;
    grip.regionDic = _regionDic;
    grip.topPageDoc = _topPageDoc;
    if (isChooseDay == 1) {
        grip.clipDataSource = nil;
        grip.clipNumber = 0;
    }else{
        grip.clipDataSource = _clipDataSource;
        grip.clipNumber = 1;
    }
    
//    NSInteger count2 =_NotePageArray.allKeys.count;
//    grip.noteNumber = count2;
//    grip.NoteArray = _NoteArray;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:grip];
    [self presentViewController:nav animated:NO completion:^{
        
    }];
    
    // GA(tag manager)
    [TAGManagerUtil pushButtonClickEvent:ENClipListBtn label:[self getLabelName]];
    
    
}

/**
 * 設定画面を表示
 *
 */
- (void)toSettingViewContreller
{
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    [detailSelectView dismissMyview];
    NANewSettingViewController *setting = [[NANewSettingViewController alloc] init];
    setting.pageArray = _pageArray;
    setting.topPageDoc = _topPageDoc;
    setting.clipDataSource = _clipDataSource;
    setting.regionDic = _regionDic;
//    NSInteger count2 =_NotePageArray.allKeys.count;
//    setting.noteNumber = count2;
//    setting.NoteArray = _NoteArray;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:setting];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    // GA(tag manager)
    [TAGManagerUtil pushButtonClickEvent:ENSetupBtn label:[self getLabelName]];
}

/**
 * 記事詳細画面を表示
 *
 */
- (void)toNoteDetailViewController:(NSArray *)docs index:(NSInteger)index
{
    [detailSelectView dismissMyview];
    [localPickView dissmissView];
    [localPickView2 dissmissView];
    if ([self isLogin]) {
        if (index > docs.count || docs.count ==0) {
            
        }else{
            NADetailBaseViewController *detail = [[NADetailBaseViewController alloc] init];
            detail.details = docs;
            detail.currentIndex = index;
            detail.isfromWhere = TYPE_NOTE;
            detail.regionDic = _regionDic;
            NADoc *doc= [docs objectAtIndex:index];
            detail.topPageDoc= doc;
            detail.pageArray = _pageArray;
            //detail.topPageDoc = _topPageDoc;
            detail.clipDataSource = _clipDataSource;
            detail.indexNoFromClip = doc.indexNo;
            NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:detail];
            [self presentViewController:nav animated:YES completion:^{
                
            }];
            // GA(tag manager)
            [TAGManagerUtil pushButtonClickEvent:ENKijiDetailBtn label:ENKijiDetailLab];
        }
    }else{
        [self notLoginAction];
    }
    
}

-(NSString *)getScreenName{
    
    NSString *str;
    NADoc *doc;
    NADoc *other;
    
    if (![self isLandscape]) {
        NSInteger count = self.pageArray.count;
        
        doc=self.pageArray[count - 1 - self.mainScrollView.currentItemIndex];
        
    }else{
        NSArray *pageSort = [self padLandscapeCount];
        NSInteger landCount = pageSort.count;
        NSInteger myindex=landCount - 1 - self.mainScrollView.currentItemIndex;
        
        if (pageSort>0) {
            
            NSArray *sort = pageSort[myindex];
            NSNumber *aDocIndex = sort[0];
            
            if (sort.count == 1) {
                doc = self.pageArray[aDocIndex.integerValue];
                
            }else{
                NSNumber *otherDocIndex = sort[1];
                doc = self.pageArray[aDocIndex.integerValue];
                other =  self.pageArray[otherDocIndex.integerValue];
                
            }
        }
        
    }
    
    
    str=[NSString stringWithFormat:@"%@/%@/%@/%@-<%d>",doc.publishDate,doc.publisherInfoName,doc.editionInfoName,doc.pageInfoName,(unsigned)[self.pageArray indexOfObject:doc]+1];
    if (other) {
        str=[str stringByAppendingString:[NSString stringWithFormat:@"-%@-<%d>",other.pageInfoName,(unsigned)[self.pageArray indexOfObject:doc]+2]];
    }
    return str;
}
-(NSString *)getLabelName{
    
    NSString *str;
    NADoc *doc;
    NADoc *other;
    
    if (![self isLandscape]) {
        NSInteger count = self.pageArray.count;
        NSInteger mycurrentIndex=count - 1 - self.mainScrollView.currentItemIndex;
        if (mycurrentIndex>=count||mycurrentIndex<0) {
            return  @"";
        }
        doc=self.pageArray[count - 1 - self.mainScrollView.currentItemIndex];
        
    }else{
        NSArray *pageSort = [self padLandscapeCount];
        NSInteger landCount = pageSort.count;
        NSInteger myindex=landCount - 1 - self.mainScrollView.currentItemIndex;
        
        if (pageSort>0) {
            
            NSArray *sort = pageSort[myindex];
            NSNumber *aDocIndex = sort[0];
            
            if (sort.count == 1) {
                doc = self.pageArray[aDocIndex.integerValue];
                
            }else{
                NSNumber *otherDocIndex = sort[1];
                doc = self.pageArray[aDocIndex.integerValue];
                other =  self.pageArray[otherDocIndex.integerValue];
                
            }
        }
        
    }
    
    
    str=[NSString stringWithFormat:@"%@-%@-%@-%@-<%ld>",doc.publishDate,doc.publisherInfoName,doc.editionInfoName,doc.pageInfoName,(long)[self.pageArray indexOfObject:doc]+1];
    if (other) {
        str=[str stringByAppendingString:[NSString stringWithFormat:@"-%@-<%ld>",other.pageInfoName,(long)[self.pageArray indexOfObject:doc]+2]];
    }
    
    return str;
}

#pragma mark - API -
#pragma mark

//masterf
- (void)getmasterAPI:(NSString *)userID
{
    NSLog(@"%@",userID);
    MAIN(^{
//        if (![[ProgressHUD shared] isShowing]) {
//            [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
//        }
        [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    });
    
    //    NSLog(@"getmasterAPI") ;
    
    if ([NACheckNetwork sharedInstance].isHavenetwork){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *param = @{
                                    @"Userid"     :  userID,
                                    @"UseDevice"  :  NAUserDevice,
                                    };
            
            [[NANetworkClient sharedClient] postMasterWithDevice:param completionBlock:^(id master, NSError *error) {
                if (!error) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [[NAFileManager sharedInstance] saveMasterFileWithData:master];
                    });
                    SHXMLParser *parser = [[SHXMLParser alloc] init];
                    NSDictionary *dic = [parser parseData:master];
                    NAMasterBaseClass *masterBaseClass = [NAMasterBaseClass modelObjectWithDictionary:dic];
                    [NASaveData sharedInstance].masterArray = masterBaseClass.masterData.publishers.publisherGroupInfo;
                    
                    [self currentUserHaveNotes:masterBaseClass];
                    [[NADownloadHelper sharedInstance] initSokuhoTask:masterBaseClass];
                    [self getSearchAPIWithMaster:masterBaseClass];
                }else{
                    ITOAST_BOTTOM(error.localizedDescription);
                    [ProgressHUD dismiss];
                }
                
            }];
        });
    }else{
        self.homeToolBar.ishavesokuho=NO;
        self.isHavesokuho=NO;
        
        NSData *mymaster=[[NAFileManager sharedInstance] readMasterFile];
        SHXMLParser *parser = [[SHXMLParser alloc] init];
        NSDictionary *dic = [parser parseData:mymaster];
        NAMasterBaseClass *masterBaseClass = [NAMasterBaseClass modelObjectWithDictionary:dic];
        [NASaveData sharedInstance].masterArray = masterBaseClass.masterData.publishers.publisherGroupInfo;
        [self currentUserHaveNotes:masterBaseClass];
        
        [[NADownloadHelper sharedInstance] initSokuhoTask:masterBaseClass];
        NSArray *publisherGroupInfos = masterBaseClass.masterData.publishers.publisherGroupInfo;
        self.publisherInfoArray = [NSMutableArray array];
        for (NAPublisherGroupInfo *publisherGroupInfo in publisherGroupInfos) {
            for (NAPublisherInfo *publisherInfo in publisherGroupInfo.publisherInfo) {
                [self.publisherInfoArray addObject:publisherInfo];
                
                if (!self.homeToolBar.ishavesokuho) {
                    for (NAPublicationInfo *publication in publisherInfo.publicationInfo) {
                        if(publication.content.genrearray.count>0){
                            self.homeToolBar.ishavesokuho=YES;
                            self.isHavesokuho=YES;
                            break;
                        }
                    }
                }
            }
        }
        if (([self.forwardPage isEqualToString:@"topPage_noUserid"]||[self.forwardPage isEqualToString:@"topPage"])&&self.topPageDoc!=nil) {
            if ([NASaveData getIsVisitorModel]) {
                [self searchCurrentApi:self.topPageDoc ByUserid:[NASaveData getDefaultUserID]];
            }else{
                [self searchCurrentApi:self.topPageDoc ByUserid:[NASaveData getDefaultUserID]];
            }
            
        }else{
            [self offlineSearchFirstPage];
        }
    }
    
}

- (void)currentUserHaveNotes:(NAMasterBaseClass *)masterBaseClass
{
    if ([NACheckNetwork sharedInstance].isHavenetwork){
        NSDictionary *param = @{
                                @"Userid"     :  [NASaveData getDefaultUserID],
                                @"UseDevice"  :  NAUserDevice,
                                @"Rows"       :  @"1",
                                @"K002"       :  @"4",
                                @"Model"      :  @"2"
                                };
        
        [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
            if (!error) {
                
                SHXMLParser *parser = [[SHXMLParser alloc] init];
                NSDictionary *dic = [parser parseData:search];
                NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                self.isHaveNote =  searchBaseClass.response.header.numFound.integerValue > 0 ? YES : NO;
                
                NSDictionary *alluserdic=[NASaveData getALLUser];
                NSDictionary *valuedic=[alluserdic objectForKey:[NASaveData getLoginUserId]];
                NSMutableDictionary *changevaluedic=[NSMutableDictionary dictionaryWithDictionary:valuedic];
                [changevaluedic setObject:[NSNumber numberWithBool:self.isHaveNote] forKey:ishavenote];
                
                NSMutableDictionary *changealluser=[NSMutableDictionary dictionaryWithDictionary:alluserdic];
                [changealluser setObject:changevaluedic forKey:[NASaveData getDefaultUserID]];
                [NASaveData saveALLUser:changealluser];
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //[self updateToolbar];
                });
            }else{
                ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
                [ProgressHUD dismiss];
            }
            
        }];
    }else{
        
        
        NSDictionary *alluserdic=[NASaveData getALLUser];
        NSDictionary *valuedic=[alluserdic objectForKey:[NASaveData getLoginUserId]];
        
        NSNumber *myhavenote=[valuedic objectForKey:ishavenote];
        self.isHaveNote=myhavenote.boolValue;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self updateToolbar];
        });
        
    }
}
//offline search
- (void)offlineSearchFirstPage{
    NSArray *array=[[NASQLHelper sharedInstance]getPaperInfoByUserId:[NASaveData getLoginUserId] ];
    self.searchPublicationArray = [[NSMutableArray alloc ]initWithArray:array];
    if (self.searchPublicationArray.count > 0) {
        NADoc *doc = self.searchPublicationArray[0];
        [self searchCurrentApi:doc ByUserid:[NASaveData getDefaultUserID]];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD dismiss];
//            [[[iToast makeText:NSLocalizedString(@"NO Page", nil)]
//              setGravity:iToastGravityBottom] show];
            //[self toSettingViewContreller];
            
        });
        
    }
    
}
//search
-(void)getSearchAPIWithMaster:(NAMasterBaseClass *)masterBaseClass
{
    //    NSLog(@"getSearchAPIWithMaster") ;
    self.homeToolBar.ishavesokuho=NO;
    self.isHavesokuho=NO;
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
//    [ProgressHUD shared].label.text=NSLocalizedString(@"messageloading", nil);
    NSString *K004 = @"";
    NSString *K005 = @"";
    NSString *K006 = @"";
    
    NADoc *myCurrentDoc=[NASaveData getCurrentDoc];
    if (myCurrentDoc) {
        K004 = myCurrentDoc.publisherGroupInfoId;
        K005 = myCurrentDoc.publisherInfoId;
        K006 = myCurrentDoc.publicationInfoId;
        
        NSDictionary *param = @{
                                @"Userid"     :  [NASaveData getDefaultUserID],
                                @"UseDevice"  :  NAUserDevice,
                                @"K090"       :  @"010",
                                @"Rows"       :  @"1",
                                @"K003"       :  [NSString stringWithFormat:@"20000101:%@",[Util getSystemDate]],
                                @"K004"       :  K004,
                                @"K005"       :  K005,
                                @"K006"       :  K006,
                                @"K002"       :  @"2",
                                @"Mode"       :  @"1",
                                @"Sort"       :  @"K003:desc,K032:desc,K006:asc",
                                @"Fl"         :  [NSString searchWithPublicationInfoId]
                                };
        [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
            if (!error) {
                SHXMLParser *parser = [[SHXMLParser alloc] init];
                NSDictionary *dic = [parser parseData:search];
                NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                if (searchBaseClass.response.doc.count > 0) {
                    NADoc *tmpdoc=searchBaseClass.response.doc[0];
                    tmpdoc.publication_disOrder1=myCurrentDoc.publication_disOrder1;
                    tmpdoc.publication_disOrder3=myCurrentDoc.publication_disOrder3;
                    [self.searchPublicationArray addObject:tmpdoc];
                    [self searchFirstPage];
                }else{
                    [self doSearchMaster:masterBaseClass];
                }
                
            }else{
                [self doSearchMaster:masterBaseClass];
            }
        }];
    }else{
        [self doSearchMaster:masterBaseClass];
    }
}
-(void)doSearchMaster:(NAMasterBaseClass *)masterBaseClass{
    __block NSInteger apiCount = 0;
    NSArray *publisherGroupInfos = masterBaseClass.masterData.publishers.publisherGroupInfo;
    self.publisherInfoArray = [NSMutableArray array];
    for (NAPublisherGroupInfo *publisherGroupInfo in publisherGroupInfos) {
        for (NAPublisherInfo *publisherInfo in publisherGroupInfo.publisherInfo) {
            [self.publisherInfoArray addObject:publisherInfo];
        }
    }
    
    NSString *K004 = @"";
    NSString *K005 = @"";
    NSString *K006 = @"";
    
    for (NAPublisherGroupInfo *publishergroupInfo in publisherGroupInfos) {
        K004 = publishergroupInfo.publisherGroupInfoIdentifier;
        NSArray *array = publishergroupInfo.publisherInfo;
        for (NAPublisherInfo *publisherInfo in array) {
            K005 = publisherInfo.publisherInfoIdentifier;
            for (NAPublicationInfo *publication in publisherInfo.publicationInfo) {
                if(publication.content.genrearray.count>0){
                    self.homeToolBar.ishavesokuho=YES;
                    self.isHavesokuho=YES;
                }
                K006 = publication.publicationInfoIdentifier;
                
                NSDictionary *param = @{
                                        @"Userid"     :  [NASaveData getDefaultUserID],
                                        @"UseDevice"  :  NAUserDevice,
                                        @"K090"       :  @"010",
                                        @"Rows"       :  @"1",
                                        @"K003"       :  [NSString stringWithFormat:@"20000101:%@",[Util getSystemDate]],
                                        @"K004"       :  K004,
                                        @"K005"       :  K005,
                                        @"K006"       :  K006,
                                        @"K002"       :  @"2",
                                        @"Mode"       :  @"1",
                                        @"Sort"       :  @"K003:desc,K032:desc,K006:asc",
                                        @"Fl"         :  [NSString searchWithPublicationInfoId]
                                        };
                apiCount = apiCount + 1;
                [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
                    if (!error) {
                        apiCount = apiCount - 1;
                        SHXMLParser *parser = [[SHXMLParser alloc] init];
                        NSDictionary *dic = [parser parseData:search];
                        NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                        if (searchBaseClass.response.doc.count > 0) {
                            NADoc *tmpdoc=searchBaseClass.response.doc[0];
                            tmpdoc.publication_disOrder1=publication.dispOrder1;
                            tmpdoc.publication_disOrder3=publication.dispOrder3;
                            [self.searchPublicationArray addObject:tmpdoc];
                            
                        }
                        if (apiCount == 0) {
                            [self searchFirstPage];
                        }else {
                            
                        }
                    }else{
                        ITOAST_BOTTOM(error.localizedDescription);
                        [ProgressHUD dismiss];
                    }
                }];
            }
        }
    }
    
}
- (void)searchFirstPage
{
//    NSSortDescriptor *sortDescriptor3 = [[NSSortDescriptor alloc] initWithKey:@"publication_disOrder1" ascending:YES];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"publishDate" ascending:NO];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"lastUpdateDateAndTime" ascending:NO];
//    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"publicationInfoId" ascending:YES];
    [self.searchPublicationArray sortUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil]];
    if (self.searchPublicationArray.count > 0) {
        if (([self.forwardPage isEqualToString:@"topPage_noUserid"]||[self.forwardPage isEqualToString:@"topPage"])&&self.topPageDoc!=nil) {
            if ([NASaveData getIsVisitorModel]) {
                [self searchCurrentApi:self.topPageDoc ByUserid:[NASaveData getDefaultUserID]];
                //[self searchCurrentApiChange:self.topPageDoc ByUserid:[NASaveData getDefaultUserID]];
            }else{
                [self searchCurrentApi:self.topPageDoc ByUserid:[NASaveData getDefaultUserID]];
                //[self searchCurrentApiChange:self.topPageDoc ByUserid:[NASaveData getDefaultUserID]];
            }
            
        }else{
            
            NADoc *doc = self.searchPublicationArray[0];
            [self searchCurrentApi:doc ByUserid:[NASaveData getDefaultUserID]];
            //[self searchCurrentApiChange:doc ByUserid:[NASaveData getDefaultUserID]];
        }
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD dismiss];
//            [[[iToast makeText:NSLocalizedString(@"NO Page", nil)]
//              setGravity:iToastGravityBottom] show];
            //[self toSettingViewContreller];
        });
        
    }
    if ([NASaveData getFirstDownload]==1) {
        self.forwardPage=@"sukuho";
    }
}
    //所有的检索
- (void)searchCurrentApiChange:(NADoc *)doc ByUserid:(NSString *)myUserid
    {
        
        // 全紙面を検索
        NSDictionary *param = @{
                                @"K008"       :  doc.editionInfoId,
                                @"Userid"     :  myUserid,
                                @"UseDevice"  :  NAUserDevice,
                                @"Rows"       :  @"100",
                                @"K004"       :  doc.publisherGroupInfoId,
                                @"K003"       :  [NSString stringWithFormat:@"%@:%@",doc.publishDate,doc.publishDate],
                                @"K006"       :  doc.publicationInfoId,
                                @"K005"       :  doc.publisherInfoId,
                                @"K014"       :  @"1",
                                @"K002"       :  @"2",
                                @"Mode"       :  @"1",
                                @"Sort"       :  @"K006:asc,K090:asc,K012:asc",
                                @"Fl"         :  [NSString searchCurrentFl],
                                };
        [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
            
            if (!error) {
                SHXMLParser *parser = [[SHXMLParser alloc] init];
                NSDictionary *dic = [parser parseData:search];
                NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                NSArray *docArr = searchBaseClass.response.doc;
                _regionDic = [[NSMutableDictionary alloc]init];
                //相同的pageno的不同地域版合集
                for (int i = 0; i < docArr.count; i++) {
                    NSMutableArray *mianArray= [[NSMutableArray alloc]init];
                    for(NADoc *doc in docArr) {
                        if ([doc.pageno hasPrefix:@"0"]) {
                            if (i == [doc.pageno substringWithRange:NSMakeRange(1, 1)].integerValue) {
                                [mianArray addObject:doc];
                                
                            }
                        }else{
                            if (i == doc.pageno.integerValue) {
                                [mianArray addObject:doc];
                                
                            }
                        }
                        
                        
                    }
                    if (mianArray.count != 0) {
                        [_regionDic setObject:mianArray forKey:[NSString stringWithFormat:@"%d",i]];
                    }
                    
                    
                }
                NSLog(@"%lu",(unsigned long)_regionDic.allKeys.count);
            }else{
                ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
                [ProgressHUD dismiss];
            }
        }];
        
        
}
    //地域版全纸面检索
- (void)searchCurrentApi:(NADoc *)doc ByUserid:(NSString *)myUserid
{
    [self searchCurrentApiChange:doc ByUserid:myUserid];
    [self.mainScrollView removeFromSuperview];
    isDoneImageTask=NO;
    _mainScrollView = nil;
    _mainScrollView = self.mainScrollView;
    
    if (!self.homeToolBar.isHidden) {
        MAIN(^{
            if ([NASaveData isAlldownload]) {
                [self.progressViewBar setHidden:NO];
            }else{
                [self.progressViewBar setHidden:YES];
            }
        });
        
    }
    
    [_progressViewBar setProgressNum:0.0f];
    [_progressViewBar setTitleText:@""];
    
    [[NADownloadHelper sharedInstance] cancel];
    [[NADownloadHelper sharedInstance] initImageTask];
    
    if ([NACheckNetwork sharedInstance].isHavenetwork){
        
        // 1~5紙面mini imageをdownload see the MSearchcondition.h
        NSDictionary *param = @{
                                @"K008"       :  doc.editionInfoId,
                                @"Userid"     :  myUserid,
                                @"UseDevice"  :  NAUserDevice,
                                @"Rows"       :  [NSString stringWithFormat:@"%ld", (long)firstDownloadNum],
                                @"K004"       :  doc.publisherGroupInfoId,
                                @"K003"       :  [NSString stringWithFormat:@"%@:%@",doc.publishDate,doc.publishDate],
                                @"K006"       :  doc.publicationInfoId,
                                @"K005"       :  doc.publisherInfoId,
                                @"K014"       :  @"1",
                                @"K002"       :  @"2",
                                @"Mode"       :  @"1",
                                @"Sort"       :  @"K006:asc,K090:asc,K012:asc",
                                @"Fl"         :  [NSString searchCurrentFl]
                                };
        [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
            
            if (!error) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    SHXMLParser *parser = [[SHXMLParser alloc] init];
                    NSDictionary *dic = [parser parseData:search];
                    NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                    
                    if (searchBaseClass.response.doc&&searchBaseClass.response.doc.count>0) {
                        // 紙面image
                        [[NADownloadHelper sharedInstance] downloadThumb:searchBaseClass.response.doc index:0];
                        
                        //　記事
                        if ([NASaveData isHaveNote]) {
                            [[NADownloadHelper sharedInstance] downloadNote:searchBaseClass.response.doc start:0 end: searchBaseClass.response.doc.count isSetInDoc:FALSE];
                        }
                    }
                });
            }
        }];
        // 全紙面を検索
        param = @{
                  @"K008"       :  doc.editionInfoId,
                  @"Userid"     :  myUserid,
                  @"UseDevice"  :  NAUserDevice,
                  @"Rows"       :  @"100",
                  @"K004"       :  doc.publisherGroupInfoId,
                  @"K003"       :  [NSString stringWithFormat:@"%@:%@",doc.publishDate,doc.publishDate],
                  @"K006"       :  doc.publicationInfoId,
                  @"K005"       :  doc.publisherInfoId,
                  @"K014"       :  @"1",
                  @"K002"       :  @"2",
                  @"Mode"       :  @"1",
                  @"Sort"       :  @"K006:asc,K090:asc,K012:asc",
                  @"Fl"         :  [NSString searchCurrentFl],
                  @"K081"       :  @"30000",
                  };
        doc.user_id=[NASaveData getLoginUserId];
        if (![[NASQLHelper sharedInstance]isHavePaperInfoByDoc:doc]) {
            [[NASQLHelper sharedInstance]addPaperInfo:doc];
        }
        
        [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
            
            if (!error) {
                SHXMLParser *parser = [[SHXMLParser alloc] init];
                NSDictionary *dic = [parser parseData:search];
                NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                if (searchBaseClass.response.doc==nil||searchBaseClass.response.doc.count<=0) {
                    NADoc *doc = self.searchPublicationArray[0];
                    [self searchCurrentApi:doc ByUserid:[NASaveData getDefaultUserID]];
                    return ;
                }
                // 紙面XMLを格納
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [[NAFileManager sharedInstance] saveSearchFileWithData:search Mydoc:doc];
                });
                
                // 紙面情報初期化
                [self.pageArray removeAllObjects];
                [self.pageArray addObjectsFromArray:searchBaseClass.response.doc];
                [NADownloadHelper sharedInstance].docs=self.pageArray;
                
                
//                [self.pageArray removeAllObjects];
//                NSInteger dicCount= _regionDic.allKeys.count;
//                for (int i = 1; i < dicCount+1; i++) {
//                    NSArray *arr = [_regionDic objectForKey:[NSString stringWithFormat:@"%d",i]];
//                    if (arr.count == 1) {
//                        [self.pageArray addObject:[arr objectAtIndex:0]];
//                    }else{
//                        for(int i = 0; i < arr.count; i++) {
//                            NADoc *doc = [arr objectAtIndex:i];
//                            NSString *area = doc.releaseAreaInfo;
//                            if (area.length != 0) {
//                                if ([area isEqualToString:areaCode]) {
//                                    [_pageArray addObject:[arr objectAtIndex:i]];
//                                }else{
//                                    [localPageArr addObject:[arr objectAtIndex:i]];
//                                }
//                            }
//                            
//                        }
//                    }
//                }
                
                
                // 紙面 download task始め
                BACK(^{
                    NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
                    
                    if ([NASaveData getFirstDownload] == 1) {
                        [tmpdic setObject:NASOKUHO forKey:@"downloadtype"];
                        [tmpdic setObject:@"" forKey:@"genreId"];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadSokuhoTask" object:nil userInfo:tmpdic];
                    }
                    
                    // 紙面
                    if ([NASaveData getFirstDownload] != 1) {
                        [tmpdic setObject:NAThumbimage forKey:@"downloadtype"];
                        [tmpdic setObject:[NSNumber numberWithInteger:firstDownloadNum] forKey:@"imageindex"];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadImageTask" object:nil userInfo:tmpdic];
                    }
                });
                
                // 画面表示
                [self showMainView];
                if (![NASaveData getIsVisitorModel]) {
                    [NASaveData saveCurrentDoc:doc];
                }
                
                
                //　記事
                if ([NASaveData isHaveNote]) {
                    [[NADownloadHelper sharedInstance] downloadNote:self.pageArray start:firstDownloadNum end:self.pageArray.count isSetInDoc:FALSE];
                }
//                [self getNoteAPI];
            }else{
                ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
                [ProgressHUD dismiss];
            }
        }];
        
    }else{
//        MAIN(^{
//            ITOAST_BOTTOM(NSLocalizedString(@"networkerror", nil));
//        });
        NSData *mydata=[[NAFileManager sharedInstance] readSearchFileWithdoc:doc];
        
        if (mydata) {
            SHXMLParser *parser = [[SHXMLParser alloc] init];
            NSDictionary *dic = [parser parseData:mydata];
            NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
            
            
            // 紙面情報初期化
            [self.pageArray removeAllObjects];
            [self.pageArray addObjectsFromArray:searchBaseClass.response.doc];
            
            [NADownloadHelper sharedInstance].docs=self.pageArray;
            
            // download task始め
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
                [tmpdic setObject:NAThumbimage forKey:@"downloadtype"];
                [tmpdic setObject:[NSNumber numberWithInteger:firstDownloadNum] forKey:@"imageindex"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadImageTask" object:nil userInfo:tmpdic];
            });
            
            // 画面表示
            [self showMainView];
            MAIN(^{
                [ProgressHUD dismiss];
            });
//            [self getNoteAPI];
        }else{
            [self showMainView];
            MAIN(^{
                [ProgressHUD dismiss];
            });
        }
        
    }
}

/**
 * main画面を表示
 *
 */
-(void)showMainView{
    if (self.pageArray.count<=0) {
        //[self toSettingViewContreller];
        return;
    }
    // 画面にmainScrollViewを追加
    [self.view addSubview:self.mainScrollView];
    [self.view sendSubviewToBack:self.mainScrollView];
    
    NSLog(@"mainScrollView show") ;
    NSInteger tempPageIndex = 0;
    
    if ([self isLandscape]) {
        // 2紙面を表示
        NSArray *pages = [self padLandscapeCount];
        if (pages.count > 0) {
            tempPageIndex = pages.count - 1;
        }
    }else{
        // 1紙面を表示
        if (self.pageArray.count > 0) {
            tempPageIndex = self.pageArray.count - 1;
            
        }
    }
    
    // 第１面を表示
    self.mainScrollView.currentItemIndex = tempPageIndex;
    [self.mainScrollView scrollToItemAtIndex: tempPageIndex duration:0];
    
    // 後処理
    [self swipeViewCurrentItemIndexDidChange:self.mainScrollView];
    [self swipeViewDidEndDecelerating:self.mainScrollView];
    
    if ([self isLogin]) {
        if (self.pageArray.count == 1) {
            self.mainScrollView.wrapEnabled = NO;
            self.mainScrollView.scrollEnabled = NO;
        }
    }else{
        self.mainScrollView.wrapEnabled = NO;
        self.mainScrollView.scrollEnabled = NO;
    }
    _toolBarStyle = 0;
    if ([self isLandscape]) {
        _riliView.hidden = YES;
        [self setHorToolBar];
    }else{
        [self resetRiliview];
        _riliView.hidden = NO;
        [self resetHomeToolBar];
        
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([self isLogin]) {
        [button setBackgroundImage:[UIImage imageNamed:@"06_blue"]
                          forState:UIControlStateNormal];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"06_glay"]
                          forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(searchBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 25, 25);
    _searchBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = _searchBarItem;
    
    [self updateViews];
    [ProgressHUD dismiss];
    [_mylogoview removeFromSuperview];
    
    
    
    
}

#pragma mark - SwipeView Delegate -
#pragma mark
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    NSInteger count = [self isLandscape] ? [self padLandscapeCount].count :[self.pageArray count];
    return count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //        NSLog(@"swipeView index %d currentItemIndex %d",index, self.mainScrollView.currentItemIndex);
    
    
    BOOL isTwoPage = NO;
    if ([self isLandscape]) {
        NSArray *pageSort = [self padLandscapeCount];
        NSInteger landCount = pageSort.count;
        NSArray *sort = pageSort[landCount - 1 - index];
        isTwoPage = sort.count == 2 ? YES : NO;
    }
    NASubImageScrollView *imageScroll = (NASubImageScrollView *)view;
    if (!imageScroll) {
        imageScroll = [[NASubImageScrollView alloc] initWithFrame:self.mainScrollView.bounds];
        view = imageScroll;
    }
    
    imageScroll.frame = self.mainScrollView.bounds;
    imageScroll.imageView.isTwoPage = isTwoPage;
    imageScroll.delegate=self;
    imageScroll.imageView.isPadLandscape = [self isLandscape];
    //    imageScroll.backgroundColor = [UIColor whiteColor];
    imageScroll.opaque = YES;
    imageScroll.tag = index + 1;
    [imageScroll setZoomScale:1];
    imageScroll.bounces = NO;
    imageScroll.largeModel = NAImageModelNone;
    imageScroll.noteDetailBlock = ^(NSArray *array, NSInteger index) {
        [self toNoteDetailViewController:array index:index];
    };
    
    if (![self isLandscape]) {
        NSString *myratestr=[NASaveData getExpansion_rate];
        NSArray *ratearray=[myratestr componentsSeparatedByString:@","];
        imageScroll.minimumZoomScale = [[ratearray objectAtIndex:0]floatValue];
        imageScroll.maximumZoomScale = [[ratearray objectAtIndex:3]floatValue];
        imageScroll.landscapekei=1;
        
        NSInteger count = self.pageArray.count;
        NADoc *doc = self.pageArray[count - 1 - index];
        [self setRiliTitle:doc withOther:nil];
        if ([doc.whichimage isEqualToString:NANormalimage]||[doc.whichimage isEqualToString:NALargeimage]) {
            [imageScroll LoadingNormalImageView:doc other:nil];
        }else{
            [imageScroll LoadingThumbImageView:doc other:nil];
        }
        
        
        if ([NASaveData isHaveNote] && index == count - 1) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [imageScroll getNoteLayerWithDoc:doc other:nil];
            });
        }
        
    }else{
        NSString *myratestr=[NASaveData getExpansion_rate];
        NSArray *ratearray=[myratestr componentsSeparatedByString:@","];
        imageScroll.minimumZoomScale = [[ratearray objectAtIndex:0]floatValue];
        imageScroll.maximumZoomScale = [[ratearray objectAtIndex:3]floatValue]*[NASaveData getLandscapekei];
        imageScroll.landscapekei=[NASaveData getLandscapekei];
        
        NSArray *pageSort = [self padLandscapeCount];
        NSInteger landCount = pageSort.count;
        NSArray *sort = pageSort[landCount - 1 - index];
        
        if (sort.count == 1) {
            NSNumber *aDocIndex = sort[0];
            NADoc *doc = self.pageArray[aDocIndex.integerValue];
            [self setRiliTitle:doc withOther:nil];
            if ([doc.whichimage isEqualToString:NANormalimage]||[doc.whichimage isEqualToString:NALargeimage]) {
                [imageScroll LoadingNormalImageView:doc other:nil];
            }else{
                [imageScroll LoadingThumbImageView:doc other:nil];
            }
            
            if ([NASaveData isHaveNote] && index == landCount - 1) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [imageScroll getNoteLayerWithDoc:doc other:nil];
                });
            }
        }else{
            NSNumber *aDocIndex = sort[0];
            NSNumber *otherDocIndex = sort[1];
            NADoc *doc = self.pageArray[aDocIndex.integerValue];
            NADoc *other =  self.pageArray[otherDocIndex.integerValue];
            [self setRiliTitle:doc withOther:other];
            if ([doc.whichimage isEqualToString:NANormalimage]||[doc.whichimage isEqualToString:NALargeimage]||[other.whichimage isEqualToString:NANormalimage]||[other.whichimage isEqualToString:NALargeimage]) {
                [imageScroll LoadingNormalImageView:doc other:other];
            }else{
                [imageScroll LoadingThumbImageView:doc other:other];
            }
            //[imageScroll LoadingThumbImageView:doc other:other];
            
            if ([NASaveData isHaveNote] && index == landCount - 1) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [imageScroll getNoteLayerWithDoc:doc other:other];
                });
            }
        }
    }
    
    _toolBarStyle = 0;
    if ([self isLandscape]) {
        [self setHorToolBar];
    }else{
        [self resetHomeToolBar];
    }

    return view;
}

-(BOOL)isHaveImageWithDocAndType:(NADoc *)doc Type:(NSString *)type
{
    NSString *path = [[NAFileManager sharedInstance] searchPathWithFileName:doc withImageName:type];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    return [fileManage fileExistsAtPath:path isDirectory:FALSE];
}
- (void)loginSuccess{
    if ([self isLandscape]) {
        _riliView.hidden = YES;
        [self setHorToolBar];
    }else{
        [self resetRiliview];
        [self resetHomeToolBar];
        _riliView.hidden = NO;
    }
    if ([self isLogin]) {
        [_btnChooseDay setImage:[UIImage imageNamed:@"08_blue"] forState:UIControlStateNormal];
    }else{
        [_btnChooseDay setImage:[UIImage imageNamed:@"08_glay"] forState:UIControlStateNormal];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([self isLogin]) {
        [button setBackgroundImage:[UIImage imageNamed:@"06_blue"]
                          forState:UIControlStateNormal];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"06_glay"]
                          forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(searchBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 25, 25);
    _searchBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = _searchBarItem;
}
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    
    //pasue timer
    [myhidebartimer setFireDate:[NSDate distantFuture]];
    currentdate=nil;
    NASubImageScrollView *view = (NASubImageScrollView *)[swipeView itemViewAtIndex:swipeView.currentItemIndex];
    [view.imageView.noteView clearNote];
    
    if (!isChangeScreen) {
        
        currentZoom=view.zoomScale;
    }
    
    NSInteger count = self.pageArray.count;
    if (count - 1 - swipeView.currentItemIndex>=count||count<=0) {
        return;
    }
    if (![self isLandscape]) {
        NADoc *doc = self.pageArray[count - 1 - swipeView.currentItemIndex];
        [self setRiliTitle:doc withOther:nil];
        [view.imageView updateFrame4Image:view.bounds];
    }else{
        NSArray *pageSort = [self padLandscapeCount];
        NSInteger landCount = pageSort.count;
        NSArray *sort = pageSort[landCount - 1 - swipeView.currentItemIndex];
        
        if (sort.count == 1) {
            NSNumber *aDocIndex = sort[0];
            NADoc *doc = self.pageArray[aDocIndex.integerValue];
            [self setRiliTitle:doc withOther:nil];
            [view.imageView updateFrame4Image:view.bounds];
        }else{
            NSNumber *aDocIndex = sort[0];
            NSNumber *otherDocIndex = sort[1];
            NADoc *doc = self.pageArray[aDocIndex.integerValue];
            NADoc *other =  self.pageArray[otherDocIndex.integerValue];
            [self setRiliTitle:doc withOther:other];
            [view.imageView updateFrame4Image:view.bounds];
            
        }
    }
}
- (void)swipeViewWillBeginDragging:(SwipeView *)swipeView
{
    NASubImageScrollView *view = (NASubImageScrollView *)[swipeView itemViewAtIndex:swipeView.currentItemIndex];
    if (view.zoomScale<1) {
        [view setZoomScale:1];
        return;
    }else if(view.zoomScale>view.maximumZoomScale){
        [view setZoomScale:view.maximumZoomScale];
        currentZoom=view.zoomScale;
        return;
    }
    
}

/**
 * load紙面後処理
 *
 */
- (void)swipeViewDidEndDecelerating:(SwipeView *)swipeView
{
    btnView.hidden = YES;
    localBtn.hidden = YES;
    btnView2.hidden = YES;
    localBtn2.hidden = YES;
    //    NSLog(@"swipeViewDidEndDecelerating %d",swipeView.currentItemIndex);
    
    // 変量初期化
    NADoc *doc = nil;
    NADoc *otherDoc = nil;
    NSInteger count = 0;
    NSInteger imageIndex = 0;
    NSInteger otherImageIndex = 0;
    __block BOOL isRightPage=NO;
    
    // viewを取得
    NASubImageScrollView *view = (NASubImageScrollView *)[swipeView itemViewAtIndex:swipeView.currentItemIndex];
    if (view==nil) {
        return;
    }
    // 紙面情報を編集
    if (![self isLandscape]) {
        count = self.pageArray.count;
        
        imageIndex = count - 1 - swipeView.currentItemIndex;
        if (imageIndex<0) {
            return;
        }
        doc = self.pageArray[imageIndex];
        [self setRiliTitle:doc withOther:nil];
        NSArray *pages = [self padLandscapeCount];
        verticalCurrentPageIndex=imageIndex;
        if (pages.count > 0) {
            istwo = [self iscurrentTwoIndex:verticalCurrentPageIndex];
        }
        if (doc.regionViewFlg == nil || [doc.regionViewFlg isEqualToString:@""]) {
            local1 = 0;
            local2 = 0;
            btnView.hidden = YES;
            localBtn.hidden = YES;
        }else{
            if ([doc.regionViewFlg isEqualToString:@"1"]) {
                btnView.hidden = NO;
                localBtn.hidden = NO;
                [localBtn setTitle:[NSString stringWithFormat:@"地方版 %@",doc.pageInfoName] forState:UIControlStateNormal];
                if ([doc.pageno hasPrefix:@"0"]) {
                    NSString *index = [doc.pageno substringWithRange:NSMakeRange(1, 1)];
                    regionArr = [_regionDic objectForKey:index];
                }else{
                    regionArr = [_regionDic objectForKey:doc.pageno];
                }
                local1 = 1;
                local2 = 0;
            }else{
                local1 = 0;
                local2 = 0;
                btnView.hidden = YES;
                localBtn.hidden = YES;
            }
        }
        
        
    } else {
        count = [[self padLandscapeCount] count];
        
        NSArray *twoPageArray = [self padLandscapeCount];
        NSArray *curPageArray = twoPageArray[count - 1 - swipeView.currentItemIndex];
        
        imageIndex = ((NSNumber *)curPageArray[0]).integerValue;
        doc = self.pageArray[imageIndex];
        if (curPageArray.count > 1) {
            //2面
            otherImageIndex = ((NSNumber *)curPageArray[1]).integerValue;
            otherDoc = self.pageArray[otherImageIndex];
            [self setRiliTitle:doc withOther:otherDoc];
            NADoc *tmpdoc = self.pageArray[verticalCurrentPageIndex];
            if ([tmpdoc isEqual:doc]) {
                isRightPage=YES;
                
            }
            if (doc.regionViewFlg == nil || [doc.regionViewFlg isEqualToString:@""]) {
                local1 = 0;
                btnView.hidden = YES;
                localBtn.hidden = YES;
            }else{
                if ([doc.regionViewFlg isEqualToString:@"1"]) {
                    btnView.hidden = NO;
                    localBtn.hidden = NO;
                    [localBtn setTitle:[NSString stringWithFormat:@"地方版 %@",doc.pageInfoName] forState:UIControlStateNormal];
                    if ([doc.pageno hasPrefix:@"0"]) {
                        NSString *index = [doc.pageno substringWithRange:NSMakeRange(1, 1)];
                        regionArr = [_regionDic objectForKey:index];
                    }else{
                        regionArr = [_regionDic objectForKey:doc.pageno];
                    }
                    local1 = 1;
                }else{
                    local1 = 0;
                    btnView.hidden = YES;
                    localBtn.hidden = YES;
                }
            }
            
            if (otherDoc.regionViewFlg == nil || [otherDoc.regionViewFlg isEqualToString:@""]) {
                local1 = 0;
                btnView.hidden = YES;
                localBtn.hidden = YES;
            }else{
                if ([otherDoc.regionViewFlg isEqualToString:@"1"]) {
                    btnView2.hidden = NO;
                    localBtn2.hidden = NO;
                    [localBtn2 setTitle:[NSString stringWithFormat:@"地方版 %@",otherDoc.pageInfoName] forState:UIControlStateNormal];
                    if ([otherDoc.pageno hasPrefix:@"0"]) {
                        NSString *index = [otherDoc.pageno substringWithRange:NSMakeRange(1, 1)];
                        regionArr2 = [_regionDic objectForKey:index];
                    }else{
                        regionArr2 = [_regionDic objectForKey:doc.pageno];
                    }
                    local2 = 1;
                }else{
                    local2 = 0;
                    btnView2.hidden = YES;
                    localBtn2.hidden = YES;
                }
            }
            
            
            
        }else{
            [self setRiliTitle:doc withOther:nil];
            //1面
            if (doc.regionViewFlg == nil || [doc.regionViewFlg isEqualToString:@""]) {
                local1 = 0;
                local2 = 0;
                btnView.hidden = YES;
                localBtn.hidden = YES;
            }else{
                if ([doc.regionViewFlg isEqualToString:@"1"]) {
                    btnView.hidden = NO;
                    localBtn.hidden = NO;
                    [localBtn setTitle:[NSString stringWithFormat:@"地方版 %@",doc.pageInfoName] forState:UIControlStateNormal];
                    if ([doc.pageno hasPrefix:@"0"]) {
                        NSString *index = [doc.pageno substringWithRange:NSMakeRange(1, 1)];
                        regionArr = [_regionDic objectForKey:index];
                    }else{
                        regionArr = [_regionDic objectForKey:doc.pageno];
                    }
                    local1 = 1;
                    local2 = 0;
                }else{
                    local1 = 0;
                    local2 = 0;
                    btnView.hidden = YES;
                    localBtn.hidden = YES;
                }
            }
            
        }
        
    }
    
    self.currentPageIndex = count - 1 - swipeView.currentItemIndex;
    
    
    // load記事
    if ([NASaveData isHaveNote]) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [view getNoteLayerWithDoc:doc other:otherDoc];
            //NSLog(@"currentZoom==%f",currentZoom);
            if (curNoteIndexNo) {
                AFTER(0.5, ^{
                    
                    [view showNoteViewByIndexNo:curNoteIndexNo];
                    curNoteIndexNo = nil;
                    curPaperIndexNo = nil;
                    
                });
            }
            
            
        });
    }
    
    //    BACK(^{
    //        MAIN(^{
    //            [self ChangeThePointAndZoomWithByMyView:view WithTheDoc:doc WithIsRightPage:isRightPage];
    //        });
    //
    //    });
    
    
    // load中紙面
    NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
    [tmpdic setObject:NANormalimage forKey:@"downloadtype"];
    
    if (otherDoc && [otherDoc.whichimage isEqualToString:NAThumbimage]) {
        if ([doc.whichimage isEqualToString:NAThumbimage]) {
            [tmpdic setObject:[NSNumber numberWithInteger:imageIndex] forKey:@"imageindex"];
            [tmpdic setObject:[NSNumber numberWithInteger:otherImageIndex] forKey:@"otherImageIndex"];
        } else {
            [tmpdic setObject:[NSNumber numberWithInteger:otherImageIndex] forKey:@"imageindex"];
        }
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadImageTask" object:nil userInfo:tmpdic];
    } else if ([doc.whichimage isEqualToString:NAThumbimage]) {
        [tmpdic setObject:[NSNumber numberWithInteger:imageIndex] forKey:@"imageindex"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadImageTask" object:nil userInfo:tmpdic];
    } else {
        if ([NASaveData getIsSwipeViewShowHighImage]) {
            if ([doc.whichimage isEqualToString:NALargeimage]) {
                [view LoadingTwoImageView:doc other:otherDoc];
            }else{
                [view LoadingNormalImageView:doc other:otherDoc];
                [tmpdic setObject:[NSNumber numberWithInteger:imageIndex] forKey:@"imageindex"];
                [tmpdic setObject:NALargeimage forKey:@"downloadtype"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadImageTask" object:nil userInfo:tmpdic];
            }
            
        }else{
            [view LoadingNormalImageView:doc other:otherDoc];
        }
        
    }
    view.largeModel = NAImageModelNone;
    // GA
    [TAGManagerUtil pushOpenScreenEvent:ENPageView ScreenName:[self getScreenName] ];
}
/*
 *Change Point And Zoom
 *
 */
-(void)ChangeThePointAndZoomWithByMyView:(NASubImageScrollView *)view WithTheDoc:(NADoc *)doc WithIsRightPage:(BOOL)isRightPage{
    if (isChangeScreen&&currentZoom>1) {
        NSArray *myimageSize = [doc.variableString31 componentsSeparatedByString:@","];
        CGFloat imageWith=[[myimageSize objectAtIndex:0]floatValue];
        CGFloat imageHeigt=[[myimageSize objectAtIndex:1]floatValue];
        
        CGFloat tempZoom=0;
        CGFloat myScreenWidth=[Util screenSize].width;
        if ([self isLandscape]) {
            // get landscape ratio
            CGFloat landscapeRatio=myScreenWidth/imageWith>[Util screenSize].height/imageHeigt ? [Util screenSize].height/imageHeigt:myScreenWidth/imageWith;
            // get verticalScreenRatio
            CGFloat verticalScreenRatio=[Util screenSize].height/imageWith>[Util screenSize].width/imageHeigt ? [Util screenSize].width/imageHeigt:[Util screenSize].height/imageWith;
            
            tempZoom=currentZoom*landscapeRatio/verticalScreenRatio;
            
        }else{
            // get verticalScreenRatio
            CGFloat verticalScreenRatio=[Util screenSize].width/imageWith>[Util screenSize].height/imageHeigt ? [Util screenSize].height/imageHeigt:[Util screenSize].width/imageWith;
            // get landscape ratio
            CGFloat landscapeRatio=[Util screenSize].height/imageWith>myScreenWidth/imageHeigt ? myScreenWidth/imageHeigt:[Util screenSize].height/imageWith;
            
            tempZoom=currentZoom*verticalScreenRatio/landscapeRatio;
        }
        
        //NSLog(@"tempZoom==%f",tempZoom);
        
        CGFloat tempX=currentPoint.x+[Util screenSize].width/2*tempZoom;
        CGPoint tmpPoint=CGPointZero;
        tmpPoint.x=tempX;
        tmpPoint.y=currentPoint.y;
        
        
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:1.0
              initialSpringVelocity:1
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [view setZoomScale:tempZoom];
                             if (isRightPage) {
                                 //NSLog(@"tmpPoint.x==%f,tmpPoint.y==%f",tmpPoint.x,tmpPoint.y);
                                 [view setContentOffset:tmpPoint];
                             }else{
                                 [view setContentOffset:currentPoint];
                             }
                             
                         }
                         completion:^(BOOL finished) {
                             
                             
                         }];
        
        
        
        isChangeScreen=NO;
        
    }
    
}
#pragma mark - UIScrollView Delegate -
#pragma mark
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!isChangeScreen) {
        CGPoint point=scrollView.contentOffset;
        currentPoint=point;
    }
}
/**
 * zoom処理中
 *
 */
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    if (scrollView.zoomScale<1) {
        [scrollView setZoomScale:1];
        currentZoom=scrollView.zoomScale;
        return;
    }else if(scrollView.zoomScale>scrollView.maximumZoomScale){
        [scrollView setZoomScale:scrollView.maximumZoomScale];
        currentZoom=scrollView.zoomScale;
        return;
    }
    
    if (scrollView.zoomScale>1) {
        if (currentdate==nil) {
            currentdate=[NSDate date];
            //start timer
            [myhidebartimer setFireDate:[NSDate distantPast]];
        }else{
            if ([Util getTimeDvalue:currentdate Date2:[NSDate date]]>=[NASaveData getBarShowInterval]) {
                //NSLog(@"getTimeDvalue ok");
                [UIView animateWithDuration:0.5 animations:^{
                    [self.homeToolBar setHidden:YES];
                    [self.progressViewBar setHidden:YES];
                } completion:^(BOOL finished) {
                    
                }];
            }
        }
        
    }
    
    NASubImageScrollView *view = (NASubImageScrollView *)[self.mainScrollView itemViewAtIndex:self.mainScrollView.currentItemIndex];
    
    
    
    // imageViewのframeを修正
    
    for (UIView *v in scrollView.subviews){
        if ([v isKindOfClass:NSClassFromString(@"NASubImageView")]) {
            CGRect rect = v.frame;
            rect.origin = CGPointZero;
            
            if (CGRectGetWidth(scrollView.frame) > CGRectGetWidth(v.frame)) {
                // imageviewの幅がscrollviewの幅より小さくなった == 1.0倍未満のズームが行われた
                rect.origin.x = (CGRectGetWidth(scrollView.frame) - CGRectGetWidth(v.frame))/2;
                rect.size.width=scrollView.frame.size.width;
            }
            
            if (CGRectGetHeight(scrollView.frame) > CGRectGetHeight(v.frame)) {
                // imageviewの高さがスクロールビューより小さくなった
                rect.origin.y = (CGRectGetHeight(scrollView.frame) - CGRectGetHeight(v.frame))/2;
                rect.size.height=scrollView.frame.size.height;
                
                
                
                
                
                
            }
            [view.imageView updateFrame4Zoom:rect];
        }
    }
    
    currentZoom=scrollView.zoomScale;
}

/**
 * zoom処理後
 *
 */
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)uiView atScale:(CGFloat)scale {
    NASubImageScrollView *view = (NASubImageScrollView *)[self.mainScrollView itemViewAtIndex:self.mainScrollView.currentItemIndex];
    if (view.largeModel != NAImageModelLoading && view.largeModel != NAImageModelDone) {
        NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
        NSInteger count = self.pageArray.count;
        [tmpdic setObject:NANormalimage forKey:@"downloadtype"];
        if (count != 0) {
            if ([self isLandscape]) {
                NSArray *pageSort = [self padLandscapeCount];
                NSInteger landCount = pageSort.count;
                NSArray *sort = pageSort[landCount - 1 - self.mainScrollView.currentItemIndex];
                if (sort.count == 1) {
                    NSNumber *aDocIndex = sort[0];
                    [tmpdic setObject:[NSNumber numberWithInteger:aDocIndex.integerValue] forKey:@"imageindex"];
                    
                    NADoc *doc = self.pageArray[aDocIndex.integerValue];
                    [self setRiliTitle:doc withOther:nil];
                    view.largeModel=NAImageModelLoading;
                    if ([doc.whichimage isEqualToString:NAThumbimage]) {
                        [tmpdic setObject:NANormalimage forKey:@"downloadtype"];
                    }else if ([doc.whichimage isEqualToString:NANormalimage] || [doc.whichimage isEqualToString:NALargeimage]){
                        [tmpdic setObject:NALargeimage forKey:@"downloadtype"];
                    }
                }else{
                    NSNumber *aDocIndex = sort[0];
                    NSNumber *otherDocIndex = sort[1];
                    NADoc *doc = self.pageArray[aDocIndex.integerValue];
                    NADoc *other =  self.pageArray[otherDocIndex.integerValue];
                    [self setRiliTitle:doc withOther:other];
                    view.largeModel=NAImageModelLoading;
                    
                    if ([doc.whichimage isEqualToString:NAThumbimage] && [other.whichimage isEqualToString:NAThumbimage]) {
                        [tmpdic setObject:NANormalimage forKey:@"downloadtype"];
                        [tmpdic setObject:[NSNumber numberWithInteger:aDocIndex.integerValue] forKey:@"imageindex"];
                        [tmpdic setObject:[NSNumber numberWithInteger:otherDocIndex.integerValue] forKey:@"otherImageIndex"];
                        
                    }else if ([doc.whichimage isEqualToString:NAThumbimage]) {
                        [tmpdic setObject:NANormalimage forKey:@"downloadtype"];
                        [tmpdic setObject:[NSNumber numberWithInteger:aDocIndex.integerValue] forKey:@"imageindex"];
                        
                    }else if ([other.whichimage isEqualToString:NAThumbimage]) {
                        [tmpdic setObject:NANormalimage forKey:@"downloadtype"];
                        [tmpdic setObject:[NSNumber numberWithInteger:otherDocIndex.integerValue] forKey:@"imageindex"];
                        
                    }
                    
                    if ((([doc.whichimage isEqualToString:NANormalimage] || [doc.whichimage isEqualToString:NALargeimage])
                         && ([other.whichimage isEqualToString:NANormalimage] || [other.whichimage isEqualToString:NALargeimage])
                         && view.largeModel != NAImageModelLeftDone)){
                        [tmpdic setObject:NALargeimage forKey:@"downloadtype"];
                        [tmpdic setObject:[NSNumber numberWithInteger:aDocIndex.integerValue] forKey:@"imageindex"];
                        [tmpdic setObject:[NSNumber numberWithInteger: otherDocIndex.integerValue] forKey:@"otherImageIndex"];
                    }else if (([doc.whichimage isEqualToString:NANormalimage] || [doc.whichimage isEqualToString:NALargeimage]) &&
                              view.largeModel != NAImageModelLeftDone){
                        [tmpdic setObject:NALargeimage forKey:@"downloadtype"];
                        [tmpdic setObject:[NSNumber numberWithInteger:aDocIndex.integerValue] forKey:@"imageindex"];
                    }else if ([other.whichimage isEqualToString:NANormalimage] || [other.whichimage isEqualToString:NALargeimage]){
                        [tmpdic setObject:NALargeimage forKey:@"downloadtype"];
                        [tmpdic setObject:[NSNumber numberWithInteger: otherDocIndex.integerValue] forKey:@"imageindex"];
                    }
                }
            }else{
                NADoc *doc = self.pageArray[count - 1 - self.mainScrollView.currentItemIndex];
                [self setRiliTitle:doc withOther:nil];
                [tmpdic setObject:[NSNumber numberWithInteger:count - 1 - self.mainScrollView.currentItemIndex] forKey:@"imageindex"];
                view.largeModel=NAImageModelLoading;
                
                if ([doc.whichimage isEqualToString:NAThumbimage]) {
                    [tmpdic setObject:NANormalimage forKey:@"downloadtype"];
                }else if ([doc.whichimage isEqualToString:NANormalimage] || [doc.whichimage isEqualToString:NALargeimage]){
                    [tmpdic setObject:NALargeimage forKey:@"downloadtype"];
                }
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadImageTask" object:nil userInfo:tmpdic];
        }
        
    }
}

-(void)UpdateMymodel:(NSNotification *)notify{
    NSDictionary *dic=[notify userInfo];
    NSNumber *num;
    
    
    @try {
        num=[dic objectForKey:@"imageindex"];
        
        // progressBar設定
        [self setProgressInfo:dic];
        
        if (num.integerValue == -1 || num.integerValue > self.pageArray.count - 1|| self.pageArray.count==0 || !self.pageArray.count) {
            return;
        }
        
        NASubImageScrollView *view = (NASubImageScrollView *)[self.mainScrollView itemViewAtIndex:self.mainScrollView.currentItemIndex];
        
        NADoc *doc = self.pageArray[num.integerValue];
        if (view.largeModel == NAImageModelDone) {
            return;
        }
        
        if (![self isLandscape]) {
            NSInteger count = self.pageArray.count;
            if (num.integerValue==count - 1 - self.mainScrollView.currentItemIndex) {
                // NSLog(@"doc.whichimage==%@",doc.whichimage);
                if ([doc.whichimage isEqualToString:NALargeimage]) {
                    view.largeModel=NAImageModelDone;
                }else{
                    view.largeModel=NAImageModelNone;
                }
                [view LoadingImageView:doc ];
                [self setRiliTitle:doc withOther:nil];
            }
            
        }else{
            NSArray *pageSort = [self padLandscapeCount];
            NSInteger landCount = pageSort.count;
            NSInteger myindex=landCount - 1 - self.mainScrollView.currentItemIndex;
            if (myindex<0) {
                myindex=0;
            }
            NSArray *sort = pageSort[myindex];
            if (sort.count == 1) {
                NSNumber *aDocIndex = sort[0];
                NADoc *doc = self.pageArray[aDocIndex.integerValue];
                [self setRiliTitle:doc withOther:nil];
                if ([self currentIndex:num.integerValue]==landCount - 1 - self.mainScrollView.currentItemIndex) {
                    if ([doc.whichimage isEqualToString:NALargeimage]) {
                        view.largeModel=NAImageModelDone;
                    }else{
                        view.largeModel=NAImageModelNone;
                    }
                    [view LoadingImageView:doc ];
                }
            }else{
                NSNumber *aDocIndex = sort[0];
                NSNumber *otherDocIndex = sort[1];
                NADoc *doc = self.pageArray[aDocIndex.integerValue];
                NADoc *other =  self.pageArray[otherDocIndex.integerValue];
                [self setRiliTitle:doc withOther:other];

                if ([self currentIndex:num.integerValue]==landCount - 1 - self.mainScrollView.currentItemIndex) {
                    AFTER(1.5, ^{
                        [view LoadingTwoImageView:doc other:other];
                    });
                    
                    if ([doc.whichimage isEqualToString:NALargeimage] && [other.whichimage isEqualToString:NALargeimage]) {
                        view.largeModel=NAImageModelDone;
                    }else if ([doc.whichimage isEqualToString:NALargeimage]){
                        view.largeModel=NAImageModelLeftDone;
                    } else {
                        view.largeModel=NAImageModelNone;
                    }
                }
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception==%@",exception);
    }
    
    
}

/**
 * main画面のProgress barを設定
 *
 */
-(void) setProgressInfo:(NSDictionary *)dic
{
    @try {
        NSNumber *thumbcount=[dic objectForKey:@"thumbcount"];
        NSNumber *normalcount=[dic objectForKey:@"normalcount"];
        NSNumber *largecount=[dic objectForKey:@"largecount"];
        NSNumber *num=[dic objectForKey:@"imageindex"];
        if (num.integerValue == -1 || !isAllDownload) {
            _progressViewBar.hidden=YES;
            
            [_progressViewBar setTitleText:NSLocalizedString(@"imagedone", nil)];
            return;
        }
        
        if (num.integerValue > self.pageArray.count - 1) {
            return;
        }
        if (num.integerValue>=self.pageArray.count) {
            return;
        }
        NADoc *tmpdoc=self.pageArray[num.integerValue];
        
        if ([NACheckNetwork sharedInstance].isHavenetwork){
            float currentcount = 0.0;
            currentcount += (CGFloat)thumbcount.integerValue / self.pageArray.count * 0;
            currentcount += (CGFloat)normalcount.integerValue / self.pageArray.count * 30;
            currentcount += (CGFloat)largecount.integerValue / self.pageArray.count * 70;
            
            if (currentcount == 100.0) {
                _progressViewBar.hidden=YES;
                isDoneImageTask=YES;
                [_progressViewBar setProgressNum:1.0f];
                [_progressViewBar setTitleText:NSLocalizedString(@"imagedone", nil)];
                
            }else{
                if (!self.homeToolBar.hidden) {
                    _progressViewBar.hidden=NO;
                } else {
                    _progressViewBar.hidden=YES;
                }
                
                //[_progressViewBar setStatus:NSLocalizedString(@"imageloading", nil)];
                [_progressViewBar setTitleText:tmpdoc.pageInfoName];
                [_progressViewBar setProgressNum:currentcount / 100.0f];
            }
        } else {
            _progressViewBar.hidden=YES;
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception==%@",exception);
    }
    
}


- (BOOL)isLandscape
{

    return ([Util screenSize].width>[Util screenSize].height);
}

- (NSMutableArray *)padLandscapeCount
{
    NSMutableArray *pageSort = [NSMutableArray array];
    for (NSInteger i = 0; i < self.pageArray.count; i++) {
        NADoc *doc = self.pageArray[i];
        NSMutableArray *sort = [NSMutableArray array];
        if (doc.pageno.integerValue % 2 == 0) {
            NSArray *size = [doc.variableString31 componentsSeparatedByString:@","];
            if (size.count > 1  && [size[0] integerValue] > [size[1] integerValue]) {
                if (self.pageArray.count > i + 1) {
                    NADoc *next = self.pageArray[i + 1];
                    NSArray *nextSize = [next.variableString31 componentsSeparatedByString:@","];
                    if (next.pageno.integerValue == doc.pageno.integerValue + 1 && nextSize.count > 1  && ([nextSize[0] integerValue] > [nextSize[1] integerValue])) {
                        [sort addObject:[NSNumber numberWithInteger:i]];
                        [sort addObject:[NSNumber numberWithInteger:i + 1]];
                        [pageSort addObject:sort];
                        i = i + 1;
                        continue;
                    }
                }
            }
        }
        [sort addObject:[NSNumber numberWithInteger:i]];
        [pageSort addObject:sort];
    }
    return pageSort;
}
- (NSInteger)iscurrentTwoIndex:(NSInteger)index
{
    NSArray *array = [self padLandscapeCount];
    for (NSArray *ary in array) {
        if ([ary containsObject:[NSNumber numberWithInteger:index]]) {
            return [ary indexOfObject:[NSNumber numberWithInteger:index]];
        }
    }
    return 0;
}
- (NSInteger)findParterIndex:(NSInteger)index
{
    NSArray *array = [self padLandscapeCount];
    for (NSArray *ary in array) {
        if ([ary containsObject:[NSNumber numberWithInteger:index]]) {
            if ([ary indexOfObject:[NSNumber numberWithInteger:index]]==0) {
                if (ary.count==2) {
                    return [ary[1] integerValue] ;
                }else{
                    return -1;
                }
                
            }else{
                return [ary[0] integerValue] ;
            }
        }
    }
    return -1;
}
- (NSInteger)currentIndex:(NSInteger)index
{
    NSArray *array = [self padLandscapeCount];
    for (NSArray *ary in array) {
        if ([ary containsObject:[NSNumber numberWithInteger:index]]) {
            return [array indexOfObject:ary];
        }
    }
    return 0;
}

- (NSInteger)currentIndexInPages:(NSInteger)index curPagerIndexNo:(NSString *)pagerIndexNo
{
    NSInteger retIndex = 0;
    
    NSArray *array = [self padLandscapeCount];
    if (index>=array.count) {
        return 0;
    }
    NSArray *ary = array[index];
    if(istwo>=ary.count){
        return 0;
    }
    retIndex = [ary[istwo] integerValue];
    if (pagerIndexNo && ary.count > 1) {
        NADoc *doc = self.pageArray[retIndex];
        if (![pagerIndexNo isEqualToString:doc.indexNo]) {
            if (istwo==1) {
                retIndex = [ary[0] integerValue];
            }else{
                retIndex = [ary[1] integerValue];
            }
            
        }
    }
    return retIndex;
}
- (void)setRiliTitle:(NADoc *)doc withOther:(NADoc *)other{
    NSString *date = doc.publishDate;
    _labYear.text = [NSString stringWithFormat:@"%@年(平成%@年)",[date substringWithRange:NSMakeRange(0, 4)],[DateUtil formateDateWithYear:[date substringWithRange:NSMakeRange(0, 4)]]];
    _labYearHore.text = [NSString stringWithFormat:@"%@年(平成%@年)",[date substringWithRange:NSMakeRange(0, 4)],[DateUtil formateDateWithYear:[date substringWithRange:NSMakeRange(0, 4)]]];
    _labYearDetail = [NSString stringWithFormat:@"%@年(平成%@年)",[date substringWithRange:NSMakeRange(0, 4)],[DateUtil formateDateWithYear:[date substringWithRange:NSMakeRange(0, 4)]]];
    NSString *weekDay = [DateUtil formateDateWithMonthDay:doc.publishDate];
    NSString *month = nil;
    if ([[date substringWithRange:NSMakeRange(4, 2)] hasPrefix:@"0"]) {
        month = [date substringWithRange:NSMakeRange(5, 1)];
    }else{
        month = [date substringWithRange:NSMakeRange(4, 2)];
    }
    NSString *day = nil;
    if ([[date substringWithRange:NSMakeRange(6, 2)] hasPrefix:@"0"]) {
        day = [date substringWithRange:NSMakeRange(7, 1)];
    }else{
        day= [date substringWithRange:NSMakeRange(6, 2)];
    }
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 月 %@ 日 (%@)",month,day,weekDay]];
    if (month.length == 1 && day.length == 1) {
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:25]
         
                          range:NSMakeRange(0, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:15]
         
                          range:NSMakeRange(2, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:25]
         
                          range:NSMakeRange(4, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:15]
         
                          range:NSMakeRange(6, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:15]
         
                          range:NSMakeRange(8, 3)];
        _labMonthDay.attributedText = attString;
        _labMonthDayDetail = attString;
        _labMonthDayHore.attributedText = attString;
    }else if (month.length == 1 && day.length == 2) {
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:25]
         
                          range:NSMakeRange(0, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:15]
         
                          range:NSMakeRange(2, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:25]
         
                          range:NSMakeRange(4, 2)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:15]
         
                          range:NSMakeRange(7, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:15]
         
                          range:NSMakeRange(9, 3)];
        _labMonthDay.attributedText = attString;
        _labMonthDayDetail = attString;
        _labMonthDayHore.attributedText = attString;
    }else if (month.length == 2 && day.length == 1) {
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:25]
         
                          range:NSMakeRange(0, 2)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:15]
         
                          range:NSMakeRange(3, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:25]
         
                          range:NSMakeRange(5, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:15]
         
                          range:NSMakeRange(7, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:15]
         
                          range:NSMakeRange(9, 3)];
        _labMonthDay.attributedText = attString;
        _labMonthDayDetail = attString;
        _labMonthDayHore.attributedText = attString;
    }else if (month.length == 2 && day.length == 2) {
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:25]
         
                          range:NSMakeRange(0, 2)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:15]
         
                          range:NSMakeRange(3, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:25]
         
                          range:NSMakeRange(5, 2)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:15]
         
                          range:NSMakeRange(8, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSize:15]
         
                          range:NSMakeRange(10, 3)];
        _labMonthDay.attributedText = attString;
        _labMonthDayDetail = attString;
        _labMonthDayHore.attributedText = attString;
    }
    
    if (other == nil) {
        _labMian.text = [NSString stringWithFormat:@"%@",doc.pageInfoName];
        _labMianHore.text = [NSString stringWithFormat:@"%@",doc.pageInfoName];
        _labMianDetail = [NSString stringWithFormat:@"%@",doc.pageInfoName];
        
    }else{
        _labMian.text = [NSString stringWithFormat:@"%@,%@",doc.pageInfoName,other.pageInfoName];
        _labMianHore.text = [NSString stringWithFormat:@"%@,%@",doc.pageInfoName,other.pageInfoName];
        _labMianDetail = [NSString stringWithFormat:@"%@,%@",doc.pageInfoName,other.pageInfoName];
        
    }
}

-  (void)resetHomeToolBar{
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    JXButton  *btn1 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn1.frame = CGRectMake(0, 2, 40,40);
    }else{
        btn1.frame = CGRectMake(0, 2, 40,45);
    }
    
    btn1.tag = 1001;
    [btn1 setTitle:@"紙面表示" forState:0];
    [btn1 setTitleColor:[UIColor blackColor] forState:0];
    if ([self isLogin]) {
        [btn1 setImage:[UIImage imageNamed:@"01_pink"] forState:0];
    }else{
        [btn1 setImage:[UIImage imageNamed:@"01_glay"] forState:0];
    }
    [btn1 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn1bar= [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    JXButton  *btn2 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn2.frame = CGRectMake(0, 2, 50, 40);
    }else{
        btn2.frame = CGRectMake(0, 2, 50, 45);
    }
    [btn2 setTitle:@"お気に入り" forState:0];
    [btn2 setTitleColor:[UIColor blackColor] forState:0];
    btn2.tag = 1002;
    if ([self isLogin]) {
        [btn2 setImage:[UIImage imageNamed:@"02_blue"] forState:0];
    }else{
        [btn2 setImage:[UIImage imageNamed:@"02_glay"] forState:0];
    }
    [btn2 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn2bar= [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    JXButton  *btn3 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn3.frame = CGRectMake(0, 2, 40, 40);
    }else{
        btn3.frame = CGRectMake(0, 2, 40, 45);
    }
    [btn3 setTitle:@"記事一覧" forState:0];
    [btn3 setTitleColor:[UIColor blackColor] forState:0];
    btn3.tag = 1003;
    if ([self isLogin]) {
        [btn3 setImage:[UIImage imageNamed:@"03_blue"] forState:0];
    }else{
        [btn3 setImage:[UIImage imageNamed:@"03_glay"] forState:0];
    }
    [btn3 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn3bar= [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    JXButton  *btn4 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn4.frame = CGRectMake(0, 5, 40, 40);
    }else{
        btn4.frame = CGRectMake(0, 5, 40, 40);
    }
    [btn4 setTitleColor:[UIColor blackColor] forState:0];
    if (_toolBarStyle == 0 )  {
        btn4.tag = 1004;
        [btn4 setTitle:@"紙面選択" forState:0];
        if ([self isLogin]) {
            [btn4 setImage:[UIImage imageNamed:@"04_blue"] forState:0];
        }else{
            [btn4 setImage:[UIImage imageNamed:@"04_glay"] forState:0];
        }
    }if ( _toolBarStyle == 1)  {
        btn4.tag = 1004;
        [btn4 setTitle:@"紙面選択" forState:0];
        if ([self isLogin]) {
            [btn4 setImage:[UIImage imageNamed:@"04_pink"] forState:0];
        }else{
            [btn4 setImage:[UIImage imageNamed:@"04_glay"] forState:0];
        }
        
    }else if (_toolBarStyle == 2){
        btn4.tag = 1006;
        [btn4 setTitle:@"テキスト" forState:0];
        if ([self isLogin]) {
            [btn4 setImage:[UIImage imageNamed:@"23_bule"] forState:UIControlStateNormal];
        }else{
            [btn4 setImage:[UIImage imageNamed:@"23_glay"] forState:0];
        }
        
    }
    [btn4 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn4bar= [[UIBarButtonItem alloc] initWithCustomView:btn4];
    
    
    JXButton  *btn5 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn5.frame = CGRectMake(0, 5, 50, 35);
    }else{
        btn5.frame = CGRectMake(0, 5, 50, 40);
    }
    [btn5 setTitleColor:[UIColor blackColor] forState:0];
    if (_toolBarStyle == 0 ||  _toolBarStyle == 1) {
        btn5.tag = 1005;
        [btn5 setTitle:@"設定" forState:0];
        [btn5 setImage:[UIImage imageNamed:@"05_blue"] forState:0];
    }else if (_toolBarStyle == 2){
        btn5.tag = 1007;
        [btn5 setTitle:@"機能" forState:0];
        if ([self isLogin]) {
            [btn5 setImage:[UIImage imageNamed:@"09_blue"] forState:0];

        }else{
             [btn5 setImage:[UIImage imageNamed:@"09_glay"] forState:0];
        }
    }
    [btn5 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn5bar= [[UIBarButtonItem alloc] initWithCustomView:btn5];

    self.toolBar.items=[NSArray arrayWithObjects:btn1bar,spaceButtonItem,btn2bar,spaceButtonItem,btn3bar,spaceButtonItem,btn4bar,spaceButtonItem,btn5bar,nil];
    if (![self.view.subviews containsObject:self.toolBar]) {
        [self.view addSubview:self.toolBar];
    }
    UIView *lineView = [[UIView alloc]init];
    [self.view addSubview:lineView];
    if (isPhone) {
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-44);
            make.width.mas_equalTo([Util screenSize].width);
            make.height.mas_equalTo(1);
        }];
    }else{
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-49);
            make.width.mas_equalTo([Util screenSize].width);
            make.height.mas_equalTo(1);
        }];
    }
    lineView.backgroundColor = [UIColor colorWithRed:111.0/255.0 green:171.0/255.0 blue:226.0/255.0 alpha:1];
}

- (void)setHorToolBar{
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIView *leftView;
    CGFloat screenwidth = [Util screenSize].width;
    if (isPhone) {
        leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwidth/2-40, 44)];
    }else{
        leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwidth/2-40, 49)];
    }
    _labYearHore = [[UILabel alloc]init];
    _labYearHore.font = [FontUtil systemFontOfSize:10];
    _labYearHore.text = _labYearDetail;
    [leftView addSubview:_labYearHore];
    
    _labMonthDayHore = [[UILabel alloc]init];
    _labMonthDayHore.attributedText = _labMonthDayDetail;
    [leftView addSubview:_labMonthDayHore];
    
    _labMianHore = [[UILabel alloc]init];
    _labMianHore.font = [FontUtil systemFontOfSize:10];
    _labMianHore.numberOfLines = 2;
    _labMianHore.lineBreakMode = NSLineBreakByWordWrapping;
    _labMianHore.text = _labMianDetail;
    [leftView addSubview:_labMianHore];
    
    UIButton *btnChooseDay = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([self isLogin]) {
        [btnChooseDay setImage:[UIImage imageNamed:@"08_blue"] forState:UIControlStateNormal];
    }else{
        [btnChooseDay setImage:[UIImage imageNamed:@"08_glay"] forState:UIControlStateNormal];
    }
    [btnChooseDay addTarget:self action:@selector(chooseDay) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:btnChooseDay];
    
    [_labYearHore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(2);
        make.width.mas_equalTo(screenwidth/2 -60);
    }];
    
    [_labMonthDayHore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(_labYearHore.mas_bottom);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(35);
        
    }];
    
    [_labMianHore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labMonthDayHore.mas_right);
        make.top.equalTo(_labYearHore.mas_bottom);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(25);
        
    }];
    
    [btnChooseDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labMianHore.mas_right).offset(5);
        make.top.equalTo(leftView.mas_top).offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];

    UIBarButtonItem *btn6bar= [[UIBarButtonItem alloc] initWithCustomView:leftView];
    
    
    JXButton  *btn1 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn1.frame = CGRectMake(0, 2, 40,40);
    }else{
        btn1.frame = CGRectMake(0, 2, 40,45);
    }
    
    btn1.tag = 1001;
    [btn1 setTitle:@"紙面表示" forState:0];
    [btn1 setTitleColor:[UIColor blackColor] forState:0];
    if ([self isLogin]) {
        [btn1 setImage:[UIImage imageNamed:@"01_pink"] forState:0];
    }else{
        [btn1 setImage:[UIImage imageNamed:@"01_glay"] forState:0];
    }
    [btn1 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn1bar= [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    JXButton  *btn2 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn2.frame = CGRectMake(0, 2, 50, 40);
    }else{
        btn2.frame = CGRectMake(0, 2, 50, 45);
    }
    [btn2 setTitle:@"お気に入り" forState:0];
    [btn2 setTitleColor:[UIColor blackColor] forState:0];
    btn2.tag = 1002;
    if ([self isLogin]) {
        [btn2 setImage:[UIImage imageNamed:@"02_blue"] forState:0];
    }else{
        [btn2 setImage:[UIImage imageNamed:@"02_glay"] forState:0];
    }
    [btn2 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn2bar= [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    JXButton  *btn3 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn3.frame = CGRectMake(0, 2, 40, 40);
    }else{
        btn3.frame = CGRectMake(0, 2, 40, 45);
    }
    [btn3 setTitle:@"記事一覧" forState:0];
    [btn3 setTitleColor:[UIColor blackColor] forState:0];
    btn3.tag = 1003;
    if ([self isLogin]) {
        [btn3 setImage:[UIImage imageNamed:@"03_blue"] forState:0];
    }else{
        [btn3 setImage:[UIImage imageNamed:@"03_glay"] forState:0];
    }
    [btn3 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn3bar= [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    
    JXButton  *btn4 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn4.frame = CGRectMake(0, 5, 40, 30);
    }else{
        btn4.frame = CGRectMake(0, 5, 40, 40);
    }
    [btn4 setTitleColor:[UIColor blackColor] forState:0];
    btn4.tag = 1004;
    [btn4 setTitle:@"紙面選択" forState:0];
    if (_toolBarStyle == 0 || _toolBarStyle == 2 )  {
        if ([self isLogin]) {
            [btn4 setImage:[UIImage imageNamed:@"04_blue"] forState:0];
        }else{
            [btn4 setImage:[UIImage imageNamed:@"04_glay"] forState:0];
        }
    }if ( _toolBarStyle == 1)  {
        if ([self isLogin]) {
            [btn4 setImage:[UIImage imageNamed:@"04_pink"] forState:0];
        }else{
            [btn4 setImage:[UIImage imageNamed:@"04_glay"] forState:0];
        }
    }
    [btn4 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn4bar= [[UIBarButtonItem alloc] initWithCustomView:btn4];
    

    JXButton  *btn8 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn8.frame = CGRectMake(0, 5, 40, 35);
    }else{
        btn8.frame = CGRectMake(0, 5, 40, 40);
    }
    [btn8 setTitleColor:[UIColor blackColor] forState:0];
    btn8.tag = 1006;
    [btn8 setTitle:@"テキスト" forState:0];
    if ([self isLogin]) {
        [btn8 setImage:[UIImage imageNamed:@"23_bule"] forState:0];
    }else{
        [btn8 setImage:[UIImage imageNamed:@"23_glay"] forState:0];
    }
    [btn8 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn8bar= [[UIBarButtonItem alloc] initWithCustomView:btn8];
    
    JXButton  *btn5 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn5.frame = CGRectMake(0, 5, 50, 30);
    }else{
        btn5.frame = CGRectMake(0, 5, 50, 35);
    }
    [btn5 setTitleColor:[UIColor blackColor] forState:0];
    btn5.tag = 1007;
    [btn5 setTitle:@"機能" forState:0];
    if ([self isLogin]) {
        [btn5 setImage:[UIImage imageNamed:@"09_blue"] forState:0];
        
    }else{
        [btn5 setImage:[UIImage imageNamed:@"09_glay"] forState:0];
    }
    [btn5 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn5bar= [[UIBarButtonItem alloc] initWithCustomView:btn5];
    
    
    JXButton  *btn6 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn6.frame = CGRectMake(0, 5, 40, 30);
    }else{
        btn6.frame = CGRectMake(0, 5, 40, 35);
    }
    [btn6 setTitleColor:[UIColor blackColor] forState:0];
    btn6.tag = 1005;
    [btn6 setTitle:@"設定" forState:0];
    [btn6 setImage:[UIImage imageNamed:@"05_blue"] forState:0];
    [btn6 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn7bar= [[UIBarButtonItem alloc] initWithCustomView:btn6];

    if (_toolBarStyle == 0) {
        self.toolBar.items=[NSArray arrayWithObjects:btn6bar,spaceButtonItem,btn1bar,spaceButtonItem,btn2bar,spaceButtonItem,btn3bar,spaceButtonItem,btn4bar,spaceButtonItem,btn7bar,nil];
    }else if (_toolBarStyle == 1){
        self.toolBar.items=[NSArray arrayWithObjects:btn6bar,spaceButtonItem,btn1bar,spaceButtonItem,btn2bar,spaceButtonItem,btn3bar,spaceButtonItem,btn4bar,spaceButtonItem,btn7bar,nil];
    }else if (_toolBarStyle == 2){
        self.toolBar.items=[NSArray arrayWithObjects:btn6bar,spaceButtonItem,btn1bar,spaceButtonItem,btn2bar,spaceButtonItem,btn3bar,spaceButtonItem,btn8bar,spaceButtonItem,btn5bar,spaceButtonItem,btn7bar,nil];
    }
    if (![self.view.subviews containsObject:self.toolBar]) {
        [self.view addSubview:self.toolBar];
    }
    
    UIView *lineView = [[UIView alloc]init];
    [self.view addSubview:lineView];
    if (isPhone) {
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-44);
            make.width.mas_equalTo([Util screenSize].width);
            make.height.mas_equalTo(1);
        }];
    }else{
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-49);
            make.width.mas_equalTo([Util screenSize].width);
            make.height.mas_equalTo(1);
        }];
    }
    
    lineView.backgroundColor = [UIColor colorWithRed:111.0/255.0 green:171.0/255.0 blue:226.0/255.0 alpha:1];
}
- (void)setRiliview{
    CGFloat screenWidth = [Util screenSize].width;
    _riliView = [[UIView alloc] init];
    _riliView.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:255.0/255.0 alpha:1];
    [self.view addSubview:_riliView];
    [_riliView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    _viewTwo = [[UIView alloc]init];
    [_riliView addSubview:_viewTwo];
    //_viewTwo.backgroundColor = [UIColor redColor];
    [_viewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_riliView.mas_centerX);
        make.top.equalTo(_riliView);
        make.right.equalTo(_riliView.mas_right).offset(-75);
        make.left.equalTo(_riliView.mas_left).offset(100);
        make.height.mas_equalTo(40);
    }];
    
    _labMonthDay = [[UILabel alloc]init];
    [_viewTwo addSubview:_labMonthDay];
    [_labMonthDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_viewTwo.mas_top).offset(5);
        make.left.right.equalTo(_viewTwo);
        make.height.mas_equalTo(30);
    }];
    _labMonthDay.textAlignment = NSTextAlignmentCenter;
    [_labMonthDay setTextColor:[UIColor blackColor]];
    
    
    _viewOne = [[UIView alloc]init];
    [_riliView addSubview:_viewOne];
    [_viewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_riliView.mas_left);
        make.top.equalTo(_riliView);
        make.right.equalTo(_viewTwo.mas_left);
        make.height.mas_equalTo(40);
    }];
    
    
    _labYear = [[UILabel alloc]init];
    [_viewOne addSubview:_labYear];
    [_labYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_viewOne.mas_top).offset(15);
        make.left.equalTo(_viewOne.mas_left).offset(2);
        make.right.equalTo(_viewOne.mas_right);
        make.height.mas_equalTo(20);
    }];
    _labYear.textAlignment = NSTextAlignmentCenter;
    [_labYear setFont:[FontUtil systemFontOfSize:10]];
    [_labYear setTextColor:[UIColor blackColor]];
    
    _viewThree = [[UIView alloc]init];
    //_viewThree.backgroundColor = [UIColor greenColor];
    [_riliView addSubview:_viewThree];
    [_viewThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_riliView.mas_right).offset(-35);
        make.top.equalTo(_riliView);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    _labMian = [[UILabel alloc]init];
    [_viewThree addSubview:_labMian];
    _labMian.textAlignment = NSTextAlignmentCenter;
    [_labMian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_viewThree.mas_left);
        make.top.equalTo(_viewThree.mas_top).offset(5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(35);
    }];
    _labMian.font = [FontUtil systemFontOfSize:12];
    _labMian.numberOfLines = 2;
    _labMian.lineBreakMode = NSLineBreakByWordWrapping;
    [_labMian setTextColor:[UIColor blackColor]];
    
    
    _viewFour = [[UIView alloc]init];
    //_viewFour.backgroundColor = [UIColor blueColor];
    [_riliView addSubview:_viewFour];
    [_viewFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_riliView.mas_right);
        make.top.equalTo(_riliView);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(40);
    }];
    _btnChooseDay =[UIButton buttonWithType:UIButtonTypeCustom];
    [_viewFour addSubview:_btnChooseDay];
    [_btnChooseDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_viewFour.mas_right).offset(-5);
        make.top.equalTo(_viewFour.mas_top).offset(8);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseDay)];
    [_viewFour addGestureRecognizer:tapGesturRecognizer];
    if ([self isLogin]) {
        [_btnChooseDay setImage:[UIImage imageNamed:@"08_blue"] forState:UIControlStateNormal];
    }else{
        [_btnChooseDay setImage:[UIImage imageNamed:@"08_glay"] forState:UIControlStateNormal];
    }
    [_btnChooseDay addTarget:self action:@selector(chooseDay) forControlEvents:UIControlEventTouchUpInside];
    
    _labMonthDay.attributedText = _labMonthDayDetail;
    _labYear.text = _labYearDetail;
    _labMian.text = _labMianDetail;
    
    _lineView = [[UIView alloc]init];
    [_riliView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_riliView.mas_bottom).offset(-1);
        make.width.mas_equalTo(screenWidth);
        make.height.mas_equalTo(1);
    }];
    _lineView.backgroundColor = [UIColor colorWithRed:111.0/255.0 green:171.0/255.0 blue:226.0/255.0 alpha:1];
    
}
- (void)resetRiliview{
    CGFloat screenWidth = [Util screenSize].width;
    
    [_riliView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [_viewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_riliView.mas_centerX);
        make.top.equalTo(_riliView);
        make.right.equalTo(_riliView.mas_right).offset(-75);
        make.left.equalTo(_riliView.mas_left).offset(100);
        make.height.mas_equalTo(40);
    }];
    
    [_labMonthDay mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_viewTwo.mas_top).offset(5);
        make.left.right.equalTo(_viewTwo);
        make.height.mas_equalTo(30);
    }];
    
    [_viewOne mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_riliView.mas_left);
        make.top.equalTo(_riliView);
        make.right.equalTo(_viewTwo.mas_left);
        make.height.mas_equalTo(40);
    }];
    
    
    [_labYear mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_viewOne.mas_top).offset(15);
        make.left.equalTo(_viewOne.mas_left).offset(2);
        make.right.equalTo(_viewOne.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    [_viewThree mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_riliView.mas_right).offset(-35);
        make.top.equalTo(_riliView);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [_labMian mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_viewThree.mas_left);
        make.top.equalTo(_viewThree.mas_top).offset(5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(35);
    }];
    
    [_viewFour mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_riliView.mas_right);
        make.top.equalTo(_riliView);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(40);
    }];
    
    [_btnChooseDay mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_viewFour.mas_right).offset(-5);
        make.top.equalTo(_viewFour.mas_top).offset(8);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    if ([self isLogin]) {
        [_btnChooseDay setImage:[UIImage imageNamed:@"08_blue"] forState:UIControlStateNormal];
    }else{
        [_btnChooseDay setImage:[UIImage imageNamed:@"08_glay"] forState:UIControlStateNormal];
    }
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_riliView.mas_bottom).offset(-1);
        make.width.mas_equalTo(screenWidth);
        make.height.mas_equalTo(1);
    }];
    

}


@end
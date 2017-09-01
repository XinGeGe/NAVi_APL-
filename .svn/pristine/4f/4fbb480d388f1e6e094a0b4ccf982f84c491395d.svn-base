//
//  NATopPageUIViewController.m
//  NAVi
//
//  Created by y fs on 15/12/2.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import "NATopPageUIViewController.h"
#import "AppDelegate.h"
#import "FontUtil.h"
@implementation NATopPageUIViewController{
    NALoginAlertView *myalertview;
    NADoc *currentTopPageDoc;
    BOOL isTempAutoLogin;
    BOOL isTempAllDownload;
    NAAgreementViewController *agvc;
    UIBarButtonItem *notloginItem;
    BOOL isShowTopWeb;
    BOOL isCanTopUrl;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tView reloadData];
    if ([NACheckNetwork sharedInstance].isHavenetwork==NO) {
        ITOAST_BOTTOM(NSLocalizedString(@"top page error", nil));
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=NSLocalizedString(@"topPage", nil);
    UIButton  *menubtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menubtn.frame = CGRectMake(0, 0, 80, 49);
    //[menubtn setImage:[UIImage imageNamed:@"menu_menu_on"] forState:UIControlStateNormal];
    [menubtn setTitle:NSLocalizedString(@"Menu", nil) forState:UIControlStateNormal];
    [menubtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [menubtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    menubtn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *menubar= [[UIBarButtonItem alloc] initWithCustomView:menubtn];
    
    self.toolBar.items=[NSArray arrayWithObjects:menubar,nil];
    [self.view addSubview:self.toolBar];
}
- (void)showMenu:(UIButton *)sender
{
    NSArray *menuItems;
    
    menuItems =@[
                 
                [KxMenuItem menuItem:@"利用規約"
                                image:nil
                               target:self
                               action:@selector(pushMenuItem:)],
                 
                 [KxMenuItem menuItem:@"アプリ設定"
                                image:nil
                               target:self
                               action:@selector(pushMenuItem:)],
                 
                 [KxMenuItem menuItem:@"ログアウト"
                                image:nil
                               target:self
                               action:@selector(pushMenuItem:)],
                 
                
                 
                 ];
    
    
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(self.toolBar.frame.origin.x, self.toolBar.frame.origin.y, self.toolBar.frame.size.width/4, self.toolBar.frame.size.height)
                 menuItems:menuItems];

}
- (void) pushMenuItem:(id)sender
{
    KxMenuItem *myitem=sender;
    //NSLog(@"%@", myitem.title);
    if ([myitem.title isEqualToString:@"利用規約"]) {
        agvc=[[NAAgreementViewController alloc]init];
        agvc.delegate=self;
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:agvc];
        [self presentViewController:nav animated:YES completion:^{
            agvc.agreeBtn.hidden=YES;
            agvc.notAgreeBtn.hidden=YES;
            agvc.OkBtn.hidden=NO;
        }];
       
    }else if ([myitem.title isEqualToString:@"アプリ設定"]){
        NASettingViewController *naset=[[NASettingViewController alloc]init];
        naset.isfromWhere=@"topPage";
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:naset];
        [self presentViewController:nav animated:YES completion:nil];
    }else if ([myitem.title isEqualToString:@"ログアウト"]){
        //[NASaveData saveUserInfo:[NSNumber numberWithBool:NO]];
        [NASaveData saveIsVisitorModel:YES];
        [NASaveData clearLoginInfo];
        self.navigationItem.rightBarButtonItem=notloginItem;
        [self.tView reloadData];
        [self notLoginAction];
        ITOAST_BOTTOM(@"ログアウト ok");
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
        //[[(AppDelegate *)[UIApplication sharedApplication].delegate loginViewController]showLogin];
        
    }
}
-(void)IAgree{
    [agvc dismissViewControllerAnimated:YES completion:nil];
}
/**
 * view初期化
 *
 */
- (void)initViews
{
    [super initViews];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:NSLocalizedString(@"not login", nil) forState:UIControlStateNormal];
    //[button addTarget:self action:@selector(notLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.titleLabel.font=[FontUtil systemFontOfSize:14];
    
    notloginItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if ([NASaveData getIsVisitorModel]) {
        self.navigationItem.rightBarButtonItem=notloginItem;
    }
    
    self.topPageArray=[[NSMutableArray alloc]init];
    [self getTopPageArray];
    
    
    NSDictionary *changedic=[NAFileManager ChangePlistTodic];
    NSNumber *myshow=[changedic objectForKey:NAISSHOWTOPOSIRASE];
    isShowTopWeb=myshow.boolValue;
    NSString *urlString = [NASaveData getTopUrl];
    isCanTopUrl = [Util webFileExists:urlString];
    if (myshow.boolValue&&isCanTopUrl) {
        [self addTopOsiraseWeb];
    }
    [self.view addSubview:self.tView];
}
-(void)addTopOsiraseWeb{
    
    self.mywebview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 70)];
    self.mywebview.delegate=self;
    //self.mywebview.userInteractionEnabled=NO;
    BACK(^{
        if ([NACheckNetwork sharedInstance].isHavenetwork) {
            NSString *urlString = [NASaveData getTopUrl];
            NSURL *url = [NSURL URLWithString:urlString];

            NSData *data = [NSData dataWithContentsOfURL:url];
            [self.mywebview loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
            [[NAFileManager sharedInstance]saveTophtml:data];
            
        }else{
            [self.mywebview loadHTMLString:[[NAFileManager sharedInstance]getTopHtml] baseURL:nil];
        }
        
    });
    
    //self.tView.tableHeaderView=self.mywebview;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
   [self.view addSubview:self.mywebview];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        //新建窗口处理代码
        //request.URL
        [self toTOWebViewControllerWithUrlStr:[request.URL absoluteString]];
        //[self openBrowser:[request.URL absoluteString]];
        return NO;
    }
    
    return YES;
}
-(void)notLoginAction{
    myalertview=[[NALoginAlertView alloc]init];
    myalertview.delegate=self;
//    isTempAutoLogin=myalertview.saveIDSwitch.isOn;
//    isTempAllDownload=myalertview.allDownloadSwitch.isOn;
    [myalertview show];
}
#pragma mark - NALoginAlertView delegate -
#pragma mark
-(void)loginClick:(NSString *)username Password:(NSString *)password{
    [self getLoginAPIWithUsername:username ThePassword:password];
}
-(void)switchDidChange:(BOOL)isAutoLogin TheAllDownload:(BOOL)isAllDownload{
    isTempAutoLogin=isAutoLogin;
    isTempAllDownload=isAllDownload;
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
                                                  self.navigationItem.rightBarButtonItem=nil;
                                                  [myalertview dismissMyview];
                                                  
                                                  [NASaveData saveIsVisitorModel:NO];
                                                  [NASaveData saveUserInfo:[NSNumber numberWithBool:isTempAutoLogin]];
                                                  [NASaveData saveAlldownload:[NSNumber numberWithBool:isTempAllDownload]];
                                                  [NASaveData SaveLoginWithID:login.userId withPassWord:login.password];
                                                  [NASaveData saveTimeStamp:login.timeStamp];
//                                                  if (isTempAutoLogin) {
//                                                      [NASaveData SaveLoginWithID:login.userId withPassWord:login.password];
//                                                  }
                                                  //[ProgressHUD dismiss];
                                                  if (currentTopPageDoc==nil) {
                                                      self.isLoginToTop=YES;
                                                      [ProgressHUD dismiss];
                                                      [self.tView reloadData];
                                                  }else{
                                                      [self toHomeViewController];
                                                  }
                                                  
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
                                          
                                      }];
}

-(void)getTopPageArray{
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
//    BACK((^{
        if ([NACheckNetwork sharedInstance].isHavenetwork) {
            if ([NASaveData getIsVisitorModel]) {
                NSString *deviceModel = isPad ? @"N01" : @"N02";
                NSString *now;
                if ([NASaveData isSaveTimeStamp]) {
                    now = [NASaveData saveTimeStamp];
                }else {
                    now = [NSString nowDate];
                    [NASaveData saveTimeStamp:now];
                }
                NSDictionary *changedic=[NAFileManager ChangePlistTodic];
                NSDictionary *param = @{
                                        @"Userid"      : [changedic objectForKey:NADEFAULTUSERID],
                                        @"Pass"    : [changedic objectForKey:NADEFAULTUSERPASS],
                                        @"UseDevice"   : deviceModel,
                                        @"timestamp"   : now,
                                        };
                [[NANetworkClient sharedClient] postCheckUserid:param completionBlock:^(id master, NSError *error) {
                    if (!error) {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            [[NAFileManager sharedInstance] saveMasterFileWithData:master];
                        });
                        
                        SHXMLParser *parser = [[SHXMLParser alloc] init];
                        NSDictionary *dic = [parser parseData:master];
                        NSDictionary *resdic=[dic objectForKey:@"response"];
                        NSString *status=[resdic objectForKey:@"status"];
                        if ([status isEqualToString:REQUEST_SUCCESS]) {
                            [self getmasterAPI];
                        }else{
                            MAIN(^{
                                ITOAST_BOTTOM(NSLocalizedString(@"server error", nil));
                                [ProgressHUD dismiss];
                            });

                        }
                       
                    }else{
                        MAIN(^{
                            ITOAST_BOTTOM(error.localizedDescription);
                            [ProgressHUD dismiss];
                            
                        });
                    }
                }];
            }else{
                [self getmasterAPI];
            }
        }else{
            NSArray *info = [[NAFileManager sharedInstance] masterPublisherGroupInfo];
            [self getDocsFromLocal:info];
        }
        
//    }));
    
}
- (void)getmasterAPI
{
    
    //    NSLog(@"getmasterAPI") ;
    
    NSString *userId = [NASaveData getLoginUserId];
    if (userId==nil) {
        userId = [NASaveData getDefaultUserID];
    }
    NSDictionary *param = @{
                            @"Userid"     :  userId,
                            @"UseDevice"  :  NAUserDevice,
                            };
    
    [[NANetworkClient sharedClient] postMasterWithDevice:param  completionBlock:^(id master, NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[NAFileManager sharedInstance] saveMasterFileWithData:master];
            });
            
            SHXMLParser *parser = [[SHXMLParser alloc] init];
            NSDictionary *dic = [parser parseData:master];
            NAMasterBaseClass *masterBaseClass = [NAMasterBaseClass modelObjectWithDictionary:dic];
            [self getSearchAPIWithMaster:masterBaseClass];
            
        }else{
            MAIN(^{
                ITOAST_BOTTOM(error.localizedDescription);
                [ProgressHUD dismiss];
                
            });
        }
        
    }];
    
}
/**
 * Localから、新聞一覧情報を取得
 *
 */
- (void)getDocsFromLocal:(NSArray *)info
{
    NSString *userId = [NASaveData getLoginUserId];
    if (userId==nil) {
        userId = [NASaveData getDefaultUserID];
    }
    NSArray *tmpdocarray=[[NASQLHelper sharedInstance]getPaperInfoByUserId:userId];
    for (NSInteger i=0; i<tmpdocarray.count; i++) {
        NADoc *doc=[tmpdocarray objectAtIndex:i];
        NSData *mydata=[[NAFileManager sharedInstance] readSearchFileWithdoc:doc];
        
        if (mydata) {
            SHXMLParser *parser = [[SHXMLParser alloc] init];
            NSDictionary *dic = [parser parseData:mydata];
            NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
            NADoc *doc=searchBaseClass.response.doc[0];
            for (NSInteger index=0; index<info.count; index++) {
                NAPublisherGroupInfo *napg=[info objectAtIndex:index];
                
                if ([napg.publisherGroupInfoIdentifier isEqualToString:doc.publisherGroupInfoId]) {
                    for (NSInteger indexB=0;indexB<napg.publisherInfo.count;indexB++) {
                        NAPublisherInfo *publisherInfo=napg.publisherInfo[indexB];
                        if ([doc.publisherInfoId isEqualToString:publisherInfo.publisherInfoIdentifier]) {
                            for (NSInteger indexC=0;indexC<publisherInfo.publicationInfo.count;indexC++) {
                                NAPublicationInfo *publication=publisherInfo.publicationInfo[indexC];
                                if ([doc.publicationInfoId isEqualToString:publication.publicationInfoIdentifier]) {
                                    doc.publication_disOrder1=publication.dispOrder1;
                                    doc.publication_disOrder3=publication.dispOrder3;
                                    doc.publication_disOrder4=publication.dispOrder4;
                                }
                            }
                        }
                    }
                    
                }
            }
            [self.topPageArray addObject:doc];
        }
    }
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"publication_disOrder4" ascending:NO];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"publication_disOrder1" ascending:YES];
    [self.topPageArray sortUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor1,sortDescriptor2, nil]];
    MAIN(^{
        
        [self.tView reloadData];
        [ProgressHUD dismiss];
    });
}

//search
- (void)getSearchAPIWithMaster:(NAMasterBaseClass *)masterBaseClass
{
    //    NSLog(@"getSearchAPIWithMaster") ;
    
    [ProgressHUD shared].label.text=NSLocalizedString(@"messageloading", nil);
    __block NSInteger apiCount = 0;
    NSArray *publisherGroupInfos = masterBaseClass.masterData.publishers.publisherGroupInfo;
    //    self.publisherInfoArray = [NSMutableArray array];
    //    for (NAPublisherGroupInfo *publisherGroupInfo in publisherGroupInfos) {
    //        for (NAPublisherInfo *publisherInfo in publisherGroupInfo.publisherInfo) {
    //            [self.publisherInfoArray addObject:publisherInfo];
    //        }
    //    }
    NSString *userId = [NASaveData getDefaultUserID];
    NADoc *myCurrentDoc=nil;
    if ([NASaveData isLogin]) {
        if ([NASaveData getLoginUserId]) {
            userId=[NASaveData getLoginUserId];
            myCurrentDoc=[NASaveData getCurrentDoc];
        };
    }
   
    
    for (NSInteger indexA=0;indexA<publisherGroupInfos.count;indexA++) {
        NAPublisherGroupInfo *publishergroupInfo=publisherGroupInfos[indexA];
        NSString *K004=@"";
        
        K004 = publishergroupInfo.publisherGroupInfoIdentifier;
        if (myCurrentDoc) {
            if (![K004 isEqualToString:myCurrentDoc.publisherGroupInfoId]) {
                continue;
            }
        }
        
        NSArray *array = publishergroupInfo.publisherInfo;
        
        for (NSInteger indexB=0;indexB<array.count;indexB++) {
            NAPublisherInfo *publisherInfo=array[indexB];
            NSString *K005 = @"";
            K005 = publisherInfo.publisherInfoIdentifier;
            
            
            NSMutableArray *publicationArray=[NSMutableArray arrayWithArray:publisherInfo.publicationInfo];
            for (NSInteger indexC=0;indexC<publicationArray.count;indexC++) {
                NAPublicationInfo *publication=[publicationArray objectAtIndex:indexC];
                NSString *K006 = @"";
                K006 = publication.publicationInfoIdentifier;
                
                NSDictionary *param = @{
                                        @"Userid"     :  userId,
                                        @"UseDevice"  :  NAUserDevice,
                                        @"K090"       :  @"010",
                                        @"Rows"       :  @"1",
                                        @"K003"       :  [NSString stringWithFormat:@"20000101:%@",[Util getSystemDate]],
                                        @"K004"       :  K004,
                                        @"K005"       :  K005,
                                        @"K006"       :  K006,
                                        @"K002"       :  @"2",
                                        @"Mode"       :  @"1",
                                        @"K014"       :  @"1",
                                        @"Sort"       :  @"K003:desc,K032:desc,K008:desc",
                                        @"Fl"         :  [NSString searchDateSelectedFl]
                                        };
                apiCount = apiCount + 1;
                [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
                    if (!error) {
                        apiCount = apiCount - 1;
                        SHXMLParser *parser = [[SHXMLParser alloc] init];
                        NSDictionary *dic = [parser parseData:search];
                        NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                        if (searchBaseClass.response.doc.count > 0) {
                            
                            NADoc *doc = searchBaseClass.response.doc[0];
                            doc.publication_disOrder1=publication.dispOrder1;
                            doc.publication_disOrder3=publication.dispOrder3;
                            doc.publication_disOrder4=publication.dispOrder4;
                            doc.user_id=userId;
                            if (![[NASQLHelper sharedInstance]isHavePaperInfoByDoc:doc]) {
                                [[NASQLHelper sharedInstance]addPaperInfo:doc];
                            }
                            [[NAFileManager sharedInstance] saveSearchFileWithData:search Mydoc:doc];
                            
                            [self.topPageArray addObject:doc];
                            
                        }
                        MAIN((^{
                            if (apiCount == 0) {
                                NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"publication_disOrder4" ascending:NO];
                                NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"publication_disOrder1" ascending:YES];
                                [self.topPageArray sortUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor1,sortDescriptor2, nil]];
                                
                                if (self.topPageArray==0) {
                                    //ITOAST_BOTTOM(NSLocalizedString(@"top page error", nil));
                                }
                                [self.tView reloadData];
                                [ProgressHUD dismiss];
                            }
                        }));
                        
                    }else{
                        MAIN(^{
                            ITOAST_BOTTOM(error.localizedDescription);
                            [ProgressHUD dismiss];
                        });
                    }
                }];
            }
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 * view更新
 *
 */
- (void)updateViews
{
    [super updateViews];
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat navHeight = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat barHeight = 44;
    if (isShowTopWeb&&isCanTopUrl) {
        self.tView.frame = CGRectMake(0, 75, screenWidth, screenHeight-barHeight-75);
    }else{
        self.tView.frame = CGRectMake(0, 0, screenWidth, screenHeight-barHeight);
    }
  
    self.toolBar.frame=CGRectMake(0, screenHeight - barHeight, self.view.frame.size.width, barHeight);
    self.mywebview.frame=CGRectMake(0, navHeight+5,screenWidth, 70);
}
/**
 * tView初期化
 *
 */
- (UITableView *)tView
{
    if (!_tView) {
        _tView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tView.delegate = self;
        _tView.dataSource = self;
        _tView.tableFooterView=[[UIView alloc]init];
    }
    return _tView;
}

#pragma mark - tableView delegate -
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

        if ([NASaveData getIsHaveWebBtn]||[NASaveData getIsHaveExtraImage]) {
            return 2;
        }else{
            return 1;
        }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isPad) {
        if (section==0) {
            NSInteger count  = 0;
            NSInteger item = isPad ? 4 : 2;
            count = self.topPageArray.count / item;
            if (self.topPageArray.count % item != 0) {
                count = count + 1;
            }
            return count;
        }else{
            return 1;
            
        }
    }else{
        if (section==0) {
            NSInteger count  = 0;
            NSInteger topCount = 0;
            topCount=self.topPageArray.count;
            NSInteger item = isPad ? 4 : 2;
            count = topCount / item;
            if (topCount% item != 0) {
                count = count + 1;
            }
            return count;
        }else{
            if (![NASaveData getIsHaveExtraImage]&![NASaveData getIsHaveWebBtn]) {
                return 0;
            }else{
                return 1;
            }
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat ret = 190.0f;
    if (isPad) {
        ret = 240.0f;
    }
    return ret;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 2;
    }else{
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView *myBackview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 2)];
        myBackview.backgroundColor=[UIColor lightGrayColor];
        return myBackview;
    }else{
        return nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (isPad) {
        if (indexPath.section==0) {
            static NSString *CellIdentifier = @"Cell";
            NADocPadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[NADocPadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            NSInteger index = indexPath.row * 4;
            if (index < self.topPageArray.count) {
                NADoc *doc = self.topPageArray[index];
                [cell.docView1 imageViewWthInfo:doc];
                cell.docView1.tag = index + 1;
                
                [cell.docView1 updateTitleWithName:[self getSubTitleText:doc]];
                [cell.docView1 updateMainTitleWithName:[self getMainTitleText:doc]];
                
                if([self isLogin]){
                    cell.docView1.imageIdentfier.hidden=YES;
                }else{
                    cell.docView1.imageIdentfier.hidden=NO;
                }
                if ([doc.publication_disOrder3 isEqualToString:@"1"]) {
                    [cell.docView1.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_sample"]];
                }else{
                    [cell.docView1.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_cost"]];
                }
            }
            index = indexPath.row * 4 + 1;
            if (index < self.topPageArray.count) {
                NADoc *doc = self.topPageArray[index];
                [cell.docView2 imageViewWthInfo:doc];
                cell.docView2.tag = index + 1;
                
                [cell.docView2 updateTitleWithName:[self getSubTitleText:doc]];
                [cell.docView2 updateMainTitleWithName:[self getMainTitleText:doc]];
                
                if([self isLogin]){
                    cell.docView2.imageIdentfier.hidden=YES;
                }else{
                    cell.docView2.imageIdentfier.hidden=NO;
                }
                if ([doc.publication_disOrder3 isEqualToString:@"1"]) {
                    [cell.docView2.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_sample"]];
                }else{
                    [cell.docView2.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_cost"]];
                }
            }
            index = indexPath.row * 4 + 2;
            if (index < self.topPageArray.count) {
                NADoc *doc = self.topPageArray[index];
                [cell.docView3 imageViewWthInfo:doc];
                cell.docView3.tag = index + 1;
                
                [cell.docView3 updateTitleWithName:[self getSubTitleText:doc]];
                [cell.docView3 updateMainTitleWithName:[self getMainTitleText:doc]];
                
                if([self isLogin]){
                    cell.docView3.imageIdentfier.hidden=YES;
                }else{
                    cell.docView3.imageIdentfier.hidden=NO;
                }
                if ([doc.publication_disOrder3 isEqualToString:@"1"]) {
                    [cell.docView3.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_sample"]];
                }else{
                    [cell.docView3.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_cost"]];
                }
            }
            index = indexPath.row * 4 + 3;
            if (index < self.topPageArray.count) {
                NADoc *doc = self.topPageArray[index];
                [cell.docView4 imageViewWthInfo:doc];
                cell.docView4.tag = index + 1;
                
                [cell.docView4 updateTitleWithName:[self getSubTitleText:doc]];
                [cell.docView4 updateMainTitleWithName:[self getMainTitleText:doc]];
                if([self isLogin]){
                    cell.docView4.imageIdentfier.hidden=YES;
                }else{
                    cell.docView4.imageIdentfier.hidden=NO;
                }
                if ([doc.publication_disOrder3 isEqualToString:@"1"]) {
                    [cell.docView4.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_sample"]];
                }else{
                    [cell.docView4.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_cost"]];
                }
            }
            cell.selectedObjectCompletionBlock = ^(id object) {
                UIView *view = (UIView *)object;
                if (view.tag) {
                    NADoc *doc = self.topPageArray[view.tag - 1];
                    currentTopPageDoc=doc;
                    if ([doc.publication_disOrder3 isEqualToString:@"1"]) {
                        //无料
                        if([NASaveData getIsVisitorModel]){
                            //[NASaveData saveUserId:[NASaveData getDefaultUserID]];
                        }
                        [self toHomeViewController];
                    }else{
                        if ([self isLogin]) {
                            [self toHomeViewController];
                        }else{
                            [self notLoginAction];
                        }
                    }
                }
            };
            return cell;
        }else{
            static NSString *CellIdentifier = @"webCell";
            NADocPadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[NADocPadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            
                if ([NASaveData getIsHaveWebBtn]) {
                    [cell.docView1.imageView setImage:[UIImage imageNamed:@"web.png"]];
                    [cell.docView1 updateMainTitleWithName:@"Web"];
                    [cell.docView1 updateTitleWithName:@""];
                    cell.docView1.tag = 1;
                    if ([NASaveData getIsHaveExtraImage]) {
                        [cell.docView2.imageView setImage:[UIImage imageNamed:@"extraImage.png"]];
                        [cell.docView2 updateMainTitleWithName:NSLocalizedString(@"extra", nil) ];
                        [cell.docView2 updateTitleWithName:@""];
                        cell.docView2.tag = 2;
                    }
                    
                    cell.selectedObjectCompletionBlock = ^(id object) {
                        UIView *view = (UIView *)object;
                        if (view.tag) {
                            if (view.tag==1) {
                                [self toTOWebViewControllerWithUrlStr:[NASaveData getWebUrl]];
                            }else{
                                [self toTOWebViewControllerWithUrlStr:[NASaveData getExtraUrl]];
                            }
                        }
                    };
                }else{
                    if ([NASaveData getIsHaveExtraImage]) {
                        [cell.docView1.imageView setImage:[UIImage imageNamed:@"extraImage.png"]];
                        [cell.docView1 updateMainTitleWithName:NSLocalizedString(@"extra", nil) ];
                        [cell.docView1 updateTitleWithName:@""];
                        
                        cell.selectedObjectCompletionBlock = ^(id object) {
                            UIView *view = (UIView *)object;
                            if (view.tag) {
                                [self toTOWebViewControllerWithUrlStr:[NASaveData getExtraUrl]];
                                
                            }
                        };
                        
                    }
                    
                }
                return cell;
        }
        
    }else{
        if (indexPath.section==0) {
        static NSString *CellIdentifier = @"Cell";
        NADocCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[NADocCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectedObjectCompletionBlock=nil;
        cell.leftDocView.hidden=YES;
        cell.rightDocView.hidden=YES;

        NSUInteger index = indexPath.row * 2;
        
        if (index < self.topPageArray.count) {
            cell.leftDocView.hidden=NO;
            NADoc *doc = self.topPageArray[index];
            [cell.leftDocView imageViewWthInfo:doc];
            cell.leftDocView.tag = index;
            
            [cell.leftDocView updateMainTitleWithName:[self getMainTitleText:doc]];
            [cell.leftDocView updateTitleWithName:[self getSubTitleText:doc]];
            
            if([self isLogin]){
                cell.leftDocView.imageIdentfier.hidden=YES;
            }else{
                cell.leftDocView.imageIdentfier.hidden=NO;
            }
            if ([doc.publication_disOrder3 isEqualToString:@"1"]) {
                [cell.leftDocView.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_sample"]];
            }else{
                [cell.leftDocView.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_cost"]];
            }
            
        }
        
            
        index = indexPath.row * 2 + 1;
        if (index < self.topPageArray.count) {
            cell.rightDocView.hidden=NO;
            NADoc *doc = self.topPageArray[index];
            [cell.rightDocView imageViewWthInfo:doc];
            cell.rightDocView.tag = index;
            
            [cell.rightDocView updateMainTitleWithName:[self getMainTitleText:doc]];
            [cell.rightDocView updateTitleWithName:[self getSubTitleText:doc]];
            
            if([self isLogin]){
                cell.rightDocView.imageIdentfier.hidden=YES;
            }else{
                cell.rightDocView.imageIdentfier.hidden=NO;
            }
            if ([doc.publication_disOrder3 isEqualToString:@"1"]) {
                [cell.rightDocView.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_sample"]];
            }else{
                [cell.rightDocView.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_cost"]];
            }
            
            
        }
            
        
        
        cell.selectedObjectCompletionBlock = ^(id object) {
            UIView *view = (UIView *)object;
            if (view.tag<self.topPageArray.count) {
                NADoc *doc = self.topPageArray[view.tag];
                currentTopPageDoc=doc;
                if ([doc.publication_disOrder3 isEqualToString:@"1"]) {
                    //无料
                    if([NASaveData getIsVisitorModel]){
                        //[NASaveData saveUserId:[NASaveData getDefaultUserID]];
                    }
                    
                    [self toHomeViewController];
                }else{
                    if ([self isLogin]) {
                        [self toHomeViewController];
                    }else{
                        [self notLoginAction];
                    }

                }
            }
            
        };
            return cell;
        }else{
            static NSString *CellIdentifier = @"webCell";
            NADocCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[NADocCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.selectedObjectCompletionBlock=nil;
            cell.leftDocView.hidden=YES;
            cell.rightDocView.hidden=YES;
            if ([NASaveData getIsHaveWebBtn]) {
                    cell.leftDocView.imageIdentfier.hidden=YES;
                    cell.leftDocView.hidden=NO;
                    cell.leftDocView.tag = 1;
                    [cell.leftDocView.imageView setImage:[UIImage imageNamed:@"web.png"]];
                    [cell.leftDocView updateMainTitleWithName:@"Web"];
                    [cell.leftDocView updateTitleWithName:@""];
                if ([NASaveData getIsHaveExtraImage]) {
                        cell.rightDocView.imageIdentfier.hidden=YES;
                        cell.rightDocView.hidden=NO;
                        cell.rightDocView.tag = 2;
                        [cell.rightDocView.imageView setImage:[UIImage imageNamed:@"extraImage.png"]];
                        [cell.rightDocView updateMainTitleWithName:NSLocalizedString(@"extra", nil) ];
                        [cell.rightDocView updateTitleWithName:@""];
                }
            }else{
                if ([NASaveData getIsHaveExtraImage]) {
                        cell.leftDocView.imageIdentfier.hidden=YES;
                        cell.leftDocView.hidden=NO;
                        cell.leftDocView.tag = 2;
                        [cell.leftDocView.imageView setImage:[UIImage imageNamed:@"extraImage.png"]];
                        [cell.leftDocView updateMainTitleWithName:NSLocalizedString(@"extra", nil) ];
                        [cell.leftDocView updateTitleWithName:@""];

                }
            }
            cell.selectedObjectCompletionBlock = ^(id object) {
                UIView *view = (UIView *)object;
                if (view.tag==1){
                    [self toTOWebViewControllerWithUrlStr:[NASaveData getWebUrl]];
                }else if (view.tag==2){
                    [self toTOWebViewControllerWithUrlStr:[NASaveData getExtraUrl]];
                }
            };
    
            return cell;
        }
        
        
    }
}
-(BOOL)isLogin{
    if(![NASaveData getIsVisitorModel]){
        if (self.isLoginToTop) {
            return YES;
        }else{
            if ([NASaveData isSaveUserInfo]) {
                return YES;
            }else{
                return NO;
            }
        }
        
    }else{
        return NO;
    }
    
}
#pragma mark to change page

-(void)toTOWebViewControllerWithUrlStr:(NSString *)urlStr{
    NSURL *url =[NSURL URLWithString:urlStr];
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    webViewController.showActionButton=NO;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
}
-(void)openBrowser:(NSString *)urlStr{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}
-(void)toHomeViewController{
    
    
    NAHomeViewController *home = [[NAHomeViewController alloc] init];
    if ([currentTopPageDoc.publication_disOrder3 isEqualToString:@"1"]) {
        home.forwardPage=@"topPage_noUserid";
    }else{
        home.forwardPage=@"topPage";
    }
    
    home.topPageDoc=currentTopPageDoc;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
    [self presentViewController:nav animated:YES completion:^{
        

    }];
}
/**
 * 紙面画面のTitleを取得
 *
 */
-(NSString *) getMainTitleText:(NADoc *)doc
{
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    components.year = [doc.publishDate substringWithRange:NSMakeRange(0, 4) ].intValue;
    components.month =[doc.publishDate substringWithRange:NSMakeRange(4, 2) ].intValue;
    components.day =[doc.publishDate substringWithRange:NSMakeRange(6, 2) ].intValue;
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now =[gregorian dateFromComponents:components] ;
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    
    [formater setDateFormat:@"MM月dd日 (ccc)"];
    
    return [formater stringFromDate:now];
}

/**
 * 紙面画面のTitleを取得
 *
 */
-(NSString *) getSubTitleText:(NADoc *)doc
{
    NSString * title = @"";
    
    title = [title stringByAppendingString:[NSString stringWithFormat:@"%@ %@",doc.publicationInfoName,doc.editionInfoName ]];
    return title;
}




@end

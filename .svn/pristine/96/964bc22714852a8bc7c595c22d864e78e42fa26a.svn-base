
#import "NADayJournalViewController.h"
#import "NADocCell.h"
#import "NADocPadCell.h"
@interface NADayJournalViewController () <UITableViewDataSource, UITableViewDelegate>{
    NADoc *currentDoc;
    NALoginAlertView *myalertview;
    BOOL isTempAutoLogin;
    BOOL isTempAllDownload;

}

@property (nonatomic, strong) UITableView *tView;
@property (nonatomic, strong) NSMutableArray *dateSelectedArray;

@end

@implementation NADayJournalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDateSelected];
}

/**
 * 画面回転の前処理
 *
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.presentingViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

/**
 * 画面回転の後処理
 *
 */
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.presentingViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

/**
 * view初期化
 *
 */
- (void)initViews
{
    [super initViews];
    self.navigationItem.leftBarButtonItem = self.backBtnItem;
    [self.view addSubview:self.tView];
    self.dateSelectedArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tView.hidden = YES;
    
    

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
    self.tView.frame = CGRectMake(0, navHeight, screenWidth, screenHeight - navHeight);
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count  = 0;
    NSInteger item = isPad ? 4 : 2;
    count = self.dateSelectedArray.count / item;
    if (self.dateSelectedArray.count % item != 0) {
        count = count + 1;
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat ret = 190.0f;
    if (isPad) {
        ret = 240.0f;
    }
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isPad) {
        static NSString *CellIdentifier = @"Cell";
        NADocPadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[NADocPadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        NSInteger index = indexPath.row * 4;
        if (index < self.dateSelectedArray.count) {
            NADoc *doc = self.dateSelectedArray[index];
            cell.docView1.tag = index + 1;
            [self setMyCollectionView:cell.docView1 withDoc:doc];
        }
        index = indexPath.row * 4 + 1;
        if (index < self.dateSelectedArray.count) {
            NADoc *doc = self.dateSelectedArray[index];
            cell.docView2.tag = index + 1;
            [self setMyCollectionView:cell.docView2 withDoc:doc];
        }
        index = indexPath.row * 4 + 2;
        if (index < self.dateSelectedArray.count) {
            NADoc *doc = self.dateSelectedArray[index];
            cell.docView3.tag = index + 1;
            [self setMyCollectionView:cell.docView3 withDoc:doc];
        }
        index = indexPath.row * 4 + 3;
        if (index < self.dateSelectedArray.count) {
            NADoc *doc = self.dateSelectedArray[index];
            cell.docView4.tag = index + 1;
            [self setMyCollectionView:cell.docView4 withDoc:doc];
        }
        cell.selectedObjectCompletionBlock = ^(id object) {
            UIView *view = (UIView *)object;
            if (view.tag) {
                NADoc *tmpDoc=self.dateSelectedArray[view.tag - 1];
                currentDoc=tmpDoc;
                [self dismissViewControllerAnimated:YES completion:^{
                    if (self.selectedDocCompletionBlock) {
                        self.selectedDocCompletionBlock (tmpDoc);
                    }
                    
                }];
            }
        };
        return cell;

    }else{
        static NSString *CellIdentifier = @"Cell";
        NADocCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[NADocCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        NSInteger index = indexPath.row * 2;
        if (index < self.dateSelectedArray.count) {
            NADoc *doc = self.dateSelectedArray[index];
            cell.leftDocView.tag = index + 1;
            [self setMyCollectionView:cell.leftDocView withDoc:doc];
        }
        index = indexPath.row * 2 + 1;
        if (index < self.dateSelectedArray.count) {
            NADoc *doc = self.dateSelectedArray[index];
            cell.rightDocView.tag = index + 1;
            [self setMyCollectionView:cell.rightDocView withDoc:doc];
        }
        cell.selectedObjectCompletionBlock = ^(id object) {
            UIView *view = (UIView *)object;
            if (view.tag) {
                NADoc *tmpDoc=self.dateSelectedArray[view.tag - 1];
                currentDoc=tmpDoc;
                [self dismissViewControllerAnimated:YES completion:^{
                    if (self.selectedDocCompletionBlock) {
                        self.selectedDocCompletionBlock (tmpDoc);
                    }
                    
                }];
            }
            
        };
        return cell;
    }
}
-(void)setMyCollectionView:(UIView *)myCollectionView withDoc:(NADoc *)mydoc{
    NASubPagerView *myPageView=(NASubPagerView *)myCollectionView;
    [myPageView imageViewWthInfo:mydoc];
    [myPageView updateMainTitleWithName:[self getMainTitleText:mydoc]];
    [myPageView updateTitleWithName:[self getSubTitleText:mydoc]];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
-(void)notLoginAction{
    myalertview=[[NALoginAlertView alloc]init];
    myalertview.delegate=self;
//    isTempAutoLogin=myalertview.saveIDSwitch.isOn;
//    isTempAllDownload=myalertview.allDownloadSwitch.isOn;
    [myalertview show];
}
-(void)cancelLoginClick{
    
}
#pragma mark - NALoginAlertView delegate -
#pragma mark
-(void)loginClick:(NSString *)username Password:(NSString *)password{
    [self getLoginAPIWithUsername:username ThePassword:password];
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
                                                  
                                                  if (isTempAutoLogin) {
                                                      [NASaveData SaveLoginWithID:login.userId withPassWord:login.password];
                                                      
                                                  }
                                                  [self dismissViewControllerAnimated:YES completion:^{
                                                      if (self.selectedDocCompletionBlock) {
                                                          self.selectedDocCompletionBlock (currentDoc);
                                                      }
                                                  }];
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
-(void)switchDidChange:(BOOL)isAutoLogin TheAllDownload:(BOOL)isAllDownload{
    
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
    NSString * title = [NSString stringWithFormat:@"%@ ",doc.publicationInfoName];

    title = [title stringByAppendingString:doc.editionInfoName ];
    return title;
}



/**
 * 一覧情報を取得
 *
 */
- (void)getDateSelected
{
//    NSLog(@"getDateSelected") ;
    
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    NADoc *doc = self.currDoc;
    NSDictionary *param;
    if ([NASaveData getIsVisitorModel]) {
        param = @{
                  @"Userid"     :  [NASaveData getLoginUserId],
                  @"K090"       :  @"010",
                  @"Rows"       :  @"99",
                  @"K003"       :  [NSString stringWithFormat:@"20000101:%@",[Util getSystemDate]],
                  @"K004"       :  doc.publisherGroupInfoId,
                  @"K006"       :  doc.publicationInfoId,
                  @"K005"       :  doc.publisherInfoId,
                  @"K014"       :  @"1",
                  @"UseDevice"  :  NAUserDevice,
                  @"K002"       :  @"2",
                  @"Mode"       :  @"1",
                  @"Sort"       :  @"K003:desc,K008:asc,K012:asc",
                  @"Fl"         :  [NSString searchDateSelectedFl]
                  };
    }else{
        param = @{
                  @"Userid"     :  [NASaveData getLoginUserId],
                  @"K090"       :  @"010",
                  @"Rows"       :  @"99",
                  @"K003"       :  [NSString stringWithFormat:@"20000101:%@",[Util getSystemDate]],
                  @"K004"       :  doc.publisherGroupInfoId,
                  @"K006"       :  doc.publicationInfoId,
                  @"K005"       :  doc.publisherInfoId,
                  @"K014"       :  @"1",
                  @"UseDevice"  :  NAUserDevice,
                  @"K002"       :  @"2",
                  @"Mode"       :  @"1",
                  @"Sort"       :  @"K003:desc,K008:asc,K012:asc",
                  @"Fl"         :  [NSString searchDateSelectedFl]
                  
                  };
    }
    [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
        if (error) {
           ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
            [self dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        SHXMLParser *parser = [[SHXMLParser alloc] init];
        NSDictionary *dic = [parser parseData:search];
        NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
        NSArray *array = searchBaseClass.response.doc;
        NSMutableArray *mutableArray = [NSMutableArray array];
//        NSString *currentDate = @"";
//        
//        dic=[NAFileManager ChangePlistTodic];
//        NSString *numstr=[dic objectForKey:[NSString stringWithFormat:@"%@%@",NAShowdaycountkey,doc.publicationInfoId]];
//        if (numstr==nil) {
//            numstr=[dic objectForKey:[NSString stringWithFormat:NAShowdaycountdefaultkey]];
//        }

        for (NADoc *doc in array) {
//                if (mutableArray.count > [numstr integerValue] - 1) {
//                    break;
//                }
//                
//                currentDate = doc.publishDate;
                [mutableArray addObject:doc];
        }

        [self.dateSelectedArray removeAllObjects];
        self.dateSelectedArray=mutableArray;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.dateSelectedArray.count > 0) {
                [self.tView reloadData];
                self.tView.hidden = NO;
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
                [ProgressHUD dismiss];
            }
            
        });
        
    }];
}
@end

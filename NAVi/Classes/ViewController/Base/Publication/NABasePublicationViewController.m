
#import "NABasePublicationViewController.h"


@interface NABasePublicationViewController ()<UITableViewDataSource, UITableViewDelegate>{
   
}


@end

@implementation NABasePublicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];

    BACK(^{
        self.dateSelectedArray = [NSMutableArray array];
        
        if ([NACheckNetwork sharedInstance].isHavenetwork) {
            [self getPublicationAPI];
        }else{
            NSArray *info = [[NAFileManager sharedInstance] masterPublisherGroupInfo];
            [self getDocsFromLocal:info];
        }
    });
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
    if (![NASaveData getIsVisitorModel]) {
        self.title=NSLocalizedString(@"topPage", nil);
    }
    self.navigationItem.leftBarButtonItem = self.backBtnItem;
    [self.view addSubview:self.tView];
    self.dateSelectedArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tView.hidden = YES;

}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        //新建窗口处理代码
        //request.URL
        [self toTOWebViewControllerWithUrlStr:[request.URL absoluteString]];
        return NO;
    }
    
    return YES;
}
-(void)toTOWebViewControllerWithUrlStr:(NSString *)urlStr{
    NSURL *url =[NSURL URLWithString:urlStr];
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    //webViewController.navigationButtonsHidden=YES;
    webViewController.showActionButton=NO;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.view addSubview:self.mywebview];
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
            [cell.docView1 imageViewWthInfo:doc];
            cell.docView1.tag = index + 1;
            [cell.docView1 updateTitleWithName:[self getSubTitleText:doc]];
            [cell.docView1 updateMainTitleWithName:[self getMainTitleText:doc]];
        }
        index = indexPath.row * 4 + 1;
        if (index < self.dateSelectedArray.count) {
            NADoc *doc = self.dateSelectedArray[index];
            [cell.docView2 imageViewWthInfo:doc];
            cell.docView2.tag = index + 1;
            [cell.docView2 updateTitleWithName:[self getSubTitleText:doc]];
            [cell.docView2 updateMainTitleWithName:[self getMainTitleText:doc]];
        }
        index = indexPath.row * 4 + 2;
        if (index < self.dateSelectedArray.count) {
            NADoc *doc = self.dateSelectedArray[index];
            [cell.docView3 imageViewWthInfo:doc];
            cell.docView3.tag = index + 1;
            [cell.docView3 updateTitleWithName:[self getSubTitleText:doc]];
            [cell.docView3 updateMainTitleWithName:[self getMainTitleText:doc]];
        }
        index = indexPath.row * 4 + 3;
        if (index < self.dateSelectedArray.count) {
            NADoc *doc = self.dateSelectedArray[index];
            [cell.docView4 imageViewWthInfo:doc];
            cell.docView4.tag = index + 1;
            [cell.docView4 updateTitleWithName:[self getSubTitleText:doc]];
            [cell.docView4 updateMainTitleWithName:[self getMainTitleText:doc]];
        }
        cell.selectedObjectCompletionBlock = ^(id object) {
            UIView *view = (UIView *)object;
            if (view.tag) {
                [self dismissViewControllerAnimated:YES completion:^{
                    if (self.selectedDocCompletionBlock) {
                        self.selectedDocCompletionBlock (self.dateSelectedArray[view.tag - 1]);
                    }
                    
                }];
            }else{
                //                [self dismissViewControllerAnimated:YES completion:^{
                //                }];
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
            [cell.leftDocView imageViewWthInfo:doc];
            cell.leftDocView.tag = index + 1;
            [cell.leftDocView updateMainTitleWithName:[self getMainTitleText:doc]];
            [cell.leftDocView updateTitleWithName:[self getSubTitleText:doc]];
        }
        index = indexPath.row * 2 + 1;
        if (index < self.dateSelectedArray.count) {
            NADoc *doc = self.dateSelectedArray[index];
            [cell.rightDocView imageViewWthInfo:doc];
            cell.rightDocView.tag = index + 1;
            [cell.rightDocView updateMainTitleWithName:[self getMainTitleText:doc]];
            [cell.rightDocView updateTitleWithName:[self getSubTitleText:doc]];
        }
        cell.selectedObjectCompletionBlock = ^(id object) {
            UIView *view = (UIView *)object;
            [self dismissViewControllerAnimated:YES completion:^{
                if (self.selectedDocCompletionBlock) {
                    self.selectedDocCompletionBlock (self.dateSelectedArray[view.tag - 1]);
                }
                
            }];
        };
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    NSString * title = doc.publicationInfoName;
    
    title = [title stringByAppendingString:@" "];
    title = [title stringByAppendingString:doc.editionInfoName ];
    return title;
}

/**
 * 一覧情報を取得
 *
 */
- (void)getPublicationAPI
{
    
    NSArray *publications = nil;
    NAPublisherGroupInfo *info=nil;
    NSArray *infos = [[NAFileManager sharedInstance] masterPublisherGroupInfo];
    for (NAPublisherGroupInfo *sub in infos) {
        if ([sub.publisherGroupInfoIdentifier isEqualToString:self.currDoc.publisherGroupInfoId]) {
            info = sub;
            break;
        }
        
    }
    NSArray *publishers = info.publisherInfo;
    for (NAPublisherInfo *sub in publishers) {
        if ([sub.publisherInfoIdentifier isEqualToString:self.currDoc.publisherInfoId]) {
            publications = sub.publicationInfo;
            break;
        }
    }
    
    if (publications.count > 0) {
        [self getPublicationInfo:publications index:0];
    }else{
        MAIN(^{
            [ProgressHUD dismiss];
            
        });
    }
    self.publisherInfoArray = [[NSMutableArray alloc]initWithArray:publishers];
    
}

- (void)getPublicationInfo:(NSArray *)list index:(NSInteger)index
{
    if (index >= list.count) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.dateSelectedArray.count > 0) {
                [self.tView reloadData];
                self.tView.hidden = NO;
                
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
            [ProgressHUD dismiss];
        });
        return;
    }
    
    NSString *userId = [NASaveData getDefaultUserID];
    if ([NASaveData getLoginUserId]) {
        userId=[NASaveData getLoginUserId];
    };
   
    NADoc *doc = self.currDoc;
    NAPublicationInfo *indexDoc =list[index];
    NSDictionary *param = @{
                            @"Userid"     :  userId,
                            @"K090"       :  @"010",
                            @"Rows"       :  @"1",
                            @"K003"       :  [NSString stringWithFormat:@"20000101:%@",[Util getSystemDate]],
                            @"K004"       :  doc.publisherGroupInfoId,
                            @"K005"       :  doc.publisherInfoId,
                            @"K006"       :  indexDoc.publicationInfoIdentifier,
                            @"K014"       :  @"1",
                            @"UseDevice"  :  NAUserDevice,
                            @"K002"       :  @"2",
                            @"Mode"       :  @"1",
                            @"K014"       :  @"1",
                            @"Sort"       :  @"K003:desc,K032:desc,K008:desc",
                            @"Fl"         :  [NSString searchDateSelectedFl]
                            };
    [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
        if (!error) {
            SHXMLParser *parser = [[SHXMLParser alloc] init];
            NSDictionary *dic = [parser parseData:search];
            NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
            if (searchBaseClass.response.doc.count > 0) {
                NADoc *tmpDoc=searchBaseClass.response.doc[0];
                tmpDoc.publication_disOrder1=indexDoc.dispOrder1;
                tmpDoc.publication_disOrder3=indexDoc.dispOrder3;
                tmpDoc.user_id=userId;
                if (![[NASQLHelper sharedInstance]isHavePaperInfoByDoc:tmpDoc]) {
                    [[NASQLHelper sharedInstance]addPaperInfo:tmpDoc];
                }
                [[NAFileManager sharedInstance] saveSearchFileWithData:search Mydoc:tmpDoc];
                [self.dateSelectedArray addObject:tmpDoc];
            }
            [self getPublicationInfo:list index:index + 1];
        }else{
            ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
            [self dismissViewControllerAnimated:YES completion:nil];
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
                                    if ([self.currDoc.publisherGroupInfoId isEqualToString:napg.publisherGroupInfoIdentifier]&&[self.currDoc.publisherInfoId isEqualToString:publisherInfo.publisherInfoIdentifier]) {
                                        [self.dateSelectedArray addObject:doc];
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
            
        }
    }
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"publication_disOrder4" ascending:NO];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"publication_disOrder1" ascending:YES];
    [self.dateSelectedArray sortUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor1,sortDescriptor2, nil]];
    MAIN(^{
        
        if (self.dateSelectedArray.count > 0) {
            [self.tView reloadData];
            self.tView.hidden = NO;
            
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        [ProgressHUD dismiss];
    });
    
}

@end


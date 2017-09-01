
#import "NAClipViewController.h"
#import "NADetailViewController.h"
#import "NASearchViewController.h"
#import "TOWebViewController.h"
#import "NASettingViewController.h"
#import "NANoteListViewController.h"
#import "NADayJournalViewController.h"
#import "NANewDayJournalViewController.h"
#import "NANewSearchViewController.h"
#import "NANewSettingViewController.h"
#import "NANewClipEditingViewController.h"
#import "NANewChooseClipViewController.h"
#import "NANewChooseClipViewController.h"
#import "JXButton.h"
#import "NAShowClipAlertView.h"
#import "NAAddClipViewController.h"
#import "FontUtil.h"
#import "NADetailBaseViewController.h"
@interface NAClipViewController ()<NAShowClipAlertViewDelegate>
    {
        NSInteger isHaveRegion;//是否有地域版
    }
@property (nonatomic, strong) UITableView *tView;
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, assign) NAMyGripTableViewCellDeviceType gripCellType;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
//@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) NSMutableArray *clipArray;
@property (nonatomic, assign) UIInterfaceOrientation oldFromInterfaceOrientation;
@property (nonatomic, assign) UIInterfaceOrientation oldToInterfaceOrientation;
@property (nonatomic, assign) BOOL isNotelistChange;
@property (nonatomic, strong) NAShowClipAlertView *showClipView;
@property (nonatomic, strong) NSMutableArray *clipTagArray;
@property (nonatomic, strong) NSMutableArray *originDataSouce;
@end

@implementation NAClipViewController{
    NSInteger titlelength;
    NSInteger detailtitlelength;
}
@synthesize imageview;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadClip) name:NOTYReloadClip object:nil];
    [self reloadClip];

}
- (void)viewWillAppear:(BOOL)animated{
    if ([self isLandscape]) {
        [self setHorToolBar];
        [_showClipView dismissMyview];
    }else{
        [self resetHomeToolBar];
        [_showClipView dismissMyview];
    }
   [self setDairy];
}

- (void)chooseDay{
    [self toDayJournalViewController];
}
/**
 * 日付選択画面を表示
 *
 */
- (void)toDayJournalViewController
{
    
    //    NSLog(@"toDayJournalViewController") ;
    if (![NACheckNetwork sharedInstance].isHavenetwork) {
        
        [[[iToast makeText:NSLocalizedString(@"networkerror", @"")]
          setGravity:iToastGravityBottom] show];
        return;
    }
    
    NANewDayJournalViewController *day = [[NANewDayJournalViewController alloc] init];
    day.currDoc = self.pageArray[0];
    day.regionDic = _regionDic;
    day.selectedDocCompletionBlock = ^(NADoc *doc) {
        [NASaveData saveIsPublication:NO];
        [self controlTheBlockWithdocClip:doc];
    };
    day.selectedIsHaveRegionBlock = ^(NSInteger isHaveRegion2){
        isHaveRegion = isHaveRegion2;
    };
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:day];
    [self presentViewController:nav animated:YES completion:^{
        [[NADownloadHelper sharedInstance] stopNoty];
    }];
    // GA(tag manager)
    //[TAGManagerUtil pushButtonClickEvent:ENDateListBtn label:[self getLabelName]];
}
/**
 * 選択した紙面を表示
 *
 */
-(void)controlTheBlockWithdocClip:(NADoc *)doc{
    NADoc *tempdoc = self.pageArray[0];
    if ( [tempdoc.editionInfoId isEqualToString:doc.editionInfoId]
        &&[tempdoc.publicationInfoId isEqualToString:doc.publicationInfoId]
        &&[tempdoc.publisherInfoId isEqualToString:doc.publisherInfoId]
        &&[tempdoc.publisherGroupInfoId isEqualToString:doc.publisherGroupInfoId]
        &&[tempdoc.publishDate isEqualToString:doc.publishDate]) {
        //same
        NAHomeViewController *home = [[NAHomeViewController alloc] init];
        home.forwardPage=@"topPage";
        home.topPageDoc= _topPageDoc;
        home.regionDic = _regionDic;
        home.clipDataSource = self.dataSouce;
        home.homePageArray = _pageArray;
        home.dayNumber = 0;
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
        [self presentViewController:nav animated:NO completion:^{
            
            
        }];
        [ProgressHUD dismiss];
    }else{
        //different
        NAHomeViewController *home = [[NAHomeViewController alloc] init];
        home.forwardPage=@"topPage";
        home.topPageDoc= _topPageDoc;
        home.clipDataSource = self.dataSouce;
        home.homePageArray = _pageArray;
        home.dayNumber = 1;
        home.regionDic = _regionDic;
        home.dayDoc = doc;
        home.regionFlg = isHaveRegion;
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
        [self presentViewController:nav animated:NO completion:^{
            
            
        }];
    }
    
}
//reload clip
-(void)reloadClip{
    MAIN(^{
        [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
        if (_clipNumber == 1 && _clipDataSource.count != 0) {
            self.dataSouce = _clipDataSource;
            [self.tView reloadData];
            [ProgressHUD dismiss];
        }else{
            [self getClipAPI];
        }
    });
    
    //[self getClipAPI];
    self.clipArray = [NSMutableArray array];
    if (_clipNumber == 1 && _clipDataSource.count != 0) {
        self.dataSouce = _clipDataSource;
        [self.tView reloadData];
        [ProgressHUD dismiss];
    }else{
        [self getClipAPI];
    }
    // prpertyファイルから記事情報を取得
    NSDictionary *dic=[NAFileManager ChangePlistTodic];
    titlelength=[[dic objectForKey:NANewsTitleLengthkey] integerValue];
    detailtitlelength=[[dic objectForKey:NANewsTextLengthkey] integerValue];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // GA
    //[TAGManagerUtil pushOpenScreenEvent:ENClipView ScreenName:NSLocalizedString(@"clipView", nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 画面回転の前処理
 *
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (self.oldToInterfaceOrientation == toInterfaceOrientation) {
        return;
    }
    self.oldToInterfaceOrientation = toInterfaceOrientation;
    if ([self isLandscape]) {
        [_showClipView dismissMyview];
    }else{
        [_showClipView dismissMyview];
    }

    [self.tView removeFromSuperview];
    _tView = nil;
    _tView = self.tView;
    self.gripCellType = [self deviceType:toInterfaceOrientation];
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.presentingViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

/**
 * 画面回転の後処理
 *
 */
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (self.oldFromInterfaceOrientation == fromInterfaceOrientation) {
        return;
    }
    self.oldFromInterfaceOrientation = fromInterfaceOrientation;
    if ([self isLandscape]) {
        [self setHorToolBar];
        [_showClipView dismissMyview];
    }else{
        [self resetHomeToolBar];
        [_showClipView dismissMyview];
    }
    
    [self.view addSubview:self.tView];
    [self.tView addGestureRecognizer:self.singleTap];
     self.tView.separatorStyle = UITableViewCellEditingStyleNone;
    //[self.tView addGestureRecognizer:self.longPressGesture];
    
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
    [self setDairy];
    UIImageView *titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rangai_daiji"]];
    self.navigationItem.titleView = titleView;
    self.navigationItem.leftBarButtonItem = self.searchBarItem;
    self.navigationItem.rightBarButtonItem = self.webBarItem;
    self.gripCellType = [self deviceType:self.interfaceOrientation];
    self.tView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:self.tView];
    
    [self.tView addGestureRecognizer:self.singleTap];
    //[self.tView addGestureRecognizer:self.longPressGesture];
    
    imageview=[[UIImageView alloc]init];
    imageview.image=[UIImage imageNamed:@"icon_delete"];
    imageview.alpha=0;
    [_tView addSubview:imageview];
    [_tView sendSubviewToBack:imageview];
    
    if ([self isLandscape]) {
        [self setHorToolBar];
    }else{
        [self resetHomeToolBar];
    }

}
- (BOOL)isLandscape
{
    
    return ([Util screenSize].width>[Util screenSize].height);
}

- (void) pushItemDetail:(UIButton *)sender
{
    if (sender.tag == 1001) {
        [_showClipView dismissMyview];
        [self toHomeViewController];
    }else if (sender.tag == 1002){
        [_showClipView dismissMyview];
    }else if (sender.tag == 1003){
        [_showClipView dismissMyview];
        [self toNoteListViewController];
    }else if (sender.tag == 1005){
        [_showClipView dismissMyview];
        [self toSettingViewContreller];
    }else if (sender.tag == 1004){
        [self getTagClipAPI];
        
    }
}
#pragma NAShowClipAlertViewDelegate
-(void)addClipClick{
    [_showClipView dismissMyview];
    NAAddClipViewController *note = [[NAAddClipViewController alloc]init];
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:note];
    [self presentViewController:nav animated:NO completion:^{
        
    }];
}

-(void)chooseClipButton:(UIButton *)sender {
    NSString *tagId = [NSString stringWithFormat:@"%ld", (long)sender.tag];
    if (sender.isSelected) {
        [self getClipAPI];
    } else {
        [self searchFavoritesList:tagId];
    }
    [_showClipView dismissMyview];
}

-(void)toHomeViewController{
    
    
    NAHomeViewController *home = [[NAHomeViewController alloc] init];
    home.forwardPage=@"topPage";
    home.topPageDoc= _topPageDoc;
    home.clipDataSource = self.dataSouce;
    home.homePageArray = _pageArray;
    home.regionDic = _regionDic;
//    home.noteNumber = _noteNumber;
//    home.NoteArray = _NoteArray;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
    [self presentViewController:nav animated:NO completion:^{
        
        
    }];
}
/**
 * 記事リスト画面を表示
 *
 */
- (void)toNoteListViewController
{
    
    NANoteListViewController *note = [[NANoteListViewController alloc]init];
    note.pageArray = _pageArray;
    note.topPageDoc= _topPageDoc;
    note.regionDic = _regionDic;
    note.clipDataSource = self.dataSouce;
//    note.noteNumber = _noteNumber;
//    note.NotePageArray = _NoteArray;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:note];
    [self presentViewController:nav animated:NO completion:^{
        
    }];
    // GA(tag manager)
    //[TAGManagerUtil pushButtonClickEvent:ENKijiListBtn label:ENKijiListLab];
}


/**
 * 設定画面を表示
 *
 */
- (void)toSettingViewContreller
{
    NANewSettingViewController *setting = [[NANewSettingViewController alloc] init];
    setting.pageArray = _pageArray;
    setting.topPageDoc = _topPageDoc;
    setting.clipDataSource = _clipDataSource;
    setting.regionDic = _regionDic;

//    setting.noteNumber = _noteNumber;
//    setting.NoteArray = _NoteArray;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:setting];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    // GA(tag manager)
    //[TAGManagerUtil pushButtonClickEvent:ENSetupBtn label:[self getLabelName]];

}
/**
 * view更新
 *
 */
- (void)updateViews
{
    [super updateViews];
    CGFloat screenWidth = [Util screenSize].width;
    CGFloat screenHeight = [Util screenSize].height;
    CGFloat barHeight = TOOLBAR_HEIGHT;
    self.searchBarItem.customView.frame=CGRectMake(self.searchBarItem.customView.frame.origin.x, self.searchBarItem.customView.frame.origin.y, (self.navigationController.navigationBar.frame.size.height-4)/2 +5, (self.navigationController.navigationBar.frame.size.height-4)/2 + 5);
    self.webBarItem.customView.frame=CGRectMake(self.webBarItem.customView.frame.origin.x, self.webBarItem.customView.frame.origin.y, (self.navigationController.navigationBar.frame.size.height-4)/2 + 5, (self.navigationController.navigationBar.frame.size.height-4)/2 + 5);
    self.navigationItem.titleView.frame=CGRectMake(self.navigationItem.titleView.frame.origin.x, self.navigationItem.titleView.frame.origin.y, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height);
    if (isPhone) {
        self.toolBar.frame = CGRectMake(0, self.view.frame.size.height - barHeight, screenWidth, barHeight);
    }else{
        self.toolBar.frame = CGRectMake(0, self.view.frame.size.height - 49, screenWidth, 49);
    }
    if ([self isLandscape]) {
        if (isPhone) {
            self.tView.frame = CGRectMake(0, 0, screenWidth, screenHeight-44-34);
        }else{
            self.tView.frame = CGRectMake(0, 0, screenWidth, screenHeight-49-64);
        }
    }else{
        if (isPhone) {
            self.tView.frame = CGRectMake(0, 0, screenWidth, screenHeight-44-64);
        }else{
            self.tView.frame = CGRectMake(0, 0, screenWidth, screenHeight-49-64);
        }
    }
    
}

#pragma mark - layout -
#pragma mark
/**
 * searchBarItem初期化（検索ボタン）
 *
 */
- (UIBarButtonItem *)searchBarItem
{
    if (!_searchBarItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"06_blue"]
                          forState:UIControlStateNormal];
        [button addTarget:self action:@selector(searchBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 25, 25);
        
        _searchBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }
    return _searchBarItem;
}
/**
 * 検索ボタンクリック
 *
 */
- (void)searchBarItemAction:(id)sender
{
    [self toSearchViewController];
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
    search.regionDic =_regionDic;
    search.clipDataSource = _clipDataSource;
//    search.noteNumber = _noteNumber;
//    search.NoteArray = _NoteArray;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:search];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

-(void)controlTheBlockWithdoc:(NADoc *)doc{
    NADoc *tempdoc = self.dataSouce[0];
    if ( [tempdoc.editionInfoId isEqualToString:doc.editionInfoId]
        &&[tempdoc.publicationInfoId isEqualToString:doc.publicationInfoId]
        &&[tempdoc.publisherInfoId isEqualToString:doc.publisherInfoId]
        &&[tempdoc.publisherGroupInfoId isEqualToString:doc.publisherGroupInfoId]
        &&[tempdoc.publishDate isEqualToString:doc.publishDate]) {
        [ProgressHUD dismiss];
    }else{
        if (_clipNumber == 1 && _clipDataSource.count != 0)
        {
        }else{
            [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
        }
        //[self searchCurrentApi:doc ByUserid:[NASaveData getLoginUserId]];
    }
    
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

- (void)showWeb{
    [self toWebViewController];
}
-(void)toWebViewController{
    NSURL *url =[NSURL URLWithString:[NASaveData getWebUrl]];
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    //webViewController.navigationButtonsHidden=YES;
    webViewController.showActionButton=NO;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
}

- (UITableView *)tView
{
    if (!_tView) {
        _tView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tView.dataSource = self;
        _tView.delegate = self;
        _tView.tableFooterView=[[UIView alloc]init];
    }
    return _tView;
}

/**
 * singleTap event
 *
 */
-(UITapGestureRecognizer *)singleTap
{
    if (!_singleTap) {
        _singleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [_singleTap setNumberOfTapsRequired:1];
    }
    return _singleTap;
}
- (void)handleSingleTap:(UITapGestureRecognizer *)sender{
    [_showClipView dismissMyview];
    CGPoint p = [sender locationInView:self.tView];
    
    NSIndexPath *indexPath = [self.tView indexPathForRowAtPoint:p];
    if (indexPath) {
        NAMyClipTableViewCell *cell = (NAMyClipTableViewCell *)[self.tView cellForRowAtIndexPath:indexPath];
        if (cell) {
            // 記事詳細画面へ遷移
            NADetailBaseViewController *detail = [[NADetailBaseViewController alloc] init];
            detail.details = self.dataSouce;
            detail.deleteClip = YES;
            detail.regionDic = _regionDic;
            detail.isfromWhere= TYPE_CLIP;
            detail.currentIndex = indexPath.row;
            NADoc *doc = [self.dataSouce objectAtIndex:indexPath.row];
            detail.topPageDoc = doc;
            detail.indexNoFromClip = doc.indexNo;
            detail.pageArray = _pageArray;
            detail.clipDataSource = _clipDataSource;
            NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:detail];
            [self presentViewController:nav animated:YES completion:^{
                
            }];
        }
    }
}

#pragma mark - tableView delegate -
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat cellHeight = 0.0f;
    switch (self.gripCellType) {
        case NAMyDeviceNone:
            cellHeight = 0.0f;
            break;
        case NAMyiPadLandscape:
            cellHeight = NAiPadLandscapeCellHeight;
            break;
        case NAMyiPadPortrait:
            cellHeight = NAiPadPortraitCellHeight;
            break;
        case NAMyiPhoneLandscape:
            cellHeight = NAiPhoneLandscapeCellHeight;
            break;
        case NAMyiPhonePortrait:
            cellHeight = NAiPhonePortraitCellHeight;
            break;
            
        default:
            break;
    };
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"Cell";
    
    // cell初期化
    NAMyClipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NAMyClipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.delegate=self;
    cell.cellType = self.gripCellType;
    
    // longpress場合、backgroundColorを設定
    NAClipDoc *clipDoc = self.dataSouce[indexPath.row];
//    cell.isSelected=clipDoc.iselecton;
//    if ([clipDoc.iselecton isEqualToString:@"YES"]) {
//        cell.contentView.backgroundColor = [Util colorWithHexString:Lightbulecolor];
//        cell.detailLbl.backgroundColor=[Util colorWithHexString:Lightbulecolor];
//    }else {
//        cell.contentView.backgroundColor = [UIColor whiteColor];
//        cell.detailLbl.backgroundColor=[UIColor clearColor];
//    }
    
    // 記事titleを設定
    if ([clipDoc.newsGroupTitle isKindOfClass:[NSString class]]) {
        if (clipDoc.newsGroupTitle.length>titlelength) {
            cell.titleLbl.text = [NSString stringWithFormat:@"%@...",[clipDoc.newsGroupTitle substringWithRange:NSMakeRange(0,titlelength)]];
        }else{
            cell.titleLbl.text = clipDoc.newsGroupTitle;
        }
        
    }else{
        cell.titleLbl.text = @"";
    }
    
    // 記事内容を設定
    if ([clipDoc.newsGroupTitle isKindOfClass:[NSString class]]) {
        NSString *mydetailtext=clipDoc.newsGroupTitle;
        if ([CharUtil isHaveRubytext:mydetailtext]) {
            cell.isHaveRuby=YES;
            //[cell loadDetailWithisHaveRuby:YES];
            mydetailtext=[CharUtil deledateTheRT:clipDoc.newsGroupTitle];
            
            NSString *bundleFile = [[NSBundle mainBundle] pathForResource:@"htmlsource" ofType:@"bundle"];
            NSString *filePath = [NSString stringWithFormat:@"%@/listNote.html",bundleFile];
            NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            
            if (mydetailtext.length>detailtitlelength) {
                mydetailtext=[mydetailtext substringWithRange:NSMakeRange(0,detailtitlelength)];
                mydetailtext=[CharUtil getRightRubytext:clipDoc.newsGroupTitle NORubytext:mydetailtext];
                cell.detailtext=mydetailtext;
                htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@clamp@" withString:@"3"];
                htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@myContent@" withString:[NSString stringWithFormat:@"%@...",mydetailtext]];
                [cell.detailWeb loadHTMLString:htmlString baseURL:nil];
            }else{
                cell.detailtext=clipDoc.newsGroupTitle;
                htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@clamp@" withString:@"3"];
                htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@myContent@" withString:clipDoc.newsGroupTitle];
                [cell.detailWeb loadHTMLString:htmlString baseURL:nil];
                
            }
            
        }else{
            cell.isHaveRuby=NO;
            //[cell loadDetailWithisHaveRuby:NO];
            
            if (mydetailtext.length>detailtitlelength) {
                mydetailtext=[mydetailtext substringWithRange:NSMakeRange(0,detailtitlelength)];
                cell.detailtext=mydetailtext;
                cell.detailLbl.text=mydetailtext;
                
            }else{
                cell.detailtext=mydetailtext;
                cell.detailLbl.text=mydetailtext;
            }
            cell.detailLbl.numberOfLines=3;
        }
        
        
    }else{
        cell.isHaveRuby=NO;
        cell.detailtext=@"";
        [cell.detailWeb loadHTMLString:@"" baseURL:nil];
        cell.detailLbl.text=@"";
    }
    cell.dateLbl.text = [NSString stringWithFormat:@"%@  %@",[DateUtil formateDateWithSlash:clipDoc.publishDate],clipDoc.pageInfoName];
    if (clipDoc.memo  != nil && ![clipDoc.memo isEqualToString:@""]) {
        cell.clipImg.hidden = NO;
        if ([clipDoc.memo isKindOfClass:[NSString class]]) {
            NSInteger lengt = clipDoc.memo.length;
            if (isPhone) {
                if ([self isLandscape]) {
                    if (lengt >30) {
                        cell.clipLbl.text = [NSString stringWithFormat:@"%@...",[clipDoc.memo substringWithRange:NSMakeRange(0,30)]];
                    }else{
                        cell.clipLbl.text = clipDoc.memo;
                    }
                }else{
                    if (lengt >15) {
                        cell.clipLbl.text = [NSString stringWithFormat:@"%@...",[clipDoc.memo substringWithRange:NSMakeRange(0,15)]];
                    }else{
                        cell.clipLbl.text = clipDoc.memo;
                    }
                }
            }else{
                if (lengt >titlelength-40) {
                    cell.clipLbl.text = [NSString stringWithFormat:@"%@...",[clipDoc.memo substringWithRange:NSMakeRange(0,titlelength-40)]];
                }else{
                    cell.clipLbl.text = clipDoc.memo;
                }
            }
            
            
            
        }
    }else{
        cell.clipImg.hidden = YES;
        cell.clipLbl.text = @"";
    }
    

    
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"削除しますか？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            
            NAClipDoc *clipDoc = self.dataSouce[indexPath.row];
            // 削除
            NSDictionary *param = @{
                                    @"Userid"     :  [NASaveData getLoginUserId],
                                    @"Rows"       :  @"999",
                                    @"UseDevice"  :  NAUserDevice,
                                    @"IndexNo"       :  clipDoc.indexNo,
                                    @"K002"       :  @"4",
                                    @"Mode"       :  @"1",
                                    @"Fl"         :  [NSString addclipListFl],
                                    };
            [[NANetworkClient sharedClient] postFavoritesDelete:param completionBlock:^(id favorites, NSError *error) {
                if (!error) {
                    [TAGManagerUtil pushOpenScreenEvent:ENClipDelBtn ScreenName:[Util getLabelName:clipDoc]];
                    ITOAST_BOTTOM(NSLocalizedString(@"note deleted", nil));
                    [self.dataSouce removeObjectAtIndex:indexPath.row];
                    [_tView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    imageview.alpha=0;
                }
            }];
        }];
//        [okAction setValue:ColorGrayText forKey:@"_titleTextColor"];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"いいえ" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
//        [cancelAction setValue:ColorSwitch forKey:@"_titleTextColor"];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"削除";
}

/**
 * クリップ情報を取得
 *
 */
- (void)getClipAPI
{
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"Rows"       :  @"999",
                            @"UseDevice"  :  NAUserDevice,
                            @"K002"       :  @"4",
                            @"Mode"       :  @"1",
                            @"Fl"         :  [NSString clipListFl],
                            };
    [[NANetworkClient sharedClient] postFavoritesSearch:param completionBlock:^(id favorites, NSError *error) {
        if (!error) {
        SHXMLParser *parser = [[SHXMLParser alloc] init];
        NSDictionary *dic = [parser parseData:favorites];
        NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
        NSArray *array = clipBaseClass.response.doc;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.originDataSouce = [NSMutableArray arrayWithArray:array];
            self.dataSouce = [NSMutableArray arrayWithArray:array];
            [self.tView reloadData];
            [ProgressHUD dismiss];
            [NASaveData saveClipSelectedBtnTag:99999];
            if (self.dataSouce.count == 0) {
                [[[iToast makeText:NSLocalizedString(@"NO Note", nil)]
                  setGravity:iToastGravityBottom] show];
            }
        });
        }else{
            ITOAST_BOTTOM(error.localizedDescription);
            //[self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
//searchTagList
- (void)getTagClipAPI
{
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"Rows"       :  @"999",
                            @"UseDevice"  :  NAUserDevice,
                            @"K002"       :  @"4",
                            @"Mode"       :  @"1",
                            @"Fl"         :  [NSString clipListFl],
                            @"UseFlg"     :  @"0",
                            };
    [[NANetworkClient sharedClient] postTagFavoritesSearch:param completionBlock:^(id favorites, NSError *error) {
        if (!error) {
            SHXMLParser *parser = [[SHXMLParser alloc] init];
            NSDictionary *dic = [parser parseData:favorites];
            NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
            NSArray *array = clipBaseClass.response.doc;
            _clipTagArray = [[NSMutableArray alloc] initWithArray:array];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [ProgressHUD dismiss];
            
                _showClipView=[[NAShowClipAlertView alloc]init];
                _showClipView.btnArray = _clipTagArray;
                _showClipView.delegate=self;
                [_showClipView show];
                if (array.count == 0) {
                    [[[iToast makeText:@"NOTagList"]
                      setGravity:iToastGravityBottom] show];
                }
            });
        }else{
            ITOAST_BOTTOM(error.localizedDescription);
        }
    }];
}
//searchFavoritesList
- (void)searchFavoritesList:(NSString *)tagId
{
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"TagId"      :  tagId,
                            @"Rows"       :  @"999",
                            @"UseDevice"  :  NAUserDevice,
                            @"K002"       :  @"4",
                            @"Mode"       :  @"1",
                            @"Fl"         :  [NSString clipListFl],
                            };
    [[NANetworkClient sharedClient] postTagFavoritesListSearch:param completionBlock:^(id favorites, NSError *error) {
        if (!error) {
            SHXMLParser *parser = [[SHXMLParser alloc] init];
            NSDictionary *dic = [parser parseData:favorites];
            NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
            NSArray *array = clipBaseClass.response.doc;
            NSMutableArray *arraySelected = [[NSMutableArray alloc] init];
            for (NAClipDoc *dicSelected in array) {
                NSString *indexNoSelected = dicSelected.indexNo;
                for (NAClipDoc *dicBig in self.originDataSouce) {
                    if ([dicBig.indexNo isEqualToString:indexNoSelected]) {
                        [arraySelected addObject:dicBig];
                    }
                }
            }
            self.dataSouce = arraySelected;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (array.count == 0) {
                    [[[iToast makeText:@"NOTagFavoritesList"]
                      setGravity:iToastGravityBottom] show];
                }
                [ProgressHUD dismiss];
                [_tView reloadData];
            });
        }else{
            ITOAST_BOTTOM(error.localizedDescription);
        }
    }];
}
//deleteTag
-(void)deleteTag{
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"TagId"         :  @"005",
                            };
    [[NANetworkClient sharedClient] deleteTag:param completionBlock:^(id favorites, NSError *error) {
        if (!error) {
            ITOAST_BOTTOM(@"tag deleted");
        }
    }];
}
//renameTag
- (void)renameTag{
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"TagId"         :  @"004",//TODO
                            @"TagName"         :  @"lalalalal",//TODO
                            };
    [[NANetworkClient sharedClient] renameTag:param completionBlock:^(id favorites, NSError *error) {
        if (!error) {
            ITOAST_BOTTOM(@"tag rename success");
        }
    }];
}
//saveTag
- (void)saveTag{
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"TagName"         :  @"lalalalal",//TODO
                            };
    [[NANetworkClient sharedClient] saveTag:param completionBlock:^(id favorites, NSError *error) {
        if (!error) {
            ITOAST_BOTTOM(@"saveTag success");
        }
    }];
}
- (NAMyGripTableViewCellDeviceType)deviceType:(UIInterfaceOrientation)orientation
{
    if (isPad) {
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            return NAMyiPadPortrait;
        }else{
            return NAMyiPadLandscape;
        }
    }else {
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            return NAMyiPhonePortrait;
        }else{
            return NAMyiPhoneLandscape;
        }
    }
    return NAMyDeviceNone;
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
    _labMianHore.text = _labMianDetail;
    [leftView addSubview:_labMianHore];
    
    UIButton *btnChooseDay = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnChooseDay setImage:[UIImage imageNamed:@"08_blue"] forState:UIControlStateNormal];
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
    [btn1 setImage:[UIImage imageNamed:@"01_blue"] forState:0];
    [btn1 addTarget:self action:@selector(pushItemDetail:) forControlEvents:UIControlEventTouchUpInside];
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
    [btn2 setImage:[UIImage imageNamed:@"02_pink"] forState:0];
    [btn2 addTarget:self action:@selector(pushItemDetail:) forControlEvents:UIControlEventTouchUpInside];
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
    [btn3 setImage:[UIImage imageNamed:@"03_blue"] forState:0];
    [btn3 addTarget:self action:@selector(pushItemDetail:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn3bar= [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    JXButton  *btn4 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn4.frame = CGRectMake(0, 5, 40, 30);
    }else{
        btn4.frame = CGRectMake(0, 5, 40, 40);
    }
    [btn4 setTitle:@"ラベル" forState:0];
    btn4.tag = 1004;
    [btn4 setImage:[UIImage imageNamed:@"10_blue"] forState:0];
    [btn4 setTitleColor:[UIColor blackColor] forState:0];
    [btn4 addTarget:self action:@selector(pushItemDetail:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn4bar= [[UIBarButtonItem alloc] initWithCustomView:btn4];
    
    
    JXButton  *btn5 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn5.frame = CGRectMake(0, 5, 40, 30);
    }else{
        btn5.frame = CGRectMake(0, 5, 40, 35);
    }
    [btn5 setTitleColor:[UIColor blackColor] forState:0];
    btn5.tag = 1005;
    [btn5 setTitle:@"設定" forState:0];
    [btn5 setImage:[UIImage imageNamed:@"05_blue"] forState:0];
    [btn5 addTarget:self action:@selector(pushItemDetail:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn5bar= [[UIBarButtonItem alloc] initWithCustomView:btn5];
    
    
    self.toolBar.items=[NSArray arrayWithObjects:btn6bar,spaceButtonItem,btn1bar,spaceButtonItem,btn2bar,spaceButtonItem,btn3bar,spaceButtonItem,btn4bar,spaceButtonItem,btn5bar,nil];
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
    [btn1 setImage:[UIImage imageNamed:@"01_blue"] forState:0];
    [btn1 addTarget:self action:@selector(pushItemDetail:) forControlEvents:UIControlEventTouchUpInside];
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
    [btn2 setImage:[UIImage imageNamed:@"02_pink"] forState:0];
    [btn2 addTarget:self action:@selector(pushItemDetail:) forControlEvents:UIControlEventTouchUpInside];
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
    [btn3 setImage:[UIImage imageNamed:@"03_blue"] forState:0];
    [btn3 addTarget:self action:@selector(pushItemDetail:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn3bar= [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    JXButton  *btn4 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn4.frame = CGRectMake(0, 5, 40, 40);
    }else{
        btn4.frame = CGRectMake(0, 5, 40, 40);
    }
    [btn4 setTitle:@"ラベル" forState:0];
    btn4.tag = 1004;
    [btn4 setImage:[UIImage imageNamed:@"10_blue"] forState:0];
    [btn4 setTitleColor:[UIColor blackColor] forState:0];
    [btn4 addTarget:self action:@selector(pushItemDetail:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn4bar= [[UIBarButtonItem alloc] initWithCustomView:btn4];
    
    
    JXButton  *btn5 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn5.frame = CGRectMake(0, 5, 50, 35);
    }else{
        btn5.frame = CGRectMake(0, 5, 50, 40);
    }
    [btn5 setTitleColor:[UIColor blackColor] forState:0];
    btn5.tag = 1005;
    [btn5 setTitle:@"設定" forState:0];
    [btn5 setImage:[UIImage imageNamed:@"05_blue"] forState:0];
    [btn5 addTarget:self action:@selector(pushItemDetail:) forControlEvents:UIControlEventTouchUpInside];
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
- (void)setDairy{
    
    NADoc *doc = _pageArray[0];
    NSString *date = doc.publishDate;
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
        _labMonthDayDetail = attString;
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
        _labMonthDayDetail = attString;
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
        _labMonthDayDetail = attString;
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
        _labMonthDayDetail = attString;
    }

    
    _labMianDetail = [NSString stringWithFormat:@"%@",doc.pageInfoName];
}


@end

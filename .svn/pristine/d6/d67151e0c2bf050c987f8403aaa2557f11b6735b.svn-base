
#import "NANoteListViewController.h"
#import "NADetailViewController.h"
#import "NANoteCell.h"
#import "NASearchViewController.h"
#import "NAClipViewController.h"
#import "NASettingViewController.h"
#import "NoteTableView.h"
#import "NADayJournalViewController.h"
#import "NANewDayJournalViewController.h"
#import "NANewSearchViewController.h"
#import "NANewSettingViewController.h"
#import "JXButton.h"
#import "FontUtil.h"
@interface NANoteListViewController ()<NoteViewPagerViewControllerDataSource,NoteViewPagerViewControllerDelegate>{
    NSInteger isHaveRegion;//是否有地域版
}
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic, assign) UIInterfaceOrientation oldFromInterfaceOrientation;
@property (nonatomic, assign) UIInterfaceOrientation oldToInterfaceOrientation;
@property (nonatomic,strong) NSMutableArray *mianArray;
@end

@implementation NANoteListViewController{
    NSInteger titlelength;
    NSInteger detailtitlelength;
    NSInteger myChangeNum;
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    self.isfirst = 0;
    if ([self isLandscape]) {
        _riliView.hidden = YES;
        [self setHorToolBar];
    }else{
        [self resetRiliview];
        _riliView.hidden = NO;
        [self resetHomeToolBar];
    }
    NADoc *doc = _pageArray[0];
    [self setDairy:doc];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:245.0/255.0 alpha:1];
    NSDictionary *dic=[NAFileManager ChangePlistTodic];
    NSString *titlestrlength=[dic objectForKey:NANewsTitleLengthkey];
    NSString *textstrlength=[dic objectForKey:NANewsTextLengthkey];
    titlelength=[titlestrlength integerValue];
    detailtitlelength=[textstrlength integerValue];
    [self setRiliview];
    if ([self isLandscape]) {
        _riliView.hidden = YES;
    }else{
        [self resetRiliview];
        _riliView.hidden = NO;
    }
    _titleArray = [[NSMutableArray alloc]init];
    _mianArray = [[NSMutableArray alloc]init];

    for (int i =0; i < _pageArray.count; i++) {
        NADoc *doc = [_pageArray objectAtIndex:i];
//        NSString *str = [NSString stringWithFormat:@"%d面",i + 1];
        [_titleArray addObject:doc.pageInfoName];
    }
    _titleArray=(NSMutableArray *)[[_titleArray reverseObjectEnumerator] allObjects];
    _mianArray=(NSMutableArray *)[[_pageArray reverseObjectEnumerator] allObjects];
    [self loadNoteArray];
    self.NotePageArray=[NSMutableArray arrayWithArray:_pageArray];
    
    self.delegate = self;
    self.dataSource = self;
    [self updateViews];
//    for (int i =0; i < _noteNumber; i++) {
//        NSString *str = [NSString stringWithFormat:@"%d面",i + 1];
//        [_titleArray addObject:str];
//    }
//    _titleArray=(NSMutableArray *)[[_titleArray reverseObjectEnumerator] allObjects];
//    if (_NotePageArray.allKeys.count != 0) {
//        self.delegate = self;
//        self.dataSource = self;
//    }else{
//        _NotePageArray = [[NSMutableDictionary alloc]init];
//       [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
//       [self getNoteAPI]; 
//    }
//    [self updateViews];

    
}
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
//            for (int i = 1; i < _noteNumber; i++) {
//                NSMutableArray *mianArray= [[NSMutableArray alloc]init];
//                for(NADoc *doc in array) {
//                    if ([doc.pageno hasPrefix:@"0"]) {
//                        if (i == [doc.pageno substringWithRange:NSMakeRange(1, 1)].integerValue) {
//                            [mianArray addObject:doc];
//                            
//                        }
//                    }else{
//                        if (i == doc.pageno.integerValue) {
//                            [mianArray addObject:doc];
//                            
//                        }
//                    }
//                    
//                    
//                }
//                [_NotePageArray setObject:mianArray forKey:[NSString stringWithFormat:@"%d",i-1]];
//                
//            }
//            [ProgressHUD dismiss];
//            self.delegate = self;
//            self.dataSource = self;
//        }else{
//            ITOAST_BOTTOM(error.localizedDescription);
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//    }];
//}
#pragma View Pager Data Source
-(NSInteger)numberOfViewControllersInViewPager:(NoteViewPagerViewController *)viewPager
{
    return _titleArray.count;
    //return _noteNumber;
}
-(UIView *)headerViewForInViewPager:(NoteViewPagerViewController *)viewPager
{
    if ([self isLandscape]) {
        return _riliView;
    }
    return _riliView;
}
-(CGFloat)heightForHeaderOfViewPager:(NoteViewPagerViewController *)viewPager
{
    if ([self isLandscape]) {
        return 0;
    }
    return 40;
}
-(CGFloat)heightForTitleOfViewPager:(NoteViewPagerViewController *)viewPager
{
    if (_titleArray.count == 1) {
        return 0;
    }
    return 30;
}
-(NSString *)viewPager:(NoteViewPagerViewController *)viewPager titleWithIndexOfViewControllers:(NSInteger)index
{
    if (_titleArray.count == 1) {
        return nil;
    }
    return self.titleArray[index];
}

-(UIViewController *)viewPager:(NoteViewPagerViewController *)viewPager indexOfViewControllers:(NSInteger)index
{
//    NoteTableView *noteTableView = [[NoteTableView alloc] init];
//    noteTableView.topPageDoc= _topPageDoc;
//    noteTableView.pageArray = _pageArray;
//    noteTableView.clipDataSource = _clipDataSource;
//    NSArray *arr= [_NotePageArray objectForKey:[NSString stringWithFormat:@"%ld",_NotePageArray.allKeys.count -(long)index]];
//    noteTableView.dataSouce = arr;
//    noteTableView.noteNumber = _noteNumber;
//    noteTableView.NoteArray = _NotePageArray;
//    return noteTableView;
    NoteTableView *noteTableView = [[NoteTableView alloc] init];
    NADoc *doc = _mianArray[index];
    NSString *path = [[NAFileManager sharedInstance] searchNoteName:doc withNoteName:NoteFileName];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:path isDirectory:FALSE]) {
        noteTableView.pendingVCIndex = index;
        noteTableView.path = path;
    }else{
        noteTableView.dataSouce =nil;
    }
    noteTableView.pageArray = _pageArray;
    noteTableView.clipDataSource = _clipDataSource;
    noteTableView.topPageDoc = _topPageDoc;
    noteTableView.regionDic = _regionDic;
    return noteTableView;
}
#pragma View Pager Delegate
-(void)viewPagerViewController:(NoteViewPagerViewController *)viewPager willScrollerWithCurrentViewController:(UIViewController *)ViewController
{

    
}
-(void)viewPagerViewController:(NoteViewPagerViewController *)viewPager didFinishScrollWithCurrentViewController:(UIViewController *)viewController nowIndex:(NSInteger)index
{
//    NoteTableView *v = (NoteTableView *)viewController;
//    v.topPageDoc= _topPageDoc;
//    v.pageArray = _pageArray;
//    v.clipDataSource = _clipDataSource;
//    v.noteNumber =_noteNumber;
//    v.NoteArray = _NotePageArray;
//    NSArray *arr= [_NotePageArray objectForKey:[NSString stringWithFormat:@"%ld",_NotePageArray.allKeys.count -(long)index]];
//    v.dataSouce = arr;
//    //NADoc *doc = arr[0];
//    [v reloadData];
//    //[self setDairy:doc];
    NoteTableView *v = (NoteTableView *)viewController;
    NADoc *doc = _mianArray[index];
    NSString *path = [[NAFileManager sharedInstance] searchNoteName:doc withNoteName:NoteFileName];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:path isDirectory:FALSE]) {
        v.pendingVCIndex = index;
        v.path = path;
    }else{
        v.dataSouce =nil;
    }
    v.topPageDoc = _topPageDoc;
    v.pageArray = _pageArray;
    v.clipDataSource = _clipDataSource;
    v.regionDic = _regionDic;

    [v reloadData];
    [self setDairy:doc];
    if ([self isLandscape]) {
        _riliView.hidden = YES;
        [self setHorToolBar];
    }else{
        [self resetRiliview];
        _riliView.hidden = NO;
        [self resetHomeToolBar];
    }

    self.nowIndex = index;
}
-(void)viewPagerViewController:(NoteViewPagerViewController *)viewPager selectNowIndex:(NSInteger)index{
    NADoc *doc = _mianArray[index];
    [self setDairy:doc];
    if ([self isLandscape]) {
        _riliView.hidden = YES;
        [self setHorToolBar];
    }else{
        [self resetRiliview];
        _riliView.hidden = NO;
        [self resetHomeToolBar];
    }
   self.nowIndex = index;
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
        [self controlTheBlockWithdocNote:doc];
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
-(void)controlTheBlockWithdocNote:(NADoc *)doc{
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
        home.clipDataSource = _clipDataSource;
        home.homePageArray = _pageArray;
        home.dayNumber = 0;
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
        [self presentViewController:nav animated:NO completion:^{
            
            
        }];
        [ProgressHUD dismiss];
    }else{
        //different
        //[ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
        
        //[self searchCurrentApi:doc ByUserid:[NASaveData getLoginUserId]];
        NAHomeViewController *home = [[NAHomeViewController alloc] init];
        home.forwardPage=@"topPage";
        home.topPageDoc= _topPageDoc;
        home.clipDataSource = _clipDataSource;
        home.homePageArray = _pageArray;
        home.dayNumber = 1;
        home.regionDic = _regionDic;
        home.dayDoc = doc;
        home.regionFlg = isHaveRegion;
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
        [self presentViewController:nav animated:NO completion:^{
            
            
        }];
        [ProgressHUD dismiss];
    }
    
}



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
//    search.NoteArray = _NotePageArray;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:search];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

-(void)controlTheBlockWithdoc:(NADoc *)doc{
    NADoc *tempdoc = self.NotePageArray[0];
    if ( [tempdoc.editionInfoId isEqualToString:doc.editionInfoId]
        &&[tempdoc.publicationInfoId isEqualToString:doc.publicationInfoId]
        &&[tempdoc.publisherInfoId isEqualToString:doc.publisherInfoId]
        &&[tempdoc.publisherGroupInfoId isEqualToString:doc.publisherGroupInfoId]
        &&[tempdoc.publishDate isEqualToString:doc.publishDate]) {
        //same
        NAHomeViewController *home = [[NAHomeViewController alloc] init];
        home.forwardPage=@"topPage";
        home.topPageDoc= _topPageDoc;
        home.clipDataSource = _clipDataSource;
        home.homePageArray = _pageArray;
        home.dayNumber = 0;
        home.regionDic = _regionDic;
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
        [self presentViewController:nav animated:NO completion:^{
            
            
        }];
        [ProgressHUD dismiss];
    }else{
        //different
        NAHomeViewController *home = [[NAHomeViewController alloc] init];
        home.forwardPage=@"topPage";
        home.topPageDoc= _topPageDoc;
        home.clipDataSource = _clipDataSource;
        home.homePageArray = _pageArray;
        home.dayNumber = 1;
        home.dayDoc = doc;
        home.regionDic = _regionDic;
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
        [self presentViewController:nav animated:NO completion:^{
            
            
        }];
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

-(void)loadNoteArray{
    for (NADoc *tmpdoc in self.NotePageArray) {
        NSString *path = [[NAFileManager sharedInstance] searchNoteName:tmpdoc withNoteName:NoteFileName];
        NSFileManager *fileManage = [NSFileManager defaultManager];
        if ([fileManage fileExistsAtPath:path isDirectory:FALSE]) {
            NSData *data = [NSData dataWithContentsOfFile:path];
            tmpdoc.notearray = [[NAFileManager sharedInstance] arrayWithData:data];
            
            for (NSInteger index=0; index<tmpdoc.notearray.count; index++) {
                NADoc *temdoc=[tmpdoc.notearray objectAtIndex:index];
                temdoc.miniPagePath=tmpdoc.miniPagePath;
                temdoc.lastUpdateDateAndTime=tmpdoc.lastUpdateDateAndTime;
            }
        }
        [self setNavMainTitle:[self getMainTitleText:tmpdoc] subTitle:[self getSubTitleText:tmpdoc Otherdoc:nil]];
    }
    
    
}
-(NSString *)getDateStr:(NSString *)fromDateStr{
    NSDate *myfromdate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
    [formatter setLocale:locale];
    [formatter setDateFormat:@"yyyyMMdd"];
    myfromdate=[formatter dateFromString:fromDateStr];
    
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    return [formatter stringFromDate:myfromdate];
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
    self.isfirst = 0;
//    self.delegate = self;
//    self.dataSource = self;
    if ([self isLandscape]) {
        _riliView.hidden = YES;
        [self setHorToolBar];
    }else{
        [self resetRiliview];
        _riliView.hidden = NO;
        [self resetHomeToolBar];
    }
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.presentingViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    
}
- (BOOL)isLandscape
{
    return ([Util screenSize].width>[Util screenSize].height);
}

/**
 * view初期化
 *
 */
- (void)initViews
{
    [super initViews];
    NADoc *doc = _pageArray[0];
    [self setDairy:doc];
    UIImageView *titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rangai_daiji"]];
    self.navigationItem.titleView = titleView;
    self.navigationItem.leftBarButtonItem = self.searchBarItem;
    self.navigationItem.rightBarButtonItem = self.webBarItem;
    if ([self isLandscape]) {
        [self setHorToolBar];
    }else{
        [self resetHomeToolBar];
    }

    
}

- (void) pushItemDetail:(UIButton *)sender
{
    if (sender.tag == 1001) {
        [self toHomeViewController];
    }else if (sender.tag == 1002){
        [self toGripViewController];
    }else if (sender.tag == 1003){
        
    }else if (sender.tag == 1005){
        [self toSettingViewContreller];
    }
}
-(void)toHomeViewController{
    
    
    NAHomeViewController *home = [[NAHomeViewController alloc] init];
    home.forwardPage=@"topPage";
    home.topPageDoc= _topPageDoc;
    home.homePageArray = _pageArray;
    home.clipDataSource = _clipDataSource;
    home.dayNumber = 0;
    home.regionDic = _regionDic;
//    home.noteNumber = _noteNumber;
//    home.NoteArray = _NotePageArray;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
    [self presentViewController:nav animated:NO completion:^{
        
        
    }];
}
/**
 * クリップリスト画面を表示
 *
 */
- (void)toGripViewController
{
    if (![NACheckNetwork sharedInstance].isHavenetwork) {
        
        [[[iToast makeText:NSLocalizedString(@"networkerror", @"")]
          setGravity:iToastGravityBottom] show];
        return;
    }
    NAClipViewController *grip =  [[NAClipViewController alloc] init];
    grip.pageArray = _pageArray;
    grip.regionDic = _regionDic;
    grip.topPageDoc = _topPageDoc;
    grip.clipDataSource = _clipDataSource;
    grip.clipNumber = 1;
//    grip.noteNumber = _noteNumber;
//    grip.NoteArray = _NotePageArray;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:grip];
    [self presentViewController:nav animated:NO completion:^{
        
    }];
    
    // GA(tag manager)
    //[TAGManagerUtil pushButtonClickEvent:ENClipListBtn label:[self getLabelName]];
    
    
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
    setting.regionDic = _regionDic;

    setting.clipDataSource = _clipDataSource;
//    setting.noteNumber = _noteNumber;
//    setting.NoteArray = _NotePageArray;
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
    CGFloat barHeight = TOOLBAR_HEIGHT;
    self.searchBarItem.customView.frame=CGRectMake(self.searchBarItem.customView.frame.origin.x, self.searchBarItem.customView.frame.origin.y, (self.navigationController.navigationBar.frame.size.height-4)/2 +5, (self.navigationController.navigationBar.frame.size.height-4)/2 + 5);
    self.webBarItem.customView.frame=CGRectMake(self.webBarItem.customView.frame.origin.x, self.webBarItem.customView.frame.origin.y, (self.navigationController.navigationBar.frame.size.height-4)/2 + 5, (self.navigationController.navigationBar.frame.size.height-4)/2 + 5);
    self.navigationItem.titleView.frame=CGRectMake(self.navigationItem.titleView.frame.origin.x, self.navigationItem.titleView.frame.origin.y, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height);
    if (isPhone) {
        self.toolBar.frame = CGRectMake(0, self.view.frame.size.height - barHeight, self.view.frame.size.width, barHeight);

    }else{
        self.toolBar.frame = CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49);

    }
    [self viewDidLayoutSubviews];
}

- (NAGripTableViewCellDeviceType)deviceType:(UIInterfaceOrientation)orientation
{
    if (isPad) {
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            return NAiPadPortrait;
        }else{
            return NAiPadLandscape;
        }
    }else {
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            return NAiPhonePortrait;
        }else{
            return NAiPhoneLandscape;
        }
    }
    return NADeviceNone;
}

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
    
    [formater setDateFormat:@"MM月dd日 (ccc) "];
    
    return [[formater stringFromDate:now] stringByAppendingString:doc.editionInfoName];
}


-(NSString *) getSubTitleText:(NADoc *)doc Otherdoc:(NADoc *)other
{
    NSString * title = doc.publicationInfoName;
    title = [title stringByAppendingString:@"・"];
    title = [title stringByAppendingString:doc.pageInfoName ];
    if (other) {
        title = [title stringByAppendingString:@"/"];
        title = [title stringByAppendingString:other.pageInfoName ];
    }
    
    
    return title;
}
#pragma mark - UIScrollView Delegate -
#pragma mark


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}
- (void)setHorToolBar{
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    CGFloat screenwidth = [Util screenSize].width;
    UIView *leftView ;
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
    [btn2 setImage:[UIImage imageNamed:@"02_blue"] forState:0];
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
    [btn3 setImage:[UIImage imageNamed:@"03_pink"] forState:0];
    [btn3 addTarget:self action:@selector(pushItemDetail:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn3bar= [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    JXButton  *btn4 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn4.frame = CGRectMake(0, 5, 40, 30);
    }else{
        btn4.frame = CGRectMake(0, 5, 40, 40);
    }
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
    [btn2 setImage:[UIImage imageNamed:@"02_blue"] forState:0];
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
    [btn3 setImage:[UIImage imageNamed:@"03_pink"] forState:0];
    [btn3 addTarget:self action:@selector(pushItemDetail:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn3bar= [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    JXButton  *btn4 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn4.frame = CGRectMake(0, 5, 40, 40);
    }else{
        btn4.frame = CGRectMake(0, 5, 40, 40);
    }
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
- (void)setDairy:(NADoc *)doc{
    //NADoc *doc = _pageArray[0];
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
        self.labMonthDay.attributedText = attString;
        self.labMonthDayHore.attributedText = attString;
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
        self.labMonthDay.attributedText = attString;
        self.labMonthDayHore.attributedText = attString;
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
        self.labMonthDay.attributedText = attString;
        self.labMonthDayHore.attributedText = attString;
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
        self.labMonthDay.attributedText = attString;
        self.labMonthDayHore.attributedText = attString;
        _labMonthDayDetail = attString;
    }

    
    self.labMian.text = [NSString stringWithFormat:@"%@",doc.pageInfoName];
    self.labMianHore.text = [NSString stringWithFormat:@"%@",doc.pageInfoName];
    _labMianDetail = [NSString stringWithFormat:@"%@",doc.pageInfoName];
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
    [_btnChooseDay setImage:[UIImage imageNamed:@"08_blue"] forState:UIControlStateNormal];
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
    
    [_viewTwo mas_updateConstraints:^(MASConstraintMaker *make) {
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
    
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_riliView.mas_bottom).offset(-1);
        make.width.mas_equalTo(screenWidth);
        make.height.mas_equalTo(1);
    }];
    
    
}
@end


#import "NASearchResultViewController.h"
#import "NAGripTableViewCell.h"
#import "NADetailViewController.h"
#import "TOWebViewController.h"
#import "NANewSearchViewController.h"
#import "NAHomeViewController.h"
#import "NANoteListViewController.h"
#import "NASettingViewController.h"
#import "NAClipViewController.h"
#import "NANewSettingViewController.h"
#import "JXButton.h"
#import "NANewDayJournalViewController.h"
#import "DateUtil.h"
#import "FontUtil.h"
#import "NASearchResultTableViewCell.h"
#import "NADetailBaseViewController.h"
@interface NASearchResultViewController ()
{
    NSInteger tableRows;
    NSMutableDictionary *searchdic;
    BOOL isseclcton;
    NSInteger titlelength;
    NSInteger detailtitlelength;
    NSInteger totalCount;
    NSInteger isHaveRegion;//是否有地域版
}

@property (nonatomic, strong) UITableView *tView;
@property (nonatomic, assign) NAGripTableViewCellDeviceType gripCellType;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) NSMutableArray *clipArray;
@property (nonatomic, assign) UIInterfaceOrientation oldFromInterfaceOrientation;
@property (nonatomic, assign) UIInterfaceOrientation oldToInterfaceOrientation;

@end

@implementation NASearchResultViewController

@synthesize myserachtext;
@synthesize mycurrDoc;
@synthesize myseracharray;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = self.searchBarItem;
    self.navigationItem.rightBarButtonItem = self.webBarItem;
    self.title = @"公明新闻";
    totalCount=0;
    
    BACK(^{
        self.clipArray = [NSMutableArray array];
        [self searchNoteCountAPI];
        [self initSeachdic];
        
        NSDictionary *dic=[NAFileManager ChangePlistTodic];
        NSString *titlestrlength=[dic objectForKey:NANewsTitleLengthkey];
        NSString *textstrlength=[dic objectForKey:NANewsTextLengthkey];
        titlelength=[titlestrlength integerValue];
        detailtitlelength=[textstrlength integerValue];
    });
    
}

- (void) pushItemDetail:(UIButton *)sender
{
    if (sender.tag == 1001) {
        [self toHomeViewController];
    }else if (sender.tag == 1002){
        [self toGripViewController];
    }else if (sender.tag == 1003){
        [self toNoteListViewController];
    }else if (sender.tag == 1005){
        [self toSettingViewContreller];
    }
}
-(void)toHomeViewController{
    
    
    NAHomeViewController *home = [[NAHomeViewController alloc] init];
    home.forwardPage=@"topPage";
    home.topPageDoc= _topPageDoc;
    home.clipDataSource = _clipDataSource;
    home.homePageArray = _pageArray;
    home.regionDic = _regionDic;
    home.haveChangeIndex = _haveChangeIndex;
//    home.noteNumber = _noteNumber;
//     home.NoteArray = _NoteArray;
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
    note.regionDic = _regionDic;
    note.topPageDoc= _topPageDoc;
    note.clipDataSource = _clipDataSource;
    note.myselectIndex = _haveChangeIndex;
//    note.noteNumber = _noteNumber;
//     note.NotePageArray = _NoteArray;
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
    grip.haveChangeIndex = _haveChangeIndex;
    grip.isfromWhere = _isfromWhere;
//    grip.noteNumber = _noteNumber;
//    grip.NoteArray = _NoteArray;
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
    setting.clipDataSource = _clipDataSource;
    setting.regionDic = _regionDic;

    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:setting];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    // GA(tag manager)
    //[TAGManagerUtil pushButtonClickEvent:ENSetupBtn label:[self getLabelName]];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
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
        [self setHorToolBar];
    }else{
        [self resetHomeToolBar];
    }
//    [self.tView removeFromSuperview];
//    _tView = nil;
//    _tView = self.tView;
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
    }else{
        [self resetHomeToolBar];
    }
    //[self.view addSubview:self.tView];
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.presentingViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - utility -
#pragma mark

- (void)initViews
{
    [super initViews];
    self.navigationItem.leftBarButtonItem = self.backBtnItem;
    self.gripCellType = [self deviceType:self.interfaceOrientation];
    self.tView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tView];
    myseracharray =[NSMutableArray arrayWithArray:self.dataSouce];
    tableRows=myseracharray.count;
    if ([self isLandscape]) {
        [self setHorToolBar];
    }else{
        [self resetHomeToolBar];
    }
    [self setDairy];
}
- (BOOL)isLandscape
{
    return ([Util screenSize].width>[Util screenSize].height);
}

- (void)updateViews
{
    [super updateViews];
    CGFloat barHeight = TOOLBAR_HEIGHT;
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    if (isPhone) {
        self.tView.frame = CGRectMake(0, 0, screenWidth, screenHeight - barHeight);
        self.toolBar.frame = CGRectMake(0, self.view.frame.size.height - barHeight, self.view.frame.size.width, barHeight);
    }else{
        self.tView.frame = CGRectMake(0, 0, screenWidth, screenHeight - 49);
        self.toolBar.frame = CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49);
    }
    
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

#pragma mark - layout -
#pragma mark

- (UITableView *)tView
{
    if (!_tView) {
        _tView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tView.dataSource = self;
        _tView.delegate = self;
    }
    return _tView;
}


#pragma mark - tableView delegate -
#pragma mark
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat cellHeight = 0.0f;
    switch (self.gripCellType) {
        case NADeviceNone:
            cellHeight = 0.0f;
            break;
        case NAiPadLandscape:
            cellHeight = NAiPadLandscapeCellHeight;
            break;
        case NAiPadPortrait:
            cellHeight = NAiPadPortraitCellHeight;
            break;
        case NAiPhoneLandscape:
            cellHeight = NAiPhoneLandscapeCellHeight;
            break;
        case NAiPhonePortrait:
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
    NASearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NASearchResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NADoc *clipDoc = myseracharray[indexPath.row];
    cell.isSelected=clipDoc.iselecton;
    if ([clipDoc.iselecton isEqualToString:@"YES"]) {
        cell.contentView.backgroundColor = [Util colorWithHexString:Lightbulecolor];
        cell.detailLbl.backgroundColor=[Util colorWithHexString:Lightbulecolor];
    }else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.detailLbl.backgroundColor=[UIColor clearColor];
    }
    
    cell.cellType = self.gripCellType;
    cell.titleLbl.textColor  = [UIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:250.0/255.0 alpha:1];
    cell.titleLbl.font = [FontUtil systemFontOfSize:15];
   
    cell.titleLbl.text = [NSString stringWithFormat:@"%@  %@面",[DateUtil formateDateWithSlash:clipDoc.publishDate],clipDoc.pageno];
    // 記事内容を設定
    if ([clipDoc.newsText isKindOfClass:[NSString class]]) {
        NSString *mydetailtext=clipDoc.newsText;
        if ([CharUtil isHaveRubytext:mydetailtext]) {
            cell.isHaveRuby=YES;
            [cell loadDetailWithisHaveRuby:YES];
            mydetailtext=[CharUtil deledateTheRT:clipDoc.newsText];
            
            NSString *bundleFile = [[NSBundle mainBundle] pathForResource:@"htmlsource" ofType:@"bundle"];
            NSString *filePath = [NSString stringWithFormat:@"%@/listNote.html",bundleFile];
            NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            
            if (mydetailtext.length>detailtitlelength) {
                mydetailtext=[mydetailtext substringWithRange:NSMakeRange(0,detailtitlelength)];
                mydetailtext=[CharUtil getRightRubytext:clipDoc.newsText NORubytext:mydetailtext];
                cell.detailtext=mydetailtext;
                htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@clamp@" withString:@"3"];
                htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@myContent@" withString:[NSString stringWithFormat:@"%@...",mydetailtext]];
                [cell.detailWeb loadHTMLString:htmlString baseURL:nil];
            }else{
                cell.detailtext=clipDoc.newsText;
                htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@clamp@" withString:@"3"];
                htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@myContent@" withString:clipDoc.newsText];
                [cell.detailWeb loadHTMLString:htmlString baseURL:nil];
                
            }
            
        }else{
            cell.isHaveRuby=NO;
            [cell loadDetailWithisHaveRuby:NO];
            
            if (mydetailtext.length>detailtitlelength) {
                mydetailtext=[mydetailtext substringWithRange:NSMakeRange(0,detailtitlelength)];
                cell.detailtext=mydetailtext;
                cell.detailLbl.text=mydetailtext;
                
            }else{
                cell.detailtext=mydetailtext;
                cell.detailLbl.text=mydetailtext;
            }
            cell.detailLbl.numberOfLines=isPad?2:3;
        }
        
        
    }else{
        cell.isHaveRuby=NO;
        cell.detailtext=@"";
        [cell.detailWeb loadHTMLString:@"" baseURL:nil];
        cell.detailLbl.text=@"";
    }
    
   
    //[cell searchMatchInDirection:myserachtext];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NADetailBaseViewController *detail = [[NADetailBaseViewController alloc] init];
    detail.details = myseracharray;
    detail.regionDic = _regionDic;
    detail.currentIndex = indexPath.row;
    //detail.myserachtext = self.myserachtext;
    detail.isfromWhere = TYPE_NOTE;
    NADoc *doc = [myseracharray objectAtIndex:indexPath.row];
    detail.topPageDoc = doc;
    detail.indexNoFromClip = doc.indexNo;
    detail.pageArray = _pageArray;
    detail.clipDataSource = _clipDataSource;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:detail];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView != self.tView) {
        return;
    }
    if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height))
    {
        if (tableRows==totalCount) {
            return;
        }
        [self searchNoteAPI];
    }
    
}


-(void)initSeachdic{
    searchdic=[[NSMutableDictionary alloc]init];
    NSString *userId = [NASaveData getLoginUserId];
    [searchdic setValue:userId forKey:@"Userid"];
    [searchdic setValue:@"30" forKey:@"Rows"];
    [searchdic setValue:@"4" forKey:@"K002"];
    [searchdic setValue:@"1" forKey:@"Mode"];
    [searchdic setValue:mycurrDoc.publisherGroupInfoId forKey:@"K004"];
    [searchdic setValue:mycurrDoc.publisherInfoId forKey:@"K005"];
    [searchdic setValue:mycurrDoc.publicationInfoId forKey:@"K006"];
    [searchdic setValue:mycurrDoc.editionInfoId forKey:@"K008"];
    [searchdic setValue:NAUserDevice forKey:@"UseDevice"];
    [searchdic setValue:myserachtext forKey:@"Keyword"];
    [searchdic setValue:[NSString searchCurrentAtricleFl] forKey:@"Fl"];
    [searchdic setValue:@"K053:desc,K032:desc" forKey:@"Sort"];
    [searchdic setValue:[NSString stringWithFormat:@"%d",0] forKey:@"Start"];
    [searchdic setValue:self.serachDate forKey:@"K003"];
    
    
}
- (void)searchNoteAPI
{
    [searchdic setValue:[NSString stringWithFormat:@"%ld",(long)tableRows] forKey:@"Start"];
    
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    
    [[NANetworkClient sharedClient] postSearch:searchdic
                               completionBlock:^(id search, NSError *error) {
                                   if (!error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           [ProgressHUD dismiss];
                                           SHXMLParser *parser = [[SHXMLParser alloc] init];
                                           NSDictionary *dic = [parser parseData:search];
                                           NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               if (searchBaseClass.response.doc.count > 0) {
                                                   //[self toSearchResultList:searchBaseClass.response.doc];
                                                   for(id obj in searchBaseClass.response.doc)
                                                   {
                                                       [myseracharray addObject: obj];
                                                   }
                                                   tableRows=myseracharray.count;
                                                   
                                                   [self.tView reloadData];
                                               }else{
                                                   //[self.gripToolbar updatelblCurNum:@""];
                                                   [[[iToast makeText:NSLocalizedString(@"NO Note", nil)]
                                                     setGravity:iToastGravityBottom] show];
                                               }
                                           });
                                           
                                           
                                       });
                                   }else{
                                       ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
                                   }
                                   
                               }];
    
}

- (void)searchNoteCountAPI
{
    
    NSMutableDictionary *searchParmes=[[NSMutableDictionary alloc]init];
    NSString *userId = [NASaveData getLoginUserId];
    [searchParmes setValue:userId forKey:@"Userid"];
    [searchParmes setValue:@"1" forKey:@"Rows"];
    
    [searchParmes setValue:@"4" forKey:@"K002"];
    [searchParmes setValue:@"2" forKey:@"Mode"];
    [searchParmes setValue:mycurrDoc.publisherGroupInfoId forKey:@"K004"];
    [searchParmes setValue:mycurrDoc.publisherInfoId forKey:@"K005"];
    [searchParmes setValue:mycurrDoc.publicationInfoId forKey:@"K006"];
    [searchParmes setValue:mycurrDoc.editionInfoId forKey:@"K008"];
    [searchParmes setValue:NAUserDevice forKey:@"UseDevice"];
    [searchParmes setValue:myserachtext forKey:@"Keyword"];
    [searchParmes setValue:[NSString searchCurrentAtricleFl] forKey:@"Fl"];
    [searchParmes setValue:@"K053:desc,K032:desc" forKey:@"Sort"];
    [searchParmes setValue:[NSString stringWithFormat:@"%d",0] forKey:@"Start"];
    [searchParmes setValue:self.serachDate forKey:@"K003"];
    
    
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    
    [[NANetworkClient sharedClient] postSearch:searchParmes
                               completionBlock:^(id search, NSError *error) {
                                   if (!error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           [ProgressHUD dismiss];
                                           SHXMLParser *parser = [[SHXMLParser alloc] init];
                                           NSDictionary *dic = [parser parseData:search];
                                           NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                                        
                                           totalCount=(long)[searchBaseClass.response.header.numFound integerValue];
                                           
                                           
                                       });
                                   }
                                   
                               }];
    
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
    NANewSearchViewController *search = [[NANewSearchViewController alloc]init];
    search.currDoc = self.pageArray[0];
    search.pageArray = _pageArray;
    search.topPageDoc = _topPageDoc;
    search.clipDataSource = _clipDataSource;
    search.regionDic =_regionDic;
    search.haveChangeIndex =  _haveChangeIndex;
//    search.noteNumber = _noteNumber;
//     search.NoteArray = _NoteArray;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:search];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
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
        home.regionFlg = isHaveRegion;
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
        [self presentViewController:nav animated:NO completion:^{
            
            
        }];
    }
    
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
    _labYearHore.font = [FontUtil systemFontOfSizeMedium:10];
    _labYearHore.text = _labYearDetail;
    [leftView addSubview:_labYearHore];
    
    _labMonthDayHore = [[UILabel alloc]init];
    _labMonthDayHore.attributedText = _labMonthDayDetail;
    [leftView addSubview:_labMonthDayHore];
    
    _labMianHore = [[UILabel alloc]init];
    _labMianHore.font = [FontUtil systemFontOfSizeMedium:10];
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
    [btn3 setImage:[UIImage imageNamed:@"03_blue"] forState:0];
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
    }    lineView.backgroundColor = [UIColor colorWithRed:111.0/255.0 green:171.0/255.0 blue:226.0/255.0 alpha:1];
    
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
    [btn3 setImage:[UIImage imageNamed:@"03_blue"] forState:0];
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
- (void)setDairy{
    NADoc *doc = _pageArray[0];
    NSString *date = doc.publishDate;
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
         
                          value:[FontUtil systemFontOfSizeMedium:25]
         
                          range:NSMakeRange(0, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:15]
         
                          range:NSMakeRange(2, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:25]
         
                          range:NSMakeRange(4, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:15]
         
                          range:NSMakeRange(6, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:15]
         
                          range:NSMakeRange(8, 3)];
        _labMonthDayDetail = attString;
        _labMonthDayHore.attributedText = attString;
    }else if (month.length == 1 && day.length == 2) {
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:25]
         
                          range:NSMakeRange(0, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:15]
         
                          range:NSMakeRange(2, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:25]
         
                          range:NSMakeRange(4, 2)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:15]
         
                          range:NSMakeRange(7, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:15]
         
                          range:NSMakeRange(9, 3)];
        _labMonthDayDetail = attString;
        _labMonthDayHore.attributedText = attString;
    }else if (month.length == 2 && day.length == 1) {
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:25]
         
                          range:NSMakeRange(0, 2)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:15]
         
                          range:NSMakeRange(3, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:25]
         
                          range:NSMakeRange(5, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:15]
         
                          range:NSMakeRange(7, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:15]
         
                          range:NSMakeRange(9, 3)];
        _labMonthDayDetail = attString;
        _labMonthDayHore.attributedText = attString;
    }else if (month.length == 2 && day.length == 2) {
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:25]
         
                          range:NSMakeRange(0, 2)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:15]
         
                          range:NSMakeRange(3, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:25]
         
                          range:NSMakeRange(5, 2)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:15]
         
                          range:NSMakeRange(8, 1)];
        [attString addAttribute:NSFontAttributeName
         
                          value:[FontUtil systemFontOfSizeMedium:15]
         
                          range:NSMakeRange(10, 3)];
        _labMonthDayDetail = attString;
        _labMonthDayHore.attributedText = attString;
    }

    
    _labMianDetail = @"1面";
    _labMianHore.text = @"1面";
}
@end

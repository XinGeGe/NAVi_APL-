
//
//  NADetailBaseViewController.m
//  NAVi
//
//  Created by y fs on 15/11/20.
//  Copyright © 2015年 dxc. All rights reserved.
//
#import "NADetailBaseViewController.h"

#import "NANewClipEditingViewController.h"
#import "SwipeView.h"
#import "NAHomeViewController.h"
#import "JXButton.h"
#import "NANewSettingViewController.h"
#import "NANewChooseClipViewController.h"
#import "FontUtil.h"
#import "DateUtil.h"
#import <Social/Social.h>

#import "NATagBaseClass.h"
#import "XLPhotoBrowser.h"
@interface NADetailBaseViewController () <SwipeViewDataSource, SwipeViewDelegate,UIPrintInteractionControllerDelegate,XLPhotoBrowserDatasource,XLPhotoBrowserDelegate,UIActionSheetDelegate>

@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, assign) UIInterfaceOrientation oldFromInterfaceOrientation;
@property (nonatomic, assign) UIInterfaceOrientation oldToInterfaceOrientation;

@property (nonatomic, readwrite) bool isLoadingNextNotes;
@property (nonatomic, readwrite) bool isLoadingPreNotes;
@property (nonatomic, strong)UIButton *detailBtn;
@property (nonatomic, strong)UIButton *clipBtn;
@property (nonatomic, strong)UIView *titleView;
@property (nonatomic, strong)NSString *btnType;
@property (nonatomic, strong)NAClipDoc *detailDoc;
@property (nonatomic, strong)XLPhotoBrowser *xlPhotoBrowser;
@property (nonatomic, strong)NSString *headtitle;
@property (nonatomic, strong)NSString *memoDetail;
@property (nonatomic, strong)NSString *indexNo;
@property (nonatomic, strong)NSString *tagDetail;
@end

@implementation NADetailBaseViewController{
    NADetailSwipeImageViewController *imageController;
    BOOL isNewDetailview;
    
}

@synthesize mudetails;
@synthesize isfromWhere;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(toHomePage)
                                                 name:@"toHomePage" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(toImageDetail:)
                                                 name:@"toImageDetail" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editTags:)
                                                 name:@"editTags" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editDescription:)
                                                 name:@"editDescription" object:nil];
    NSInteger titleWidth = 200;
    if (isPad) {
        titleWidth = 400;
    }
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleWidth, self.navigationController.navigationBar.frame.size.height)];
    _titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = _titleView;
    
    _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_titleView addSubview:_detailBtn];
    [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_top).offset((self.navigationController.navigationBar.frame.size.height-25)/2);
        make.left.mas_equalTo(5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo((titleWidth-15)/2);
    }];
    _detailBtn.backgroundColor = [UIColor colorWithRed:232/255.0 green:106/255.0 blue:151/255.0 alpha:1];
    [_detailBtn setTitle:@"テキスト" forState:UIControlStateNormal];
    [_detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _detailBtn.layer.borderWidth=1;
    _detailBtn.layer.borderColor=[UIColor colorWithRed:232/255.0 green:106/255.0 blue:151/255.0 alpha:1].CGColor;
    _detailBtn.layer.masksToBounds=YES;
    _detailBtn.layer.cornerRadius=10;
    _detailBtn.titleLabel.font = [FontUtil systemFontOfSize:14];
    [_detailBtn addTarget:self action:@selector(detailShow) forControlEvents:UIControlEventTouchUpInside];
    
    _clipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_titleView addSubview:_clipBtn];
    [_clipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_top).offset((self.navigationController.navigationBar.frame.size.height-25)/2);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo((titleWidth-15)/2);
    }];
    _clipBtn.backgroundColor = [UIColor whiteColor];
    [_clipBtn setTitle:@"切り抜き" forState:UIControlStateNormal];
    [_clipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _clipBtn.layer.borderWidth=1;
    _clipBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _clipBtn.layer.masksToBounds=YES;
    _clipBtn.layer.cornerRadius=10;
    _clipBtn.titleLabel.font = [FontUtil systemFontOfSize:14];
    [_clipBtn addTarget:self action:@selector(clipShow) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self isLandscape]) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        _titleView.hidden = YES;
        _clipBtn.hidden = YES;
        _detailBtn.hidden = YES;
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        if ([isfromWhere isEqualToString:TYPE_NOTE]) {
            _titleView.hidden = YES;
            _clipBtn.hidden = YES;
            _detailBtn.hidden = YES;
        }else if ([isfromWhere isEqualToString:TYPE_CLIP]){
            _titleView.hidden = NO;
            _clipBtn.hidden = NO;
            _detailBtn.hidden = NO;
        }
    }
    
    
     _btnType = @"text";
}

- (void)detailShow{
    
    _btnType = @"text";
    [self setSwipeviewIndex];
    _detailBtn.backgroundColor = [UIColor colorWithRed:232/255.0 green:106/255.0 blue:151/255.0 alpha:1];
    _detailBtn.layer.borderColor=[UIColor colorWithRed:232/255.0 green:106/255.0 blue:151/255.0 alpha:1].CGColor;
    _clipBtn.backgroundColor = [UIColor whiteColor];
    _clipBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [_clipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}

- (void)clipShow{
    _btnType = @"clip";
    [self setSwipeviewIndex];
    _clipBtn.backgroundColor = [UIColor colorWithRed:232/255.0 green:106/255.0 blue:151/255.0 alpha:1];
    _clipBtn.layer.borderColor=[UIColor colorWithRed:232/255.0 green:106/255.0 blue:151/255.0 alpha:1].CGColor;
    _detailBtn.backgroundColor = [UIColor whiteColor];
    _detailBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [_clipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_detailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self isLandscape]) {
        _titleView.hidden = YES;
        _clipBtn.hidden = YES;
        _detailBtn.hidden = YES;
        self.navigationItem.leftBarButtonItem = nil;
        [self setHorToolBar];
    }else{
        [self setVerToolBar];
        self.navigationItem.leftBarButtonItem = self.backBtnItem;
        if ([isfromWhere isEqualToString:TYPE_NOTE]) {
            _titleView.hidden = YES;
            _clipBtn.hidden = YES;
            _detailBtn.hidden = YES;
        }else if ([isfromWhere isEqualToString:TYPE_CLIP]){
            _titleView.hidden = NO;
            _clipBtn.hidden = NO;
            _detailBtn.hidden = NO;
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMemo) name:@"reloadMemo" object:nil];
    [self reloadMemo];
}
- (void)reloadMemo{
    [self getClipAPI:_indexNoFromClip];
    [self getTag:_indexNoFromClip];
}
//刷新详细页面使用的tag
- (void)getTag:(NSString *)indexNo{
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"IndexNo"       :  indexNo,
                            };
    [[NANetworkClient sharedClient] postTagFavoritesSearch:param completionBlock:^(id favorites, NSError *error) {
        SHXMLParser *parser = [[SHXMLParser alloc] init];
        NSDictionary *dic = [parser parseData:favorites];
        NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
        
        NSArray *arr = clipBaseClass.response.doc;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (arr.count > 0) {
                NSString *tag;
                for (int i = 0; i < arr.count;i++) {
                    if (i == 0) {
                        NAClipDoc *doc = [arr objectAtIndex:0];
                        tag = doc.tagName;
                    }else{
                        NAClipDoc *doc = [arr objectAtIndex:i];
                        tag = [NSString stringWithFormat:@"%@,%@",tag,doc.tagName];
                    }
                }
                _tagDetail = tag;
            }

        });
    }];
}
//刷新memo
- (void)getClipAPI:(NSString *)indexNo
{
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"K001"       :  indexNo,
                            @"K002" :@"4",
                            };
    [[NANetworkClient sharedClient] postFavoritesSearch:param completionBlock:^(id favorites, NSError *error) {
        if (!error) {
            SHXMLParser *parser = [[SHXMLParser alloc] init];
            NSDictionary *dic = [parser parseData:favorites];
            NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
            NSArray *array = clipBaseClass.response.doc;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (array.count != 0) {
                    NAClipDoc *doc = [array objectAtIndex:0];
                    _memoDetail = doc.memo;
                }

                
            });
        }else{
            ITOAST_BOTTOM(error.localizedDescription);
        }
    }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setSwipeviewIndex];
    
    
}
-(void)setSwipeviewIndex{
    self.swipeView.currentItemIndex = self.currentIndex;
    [self.swipeView scrollToItemAtIndex:self.currentIndex duration:0.3];
    NADetailView *detailView = (NADetailView *)self.swipeView.currentItemView;
    NAClipDoc *clipDoc = detailView.detailDoc;
    detailView.btnType = _btnType;
    NSString *str=[NSString stringWithFormat:@"%@/記事詳細/%@",clipDoc.publishDate,clipDoc.headlineText];
    [TAGManagerUtil pushOpenScreenEvent:ENImageView ScreenName:str];
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
    [_xlPhotoBrowser dismiss];
    [ProgressHUD dismiss];
    [self.swipeView removeFromSuperview];
    self.swipeView = nil;
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
    self.navigationController.navigationBar.translucent=NO;
    self.oldFromInterfaceOrientation = fromInterfaceOrientation;
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    if ([self isLandscape]) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        self.swipeView.frame = CGRectMake(0, 10, screenWidth, screenHeight-10);
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        self.swipeView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    }

    [self.view addSubview:self.swipeView];
    self.swipeView.currentItemIndex = self.currentIndex;
    [self.swipeView scrollToItemAtIndex:self.currentIndex duration:0.3];

    [_xlPhotoBrowser dismiss];
    if ([self isLandscape]) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        _titleView.hidden = YES;
        _clipBtn.hidden = YES;
        _detailBtn.hidden = YES;
        self.navigationItem.leftBarButtonItem = nil;
        [self setHorToolBar];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self setVerToolBar];
        self.navigationItem.leftBarButtonItem = self.backBtnItem;
        if ([isfromWhere isEqualToString:TYPE_NOTE]) {
            _titleView.hidden = YES;
            _clipBtn.hidden = YES;
            _detailBtn.hidden = YES;
        }else if ([isfromWhere isEqualToString:TYPE_CLIP]){
            _titleView.hidden = NO;
            _clipBtn.hidden = NO;
            _detailBtn.hidden = NO;
        }
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

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.toolBar];
    if ([self isLandscape]) {
        _titleView.hidden = YES;
        _clipBtn.hidden = YES;
        _detailBtn.hidden = YES;
        self.navigationItem.leftBarButtonItem = nil;
        [self setHorToolBar];
    }else{
        [self setVerToolBar];
        self.navigationItem.leftBarButtonItem = self.backBtnItem;
        if ([isfromWhere isEqualToString:TYPE_NOTE]) {
            _titleView.hidden = YES;
            _clipBtn.hidden = YES;
            _detailBtn.hidden = YES;
        }else if ([isfromWhere isEqualToString:TYPE_CLIP]){
            _titleView.hidden = NO;
            _clipBtn.hidden = NO;
            _detailBtn.hidden = NO;
        }
    }
    [self.view addSubview:self.swipeView];
    self.swipeView.hidden = YES;
    

    
}

/**
 * 戻るボタン action
 *
 */
- (void)backBtnItemAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        if ([isfromWhere isEqualToString:TYPE_HOME]) {
            NADetailView *detailView = (NADetailView *)self.swipeView.currentItemView;
            NAClipDoc *clipDoc = detailView.detailDoc;
            detailView.btnType = _btnType;
            NSString *noteIndexNo = clipDoc.indexNo;
            
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@", noteIndexNo],@"noteIndexNo", [NSString stringWithFormat:@"%@", clipDoc.publishingHistoryInfoContentIdPaperInfo], @"paperIndexNo", nil];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getListselectindex" object:nil userInfo:dic];
        }
    }];
}
/**
 * view更新
 *
 */
- (void)updateViews
{
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat barHeight = TOOLBAR_HEIGHT;
    if (isPhone) {
        self.toolBar.frame = CGRectMake(0, screenHeight - barHeight, screenWidth, barHeight);
    }else{
        self.toolBar.frame = CGRectMake(0, screenHeight - 49, screenWidth, 49);
    }
    
    NADetailView *detailView = (NADetailView *)self.swipeView.currentItemView;
    detailView.btnType = _btnType;
    detailView.navBarHeight=navHeight;
    if ([self isLandscape]) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        self.swipeView.frame = CGRectMake(0, 10, screenWidth, screenHeight-10);
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        self.swipeView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    }
    
    
}



- (SwipeView *)swipeView
{
    if (!_swipeView) {
        _swipeView = [[SwipeView alloc] initWithFrame:CGRectZero];
        _swipeView.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1];
        _swipeView.dataSource = self;
        _swipeView.delegate = self;
    }
    
    return _swipeView;
}

/**
 * clip追加、削除処理
 *
 */
- (void)clipBtnAction:(id)sender
{
    [self clipAPI];
}

#pragma mark - swipe delegate -
#pragma mark

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.details.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    NAClipDoc *clipDoc = self.details[index];
    NADetailView *detailView = (NADetailView *)view;
    // view初期化
    if (!detailView) {
        detailView = [[NADetailView alloc] initWithFrame:self.swipeView.bounds];
        isNewDetailview=YES;
    }else{
        isNewDetailview=NO;
        
    }
    //propertyを設定
    if ([self isLandscape]) {
        detailView.isTateShow = YES;
    }else{
        detailView.isTateShow = NO;
    }
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    detailView.navBarHeight=navHeight;
    
    detailView.detailDoc = clipDoc;
    detailView.title = [NSString stringWithFormat:@"%@",clipDoc.newsGroupTitle];
    // 記事文字を設定
    CGFloat textFont = [NASaveData getExpansion_rateNum];
    [NASaveData saveFontNum:textFont];
    CGFloat fontSize = [NASaveData getFontSize:textFont];
    [detailView textFontValue:fontSize];
    NSString *dtext=@"";
    if ([clipDoc.newsText isKindOfClass:[NSString class]]) {
        dtext=[CharUtil ChangetheTobr:clipDoc.newsText];
        detailView.text = dtext;
    }
    
    if (self.myserachtext.length>0){
        detailView.title=[CharUtil ChangetheDetailtext:detailView.title keyword:self.myserachtext];
        detailView.text=[CharUtil ChangetheDetailtext:detailView.text keyword:self.myserachtext];
    }
    
    detailView.myfont=fontSize;
    detailView.myserachtext = self.myserachtext;
    detailView.isfromWhere=isfromWhere;
    detailView.pageView.isfromWhere=isfromWhere;
    
    NSString *imagepath=clipDoc.miniPhotoPath;
    // 記事画像を設定
    if ([imagepath isKindOfClass:[NSString class]] && imagepath.length > 0) {
        NSArray *urlarray=[imagepath componentsSeparatedByString:@","];
        NSString *urlstr=[urlarray objectAtIndex:0];
        detailView.imagePath =[CharUtil convHttps2Image:urlstr] ;
        detailView.imageurlarray=urlarray;
    }else {
        detailView.imagePath = nil;
    }
    
    
    
    _detailDoc = clipDoc;
    _indexNo = clipDoc.indexNo;
    detailView.btnType = _btnType;
    detailView.isNewDetailview=isNewDetailview;
    _headtitle = [NSString stringWithFormat:@"%@",clipDoc.newsGroupTitle];
    detailView.photoPathD = clipDoc.photoPathD;
    detailView.indexNo = clipDoc.indexNo;
    detailView.memo = clipDoc.memo;
    detailView.tagDetail = clipDoc.tagName;
    
    if (!isNewDetailview) {
        [detailView loadmyhtml];
    }else{
        if ([self isLandscape]) {
            [detailView setShowStyle:YES];
        }else{
            [detailView setShowStyle:NO];
        }
    }
    [detailView updateViews];
    return detailView;
}

//滚动
-(void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView{
    NADetailView *detailView = (NADetailView *)self.swipeView.currentItemView;
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    detailView.navBarHeight=navHeight;
    detailView.btnType = _btnType;
    detailView.indexNo = _indexNo;
    [detailView updateViews];
   
    if (isNewDetailview) {
        [detailView loadmyhtml];
    }
    
}

- (void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate{
    if(swipeView.scrollView.contentOffset.x > (swipeView.scrollView.contentSize.width - swipeView.frame.size.width))
    {
        self.isLoadingNextNotes = YES;
        
        // 紙面記事を取得場合、待てメッセージを表示
        if ([isfromWhere isEqualToString:TYPE_NOTE]) {
            [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
        }
    }else if (swipeView.scrollView.contentOffset.x < 0){
        self.isLoadingPreNotes = YES;
        
        // 紙面記事を取得場合、待てメッセージを表示
        if ([isfromWhere isEqualToString:TYPE_NOTE]) {
            [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
        }
    }
}

- (void)swipeViewDidEndDecelerating:(SwipeView *)swipeView{
    if(self.isLoadingNextNotes)
    {
        if ([isfromWhere isEqualToString:TYPE_NOTE]) {
            // 記事情報を取得
            NSArray *noteList = [self getNoteInfos:@"next"];
            if (noteList && noteList.count > 0) {
                // 記事IndexNo
                NSInteger scrollIndex = self.details.count;
                
                // 記事情報をreload
                mudetails = [NSMutableArray arrayWithArray:self.details];
                [mudetails addObjectsFromArray:noteList];
                self.details = mudetails;
                
                // 記事を表示する
                self.swipeView.currentItemIndex = scrollIndex;
                [self.swipeView scrollToItemAtIndex:scrollIndex duration:0];
            } else {
                [[[iToast makeText:NSLocalizedString(@"last note display", @"")]
                  setGravity:iToastGravityBottom] show];
            }
            
            [ProgressHUD dismiss];
            
        } else {
            [[[iToast makeText:NSLocalizedString(@"last note display", @"")]
              setGravity:iToastGravityBottom] show];
        }
        
        self.isLoadingNextNotes = NO;
        
    }else if (self.isLoadingPreNotes){
        if ([isfromWhere isEqualToString:TYPE_NOTE]) {
            
            // 記事情報を取得
            NSArray *noteList = [self getNoteInfos:@"pre"];
            if (noteList && noteList.count > 0) {
                // 記事IndexNo
                NSInteger scrollIndex = noteList.count - 1;
                
                // 記事情報をreload
                mudetails = [NSMutableArray arrayWithArray:noteList];
                [mudetails addObjectsFromArray:self.details];
                self.details = mudetails;
                
                // 記事を表示する
                self.swipeView.currentItemIndex = scrollIndex;
                [self.swipeView scrollToItemAtIndex:scrollIndex duration:0];
            } else {
                [[[iToast makeText:NSLocalizedString(@"frist note display", @"")]
                  setGravity:iToastGravityBottom] show];
            }
            
            [ProgressHUD dismiss];
            
        } else {
            [[[iToast makeText:NSLocalizedString(@"frist note display", @"")]
              setGravity:iToastGravityBottom] show];
        }
        
        self.isLoadingPreNotes = NO;
    }
    self.currentIndex=self.swipeView.currentItemIndex;
}
- (void)swipeViewDidEndScrollingAnimation:(SwipeView *)swipeView{
    
    NADetailView *detailView = (NADetailView *)self.swipeView.currentItemView;
    detailView.btnType = _btnType;
    detailView.memo = _memoDetail;
    detailView.tagDetail = _tagDetail;
    [detailView loadmyhtml];
    self.swipeView.hidden = NO;
}

/**
 * clip追加、削除処理のAPI
 *
 */
- (void)clipAPI
{
    [ProgressHUD show:NSLocalizedString(@"note saving", nil)];
    NAClipDoc *doc = self.details[self.currentIndex];
    NSDictionary *param = @{
//                               @"Fl"         :  [NSString addclipListFl],
//                               @"Mode"       :  @"1",
                               @"IndexNo"       :  doc.indexNo,
//                               @"K002"       :  @"4",
//                               @"Rows"       :  @"999",
                               @"Userid"     :  [NASaveData getLoginUserId]
//                               @"UseDevice"  :  @"N05"
                               
                               };
    if (self.deleteClip) {
        [[NANetworkClient sharedClient] postFavoritesDelete:param completionBlock:^(id favorites, NSError *error) {
            if (!error) {
                MAIN(^{
                    
                    [ProgressHUD dismiss];
                    [[[iToast makeText:NSLocalizedString(@"note deleted", nil)]
                      setGravity:iToastGravityBottom] show];
                    [TAGManagerUtil pushButtonClickEvent:ENClipDelBtn label:[Util getLabelName:doc]];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [[NSNotificationCenter defaultCenter]postNotificationName:NOTYReloadClip object:nil];
                });
                
            }
        }];
        
    }else{
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
                }else if([statusMessage isEqualToString:@"4"]){
                    MAIN(^{
                        [ProgressHUD dismiss];
                        [[[iToast makeText:NSLocalizedString(@"すでにスクラップしています", nil)]
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
    
}

/**
 * main画面を戻る
 *
 */
-(void)toHomePage{
    UIViewController *myfromViewController=nil;
    if ([self.isfromWhere isEqualToString:TYPE_NOTE]) {
        NAHomeViewController *home = [[NAHomeViewController alloc] init];
        home.forwardPage=@"topPage";
        home.topPageDoc= _topPageDoc;
        home.regionDic = _regionDic;
        home.homePageArray = _pageArray;
        home.clipDataSource = _clipDataSource;
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:home];
        [self presentViewController:nav animated:NO completion:^{
            
            
        }];
    }else{
        myfromViewController=self.presentingViewController;
        [myfromViewController dismissViewControllerAnimated:YES completion:^{
            NADetailView *detailView = (NADetailView *)self.swipeView.currentItemView;
            NAClipDoc *clipDoc = detailView.detailDoc;
            detailView.btnType = _btnType;
            NSString *noteIndexNo = clipDoc.indexNo;
            
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@", noteIndexNo],@"noteIndexNo", [NSString stringWithFormat:@"%@", clipDoc.publishingHistoryInfoContentIdPaperInfo], @"paperIndexNo", nil];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getListselectindex" object:nil userInfo:dic];
        }];
    }

    
}
//choose tag
- (void)editTags:(NSNotification *)notify{
    NANewChooseClipViewController *search = [[NANewChooseClipViewController alloc]init];
    search.indexNo = _indexNo;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:search];
    [self presentViewController:nav animated:YES completion:^{
        
    }];

}
//edit memo
- (void)editDescription:(NSNotification *)notify{
    NANewClipEditingViewController *search = [[NANewClipEditingViewController alloc]init];
    search.indexNo = _indexNo;
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:search];
    [self presentViewController:nav animated:YES completion:^{
        
    }];

}

/**
 * 画像詳細画面を表示
 *
 */
-(void)toImageDetail:(NSNotification *)notify{
    self.currentIndex = self.swipeView.currentItemIndex;
    NSDictionary *dic=[notify userInfo];
    
    imageController=[[NADetailSwipeImageViewController alloc]init];
    imageController.imagearray=[dic objectForKey:@"imageUris"];
    imageController.isfromWhere=self.isfromWhere;
    NAClipDoc *clipdoc=[dic objectForKey:@"noteDoc"];
    
    NSNumber *isdetailimage=[dic objectForKey:@"isdetailimage"];
    if (isdetailimage.boolValue) {
        if (clipdoc) {
            imageController.noteDoc=clipdoc;
            imageController.noteTitle=clipdoc.newsGroupTitle;
        }
        
        [self getRelevantPhoto];
    }else{
        if (clipdoc) {
            imageController.mailDoc=clipdoc;
            imageController.noteTitle=clipdoc.newsGroupTitle;
        }
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:imageController];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
    
    
    

    
}
/**
 *getRelevantPhoto
 *
 */
- (void)getRelevantPhoto
{
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    NADetailView *detailView = (NADetailView *)self.swipeView.currentItemView;
    NAClipDoc *clipDoc = detailView.detailDoc;
    NSString *k002=[clipDoc.indexNo substringFromIndex:0];
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"Rows"       :  @"999",
                            @"UseDevice"  :  NAUserDevice,
                            @"K002"       :  k002,
                            @"Mode"       :  @"1",
                            @"Fl"         :  [NSString clipListFl],
                            @"K001"       : clipDoc.indexNo,
                            };
    [[NANetworkClient sharedClient] postRelevantPhoto:param completionBlock:^(id favorites, NSError *error) {
        [ProgressHUD dismiss];
        if (error==nil) {
            SHXMLParser *parser = [[SHXMLParser alloc] init];
            NSDictionary *dic = [parser parseData:favorites];
            NAImageDetailClass *imageBaseClass = [NAImageDetailClass modelObjectWithDictionary:dic];
            NSString *imagepath = imageBaseClass.Image_L_Path;
            NSArray *uris=[imagepath componentsSeparatedByString:@","];
            imageController.imagearray=uris;
            
            if ([imageBaseClass.PictureType isEqualToString:@"M"]) {
                NSString *trueUrl=[Util getMP4Url:imageBaseClass.RelatedInfo3 Prams:[Util getYYMMDateString:imageBaseClass.Image_L_LastModified]];
                NAMoviePlayerController *playerViewController =[[NAMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:[CharUtil getRightUrl:trueUrl]]];
                [self presentMoviePlayerViewControllerAnimated:playerViewController];
            }else{
                imageController.imageBaseClass=imageBaseClass;
                NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:imageController];
                [self presentViewController:nav animated:YES completion:^{
                    
                }];
            }
            
            NADetailView *detailView = (NADetailView *)self.swipeView.currentItemView;
            NAClipDoc *clipDoc = detailView.detailDoc;
            imageController.myclipDoc=clipDoc;
            NSString *str=[NSString stringWithFormat:@"%@/画像表示/%@",clipDoc.publishDate,imageBaseClass.Caption];
            [TAGManagerUtil pushOpenScreenEvent:ENImageView ScreenName:str];
        }
        
    }];

}

/**
 * 記事情報を取得
 *
 */
-(NSArray *)getNoteInfos:(NSString *)scrollFlg{
    
    
    NABaseNavigationController *baseController = (NABaseNavigationController *)self.presentingViewController;
    NAHomeViewController *homeViewController;
    
    for (NSInteger i = 0; i < baseController.childViewControllers.count; i++) {
        if ([baseController.childViewControllers[i] isKindOfClass:[NAHomeViewController class]]) {
            homeViewController = baseController.childViewControllers[i];
            break;
        }
    }
    
    NADetailView *detailView = (NADetailView *)self.swipeView.currentItemView;
    detailView.btnType = _btnType;
    NSString *paperIndexNo = detailView.detailDoc.publishingHistoryInfoContentIdPaperInfo;
    NADoc *paperDoc;
    NSInteger docIndex;
    
    for (docIndex = 0; docIndex < homeViewController.pageArray.count; docIndex++) {
        paperDoc = homeViewController.pageArray[docIndex];
        if ([paperIndexNo isEqualToString:paperDoc.indexNo]) {
            break;
        }
    }
    
    if ([scrollFlg isEqualToString:@"next"]) {
        while (docIndex + 1 < homeViewController.pageArray.count) {
            docIndex = docIndex + 1;
            paperDoc = homeViewController.pageArray[docIndex];
            
            [self getNoteWithDoc:paperDoc];
            if (paperDoc.notearray && paperDoc.notearray.count > 0) {
                return paperDoc.notearray;
            }
        }
    }
    
    if ([scrollFlg isEqualToString:@"pre"]) {
        while (docIndex - 1 > -1) {
            docIndex = docIndex - 1;
            paperDoc = homeViewController.pageArray[docIndex];
            
            [self getNoteWithDoc:paperDoc];
            if (paperDoc.notearray && paperDoc.notearray.count > 0) {
                return paperDoc.notearray;
            }
            
        }
    }
    
    
    
    return nil;
}

/**
 * 紙面情報から、記事情報を取得
 *
 */
- (void)getNoteWithDoc:(NADoc *)doc
{
    if (doc.notearray && doc.notearray.count > 0) {
        return;
    } else {
        NSString *path = [[NAFileManager sharedInstance] searchNoteName:doc withNoteName:NoteFileName];
        NSFileManager *fileManage = [NSFileManager defaultManager];
        if ([fileManage fileExistsAtPath:path isDirectory:FALSE]) {
            NSData *data = [NSData dataWithContentsOfFile:path];
            doc.notearray = [[NAFileManager sharedInstance] arrayWithData:data];
            
            for (NSInteger index=0; index<doc.notearray.count; index++) {
                NADoc *temdoc=[doc.notearray objectAtIndex:index];
                temdoc.miniPagePath=doc.miniPagePath;
                temdoc.lastUpdateDateAndTime=doc.lastUpdateDateAndTime;
            }
        }
    }
}

- (void) pushItem:(UIButton *)sender
{
    if (sender.tag == 1001) {
        [self clipAPI];
    }else if (sender.tag == 1002){
        NSString *imagePath = _detailDoc.clippingImgPath;;
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
    
    }else if (sender.tag == 1003){
        if ([_detailDoc.clippingImgPath isEqualToString:@""]) {
            [[[iToast makeText:NSLocalizedString(@"NO Note", nil)]
              setGravity:iToastGravityBottom] show];
        } else {
         
            [ProgressHUD show:NSLocalizedString(@"imageloading", nil)];
            //进入异步线程
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //异步下载图片
                NSString *imagePath = _detailDoc.clippingImgPath;
                
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
                        
                        activeViewController.popoverPresentationController.sourceView = sender;
                        activeViewController.popoverPresentationController.sourceRect = sender.bounds;
                        
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
      
    }else if (sender.tag == 1004){

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
    
}

- (void)setVerToolBar{
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    JXButton  *btn1 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn1.frame = CGRectMake(0, 2, 50,40);
    }else{
        btn1.frame = CGRectMake(0, 2, 50,45);
    }
    btn1.tag = 1001;
    [btn1 setTitle:@"スクラップ" forState:0];
    [btn1 setTitleColor:[UIColor blackColor] forState:0];
    [btn1 setImage:[UIImage imageNamed:@"16_blue"] forState:0];
    [btn1 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn1bar= [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    JXButton  *btn2 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn2.frame = CGRectMake(0, 2, 40,40);
    }else{
        btn2.frame = CGRectMake(0, 2, 40,45);
    }
    btn2.tag = 1002;
    [btn2 setTitle:@"フリント" forState:0];
    [btn2 setTitleColor:[UIColor blackColor] forState:0];
    [btn2 setImage:[UIImage imageNamed:@"17_blue"] forState:0];
    [btn2 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn2bar= [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    JXButton  *btn3 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn3.frame = CGRectMake(0, 2, 40,40);
    }else{
        btn3.frame = CGRectMake(0, 2, 40,45);
    }
    btn3.tag = 1003;
    [btn3 setTitle:@"シェア" forState:0];
    [btn3 setTitleColor:[UIColor blackColor] forState:0];
    [btn3 setImage:[UIImage imageNamed:@"18_blue"] forState:0];
    [btn3 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn3bar= [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    JXButton  *btn4 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn4.frame = CGRectMake(0, 2, 40,40);
    }else{
        btn4.frame = CGRectMake(0, 2, 40,40);
    }
    btn4.tag = 1004;
    [btn4 setTitle:@"設定" forState:0];
    [btn4 setTitleColor:[UIColor blackColor] forState:0];
    [btn4 setImage:[UIImage imageNamed:@"05_blue"] forState:0];
    [btn4 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn4bar= [[UIBarButtonItem alloc] initWithCustomView:btn4];
    if ([isfromWhere  isEqual: TYPE_NOTE]) {
        self.toolBar.items=[NSArray arrayWithObjects:spaceButtonItem,btn1bar,spaceButtonItem,btn2bar,spaceButtonItem,btn3bar,spaceButtonItem,btn4bar,nil];
    }else if ([isfromWhere  isEqual: TYPE_CLIP]){
        self.toolBar.items=[NSArray arrayWithObjects:spaceButtonItem,btn2bar,spaceButtonItem,btn3bar,spaceButtonItem,btn4bar,nil];
    }
    
    [self.view addSubview:self.toolBar];

}
- (void)setHorToolBar{
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    CGFloat screenwidth = [Util screenSize].width;
    UIView *leftView;
    if (isPhone) {
        leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwidth/5, 44)];
    }else{
        leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwidth/5, 49)];
    }
    //leftView.backgroundColor = [UIColor redColor];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftView addSubview:backBtn];
    if (isPhone) {
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_left).offset(10);
            make.top.equalTo(leftView.mas_top).offset(13);
            make.width.mas_equalTo(78/2);
            make.height.mas_equalTo(36/2);
        }];
    }else{
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_left).offset(10);
            make.top.equalTo(leftView.mas_top).offset(15);
            make.width.mas_equalTo(78/2);
            make.height.mas_equalTo(36/2);
        }];
    }
    
    [backBtn setImage:[UIImage imageNamed:@"19_blue"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn5bar= [[UIBarButtonItem alloc] initWithCustomView:leftView];
    
    JXButton  *btn1 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn1.frame = CGRectMake(0, 2, 50,40);
    }else{
        btn1.frame = CGRectMake(0, 2, 50,45);
    }
    btn1.tag = 1001;
    [btn1 setTitle:@"スクラップ" forState:0];
    [btn1 setTitleColor:[UIColor blackColor] forState:0];
    [btn1 setImage:[UIImage imageNamed:@"16_blue"] forState:0];
    [btn1 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn1bar= [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    JXButton  *btn2 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn2.frame = CGRectMake(0, 2, 40,40);
    }else{
        btn2.frame = CGRectMake(0, 2, 40,45);
    }
    btn2.tag = 1002;
    [btn2 setTitle:@"フリント" forState:0];
    [btn2 setTitleColor:[UIColor blackColor] forState:0];
    [btn2 setImage:[UIImage imageNamed:@"17_blue"] forState:0];
    [btn2 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn2bar= [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    JXButton  *btn3 = [JXButton buttonWithType:UIButtonTypeCustom];
    if (isPhone) {
        btn3.frame = CGRectMake(0, 2, 40,40);
    }else{
        btn3.frame = CGRectMake(0, 2, 40,45);
    }
    btn3.tag = 1003;
    [btn3 setTitle:@"シェア" forState:0];
    [btn3 setTitleColor:[UIColor blackColor] forState:0];
    [btn3 setImage:[UIImage imageNamed:@"18_blue"] forState:0];
    [btn3 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn3bar= [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    UIView *rightView;
    if (isPhone) {
        rightView = [[UIView alloc]initWithFrame:CGRectMake(screenwidth/4, 0, screenwidth/4, 44)];
    }else{
        rightView = [[UIView alloc]initWithFrame:CGRectMake(screenwidth/4, 0, screenwidth/4, 49)];
    }
//    rightView.backgroundColor = [UIColor greenColor];
    JXButton  *btn4 = [JXButton buttonWithType:UIButtonTypeCustom];
    [rightView addSubview:btn4];
    if (isPhone) {
        [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rightView.mas_top);
            make.right.equalTo(rightView.mas_right);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(30);
        }];
    }else{
        [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rightView.mas_top);
            make.right.equalTo(rightView.mas_right);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(35);
        }];
    }
    
    btn4.tag = 1004;
    [btn4 setTitleColor:[UIColor blackColor] forState:0];
    [btn4 setTitle:@"設定" forState:0];
    [btn4 setImage:[UIImage imageNamed:@"05_blue"] forState:0];
    [btn4 addTarget:self action:@selector(pushItem:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labMian = [[UILabel alloc]init];
    [rightView addSubview:labMian];
    if (isPhone) {
        [labMian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(btn4.mas_left);
            make.top.equalTo(rightView.mas_top).offset(5);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
    }else{
        [labMian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(btn4.mas_left);
            make.top.equalTo(rightView.mas_top).offset(5);
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(35);
        }];
    }
    //labMian.backgroundColor = [UIColor redColor];
    labMian.text = [NSString stringWithFormat:@"%@",_topPageDoc.pageInfoName];;
    labMian.textColor = [UIColor lightGrayColor];
    labMian.textAlignment = NSTextAlignmentRight;
    if (isPhone) {
        labMian.font = [FontUtil systemFontOfSize:10];
    }else{
        labMian.font = [FontUtil systemFontOfSize:15];
    }
    
    
    UILabel *labDate = [[UILabel alloc]init];
    [rightView addSubview:labDate];
    if (isPhone) {
        [labDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(labMian.mas_left);
            make.top.equalTo(rightView.mas_top).offset(5);
            make.left.equalTo(rightView.mas_left);
            make.height.mas_equalTo(30);
        }];
    }else{
        [labDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(labMian.mas_left);
            make.top.equalTo(rightView.mas_top).offset(5);
            make.left.equalTo(rightView.mas_left);
            make.height.mas_equalTo(35);
        }];
        
    }
    
    labDate.text = [DateUtil formateDateWithSlash:_topPageDoc.publishDate];
    labDate.textColor = [UIColor lightGrayColor];
    //labDate.backgroundColor = [UIColor yellowColor];
    if (isPhone) {
        labDate.font = [FontUtil systemFontOfSize:10];
    }else{
        labDate.font = [FontUtil systemFontOfSize:15];
    }
    UIBarButtonItem *btn6bar= [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    if ([isfromWhere  isEqual: TYPE_NOTE]) {
        self.toolBar.items=[NSArray arrayWithObjects:btn5bar,spaceButtonItem,btn1bar,spaceButtonItem,btn2bar,spaceButtonItem,btn3bar,spaceButtonItem,btn6bar,nil];
    }else if ([isfromWhere  isEqual: TYPE_CLIP]){
        self.toolBar.items=[NSArray arrayWithObjects:btn5bar,spaceButtonItem,btn2bar,spaceButtonItem,btn3bar,spaceButtonItem,btn6bar,nil];
    }
    
    [self.view addSubview:self.toolBar];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        /* **************系统分享方法一************** */
        //初始化分享控件
        UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[@"百度",[NSURL URLWithString:@"http://www.baidu.com"]] applicationActivities:nil];
        //不显示哪些分享平台
        //        avc.excludedActivityTypes = @[UIActivityTypeAirDrop,UIActivityTypeCopyToPasteboard,UIActivityTypeAddToReadingList];
        
        [self presentViewController:avc animated:YES completion:nil];
        //分享结果回调方法
        UIActivityViewControllerCompletionHandler myblock = ^(NSString *type,BOOL completed){
            NSLog(@"%d %@",completed,type);
        };
        avc.completionHandler = myblock;
    }else if (buttonIndex==1){
        /* **************系统分享方法二************** */
        
        // 首先判断某个平台是否可用（如果未绑定账号则不可用）
        
        if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            NSLog(@"不可用");
            return;
        }
        
        /* *****可以分享的平台*****
         SOCIAL_EXTERN NSString *const SLServiceTypeTwitter NS_AVAILABLE(10_8, 6_0);
         SOCIAL_EXTERN NSString *const SLServiceTypeFacebook NS_AVAILABLE(10_8, 6_0);
         SOCIAL_EXTERN NSString *const SLServiceTypeSinaWeibo NS_AVAILABLE(10_8, 6_0);
         SOCIAL_EXTERN NSString *const SLServiceTypeTencentWeibo NS_AVAILABLE(10_9, 7_0);
         SOCIAL_EXTERN NSString *const SLServiceTypeLinkedIn NS_AVAILABLE(10_9, NA);
         */
        
        // 创建控制器，并设置ServiceType
        SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        // 添加要分享的图片
        [composeVC addImage:[UIImage imageNamed:@"Nameless"]];
        // 添加要分享的文字
        [composeVC setInitialText:@"share to PUTClub"];
        // 添加要分享的url
        [composeVC addURL:[NSURL URLWithString:@"http://www.putclub.com"]];
        // 弹出分享控制器
        [self presentViewController:composeVC animated:YES completion:nil];
        // 监听用户点击事件
        composeVC.completionHandler = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultDone) {
                NSLog(@"点击了发送");
            }
            else if (result == SLComposeViewControllerResultCancelled)
            {
                NSLog(@"点击了取消");
            }
        };
        
    }else{
        NSLog(@"点击了取消");
    }
    
}

- (void)backBtnItem:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end

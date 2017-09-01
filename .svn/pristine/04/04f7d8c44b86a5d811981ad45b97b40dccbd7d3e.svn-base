//
//  NAGifuMainViewController.m
//  NAVi
//
//  Created by y fs on 15/7/14.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NAGifuMainViewController.h"
#import "NADetailViewController.h"
#import "NADownloadHelper.h"
#import "NASettingViewController.h"
#import "DHSlideMenuController.h"
#import "NALeftMenuViewController.h"
#import "NASearchViewController.h"


@implementation NAGifuMainViewController{
    
    BOOL isTateShow;
    NSArray *docarray;
    NSMutableArray *menuarray;
    
    UIBarButtonItem *pageitem;
    UIBarButtonItem *changeItem;
    
    UIButton *bigFontBtn;
    UIButton *midFontBtn;
    UIButton *smallFontBtn;
    UIButton *clipBtn;
    UIButton *changeBtn;
    BOOL isClip;
    
    NSMutableArray *clipArray;
    
    NSString *mytitle;
}

@synthesize isfromWhere;
@synthesize currentsdoc;

-(void)viewDidLoad{
    [super viewDidLoad];
    isThefirst=YES;
    isSearchNoteAPI=YES;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    self.title=[formatter stringFromDate:[NSDate date]];
    
    UIButton *cbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cbutton setBackgroundImage:[UIImage imageNamed:@"btn_close_on"]
                       forState:UIControlStateNormal];
    [cbutton addTarget:self action:@selector(backBtnItemAction) forControlEvents:UIControlEventTouchUpInside];
    cbutton.frame = CGRectMake(0, 0, 94*1/2, 32*1/2);
    
    //UIBarButtonItem *backBtnItem= [[UIBarButtonItem alloc] initWithCustomView:cbutton];
    
    UIBarButtonItem *toggleMenu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ToggleMenu"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleSideView)];
    toggleMenu.tintColor = [UIColor blueColor];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:GETIMAGENAME(@"btn_search_on")]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchBarItemAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 40, 40);
    
    UIBarButtonItem *searchBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    
    UIButton *rbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rbutton setBackgroundImage:[UIImage imageNamed:GETIMAGENAME(@"btn_refresh_on")]
                       forState:UIControlStateNormal];
    [rbutton addTarget:self action:@selector(refreshBarItemAction) forControlEvents:UIControlEventTouchUpInside];
    rbutton.frame = CGRectMake(0, 0, 40, 40);
    
    UIBarButtonItem *refreshBarItem= [[UIBarButtonItem alloc] initWithCustomView:rbutton];
    
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects: searchBarItem,nil]];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: refreshBarItem,nil]];
    
    
    self.fontSize=[NASaveData getSokuhoFontSize:[NASaveData getSokuhoFontNum]];
    
    if ([NASaveData getSokuhoFontNum]==0) {
        bigFontBtn.selected=YES;
    }else if([NASaveData getSokuhoFontNum]==1){
        midFontBtn.selected=YES;
    }else if ([NASaveData getSokuhoFontNum]==2){
        smallFontBtn.selected=YES;
    }
    isTateShow=[NASaveData getFastNewsTate];
    self.noteArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNASDoc:) name:NOTYGetNASDoc object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(toNoteDetail:)
                                                 name:@"toNoteDetail" object:nil];
    BACK(^{
        [self showSokuhoInfoByFirstGenre];
    });
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([NASaveData getFastNewsTate]) {
        [changeBtn setImage:[UIImage imageNamed:@"btn_yoko"] forState:UIControlStateNormal];
    }else{
        [changeBtn setImage:[UIImage imageNamed:@"btn_tate"] forState:UIControlStateNormal];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NALeftMenuViewController *leftvc=(NALeftMenuViewController *)[DHSlideMenuController sharedInstance].leftViewController;
    [leftvc initGenre:menuarray];
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
    
    [self.swipeView reloadData];
    
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
    
    [self.swipeView scrollToItemAtIndex:self.currentIndex duration:0];
    
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
    self.title = NSLocalizedString(@"", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.toolBar];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_refresh_on"]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(refreshBarItemAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 40, 40);
    
    //UIBarButtonItem *refreshBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem =self.backBtnItem;
    
    changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.frame = CGRectMake(2, 0, 50, 50);
    if (isTateShow) {
        [changeBtn setImage:[UIImage imageNamed:@"btn_yoko"] forState:UIControlStateNormal];
    }else{
        [changeBtn setImage:[UIImage imageNamed:@"btn_tate"] forState:UIControlStateNormal];
    }
    
    [changeBtn addTarget:self action:@selector(changeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    changeItem = [[UIBarButtonItem alloc] initWithCustomView:changeBtn];
    
    clipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clipBtn.frame = CGRectMake(0, 0, 50, 50);
    if ([isfromWhere isEqualToString:@"clip"]) {
        isClip=YES;
        [clipBtn setImage:[UIImage imageNamed:GETIMAGENAME(@"icon_del_off")] forState:UIControlStateNormal];
    }else{
        isClip=NO;
        [clipBtn setImage:[UIImage imageNamed:GETIMAGENAME(@"btn_tool_clip_off")] forState:UIControlStateNormal];
        
    }
    
    [clipBtn addTarget:self action:@selector(clipBtnAction) forControlEvents:UIControlEventTouchUpInside];
    clipBtn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *clipButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clipBtn];
    
    UIView *fontView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 107, TOOLBAR_HEIGHT)];
    
    bigFontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bigFontBtn.tag=1;
    bigFontBtn.frame = CGRectMake(2, 0, 50, 50);
    [bigFontBtn setImage:[UIImage imageNamed:GETIMAGENAME(@"btn_font_3_off")] forState:UIControlStateNormal];
    [bigFontBtn setImage:[UIImage imageNamed:@"btn_font_3_on"] forState:UIControlStateSelected];
    [bigFontBtn addTarget:self action:@selector(bigFontBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    midFontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    midFontBtn.tag=2;
    midFontBtn.frame = CGRectMake(37, 0, 50, 50);
    [midFontBtn setImage:[UIImage imageNamed:GETIMAGENAME(@"btn_font_2_off")] forState:UIControlStateNormal];
    [midFontBtn setImage:[UIImage imageNamed:@"btn_font_2_on"] forState:UIControlStateSelected];
    [midFontBtn addTarget:self action:@selector(bigFontBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    smallFontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    smallFontBtn.tag=3;
    smallFontBtn.frame = CGRectMake(72, 0, 50, 50);
    [smallFontBtn setImage:[UIImage imageNamed:GETIMAGENAME(@"btn_font_1_off")] forState:UIControlStateNormal];
    [smallFontBtn setImage:[UIImage imageNamed:@"btn_font_1_on"] forState:UIControlStateSelected];
    [smallFontBtn addTarget:self action:@selector(bigFontBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [fontView addSubview:bigFontBtn];
    [fontView addSubview:midFontBtn];
    [fontView addSubview:smallFontBtn];
    
    UIBarButtonItem *fontButtonItem = [[UIBarButtonItem alloc] initWithCustomView:fontView];
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    pageitem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:nil];
    if ([NASaveData getISFastNews]!=1)  {
        self.toolBar.items = [NSArray arrayWithObjects:clipButtonItem,changeItem,spaceButtonItem,spaceButtonItem,spaceButtonItem,fontButtonItem, nil];
    }else{
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIButton  *menubtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menubtn.frame = CGRectMake(0, 0, 60, 49);
        [menubtn setImage:[UIImage imageNamed:@"menu_menu_on"] forState:UIControlStateNormal];
        [menubtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
        menubtn.backgroundColor = [UIColor clearColor];
        UIBarButtonItem *menubar= [[UIBarButtonItem alloc] initWithCustomView:menubtn];
        
        UIButton  *pagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pagebtn.frame = CGRectMake(0, 0, 60, 49);
        [pagebtn setImage:[UIImage imageNamed:@"menu_paper_on"] forState:UIControlStateNormal];
        pagebtn.backgroundColor = [UIColor clearColor];
        [pagebtn addTarget:self action:@selector(showPage:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *pagebar= [[UIBarButtonItem alloc] initWithCustomView:pagebtn];
        
        
        UIButton  *sokuhobtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sokuhobtn.frame = CGRectMake(0, 0, 60, 49);
        [sokuhobtn setImage:[UIImage imageNamed:@"menu_sokuho_off"] forState:UIControlStateNormal];
        sokuhobtn.backgroundColor = [UIColor clearColor];
        UIBarButtonItem *sokuhobar=[[UIBarButtonItem alloc] initWithCustomView:sokuhobtn];
        
        [sokuhobar setTintColor:[UIColor whiteColor]];
        UIButton  *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        settingbtn.frame = CGRectMake(0, 0, 60, 49);
        [settingbtn setImage:[UIImage imageNamed:@"menu_setting_off"] forState:UIControlStateNormal];
        [settingbtn addTarget:self action:@selector(showSetting:) forControlEvents:UIControlEventTouchUpInside];
        settingbtn.backgroundColor = [UIColor clearColor];
        UIBarButtonItem *settingbar= [[UIBarButtonItem alloc] initWithCustomView:settingbtn];
        
        self.toolBar.items=[NSArray arrayWithObjects:menubar,spaceButtonItem,pagebar,spaceButtonItem,sokuhobar,spaceButtonItem,settingbar,nil];
    }
    
    
    _swipeView = [[SwipeView alloc] initWithFrame:CGRectZero];
    _swipeView.dataSource = self;
    _swipeView.delegate = self;
    [self.view addSubview:self.swipeView];
    self.swipeView.hidden = NO;
    
    menuarray=[[NSMutableArray alloc]init];
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    
    
}
/**
 * 設定画面を表示
 *
 */
- (void)toSettingViewContreller
{
    NASettingViewController *setting = [[NASettingViewController alloc] init];
    setting.isfromWhere=@"sukuho";
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:setting];
    
    __block NAGifuMainViewController *_self = self;
    setting.logoutCompletionBlock = ^(BOOL finish){
        if (finish) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeUser" object:nil];
            [_self dismissViewControllerAnimated:YES completion:nil];
            
        }
    };
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
-(void)showSetting:(id)sender{
    [self toSettingViewContreller];
}
-(void)showPage:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)showMenu:(UIButton *)sender
{
    NSArray *menuItems;
    
    menuItems =@[
                 [KxMenuItem menuItem:NSLocalizedString(@"Menu", nil)
                                image:nil
                               target:nil
                               action:NULL],
                 
                 [KxMenuItem menuItem:isClip==YES? @"クリップ削除":@"クリップ"
                                image:nil
                               target:self
                               action:@selector(pushMenuItem:)],
                 
                 [KxMenuItem menuItem:@"字体（大）"
                                image:nil
                               target:self
                               action:@selector(pushMenuItem:)],
                 
                 [KxMenuItem menuItem:@"字体（中）"
                                image:nil
                               target:self
                               action:@selector(pushMenuItem:)],
                 
                 [KxMenuItem menuItem:@"字体（小）"
                                image:nil
                               target:self
                               action:@selector(pushMenuItem:)],
                 
                 
                 [KxMenuItem menuItem:isTateShow==YES? @"横書き":@"縦書き"
                                image:nil
                               target:self
                               action:@selector(pushMenuItem:)],
                 
                 
                 
                 ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(self.toolBar.frame.origin.x, self.toolBar.frame.origin.y, self.toolBar.frame.size.width/4, self.toolBar.frame.size.height)
                 menuItems:menuItems];
}

- (void) pushMenuItem:(id)sender
{
    KxMenuItem *myitem=sender;
    //NSLog(@"%@", myitem.title);
    if ([myitem.title isEqualToString:@"字体（大）"]) {
        bigFontBtn.selected = YES;
        smallFontBtn.selected=NO;
        midFontBtn.selected=NO;
        
        self.fontSize = [NASaveData getSokuhoFontSize:0];
        [NASaveData saveSokuhoFontNum:0];
        
        NAGifuSWView *detailView = (NAGifuSWView *)self.swipeView.currentItemView;
        detailView.myFontSize = self.fontSize;
        [detailView changeFontSize];
    }else if ([myitem.title isEqualToString:@"字体（中）"]){
        bigFontBtn.selected = NO;
        smallFontBtn.selected=NO;
        midFontBtn.selected=YES;
        self.fontSize = [NASaveData getSokuhoFontSize:1];
        [NASaveData saveSokuhoFontNum:1];
        
        NAGifuSWView *detailView = (NAGifuSWView *)self.swipeView.currentItemView;
        detailView.myFontSize = self.fontSize;
        [detailView changeFontSize];
    }else if ([myitem.title isEqualToString:@"字体（小）"]){
        bigFontBtn.selected = NO;
        smallFontBtn.selected=YES;
        midFontBtn.selected=NO;
        self.fontSize = [NASaveData getSokuhoFontSize:2];
        [NASaveData saveSokuhoFontNum:2];
        
        NAGifuSWView *detailView = (NAGifuSWView *)self.swipeView.currentItemView;
        detailView.myFontSize = self.fontSize;
        [detailView changeFontSize];
    }else if ([myitem.title isEqualToString:@"クリップ"]||[myitem.title isEqualToString:@"クリップ削除"]){
        [self clipBtnAction];
    }else if ([myitem.title isEqualToString:@"検索"]){
        [self searchBarItemAction];
    }else if ([myitem.title isEqualToString:@"横書き"]||[myitem.title isEqualToString:@"縦書き"]){
        [self changeBtnAction];
    }
    
    
}
/**
 * 画面初期化時、GenreIdで、速報情報を表示する
 *
 */
- (void)showSokuhoInfoByFirstGenre
{
    NSArray *groupinfos=[[NAFileManager sharedInstance]masterPublisherGroupInfo];
    for (NAPublisherGroupInfo *groupinfo in groupinfos) {
        for (NAPublisherInfo *publisherInfo in groupinfo.publisherInfo) {
            for (NAPublicationInfo *publication in publisherInfo.publicationInfo) {
                NAContent *mycontent= publication.content;
                if (mycontent && [mycontent.contentid isEqualToString:@"S"]) {
                    for (NAGenre *genre in mycontent.genrearray) {
                        NASDoc *sdoc=[[NASDoc alloc]init];
                        
                        sdoc.publisherGroupInfoId=groupinfo.publisherGroupInfoIdentifier;
                        sdoc.publisherInfoId=publisherInfo.publisherInfoIdentifier;
                        sdoc.publicationInfoId=publication.publicationInfoIdentifier;
                        sdoc.editionInfoId=@"S";
                        sdoc.genreid=genre.genreid;
                        sdoc.gname=genre.name;
                        
                        [menuarray addObject:sdoc];
                    }
                }
            }
        }
    }
    
    //速報情報を表示
    if (menuarray.count > 0) {
        NASDoc *sdoc=[menuarray objectAtIndex:0];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTYGetNASDoc object:sdoc];
    }
}

/**
 * メニューhidden
 *
 */
- (void)toggleSideView {
    [[DHSlideMenuController sharedInstance] showLeftViewController:YES];
}

/**
 * メニューに、ジャンルを選択し、速報情報を表示
 *
 */
-(void)getNASDoc:(NSNotification *)noty{
    currentsdoc=[noty object];
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    if (currentsdoc) {
        self.title=currentsdoc.gname;
        mytitle=currentsdoc.gname;
        [self searchNoteAPI];
        [clipBtn setImage:[UIImage imageNamed:GETIMAGENAME(@"btn_tool_clip_off")] forState:UIControlStateNormal];
        isClip=NO;
    }else{
        isClip=YES;
        self.title=NSLocalizedString(@"Grip List", nil);
        mytitle=NSLocalizedString(@"Grip List", nil);
        [self getClipAPI];
        [clipBtn setImage:[UIImage imageNamed:GETIMAGENAME(@"icon_del_off")] forState:UIControlStateNormal];
    }
}

/**
 * 戻る
 *
 */
-(void)backBtnItemAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 更新
 *
 */
-(void)refreshBarItemAction{
    if ([NACheckNetwork sharedInstance].isHavenetwork) {
        [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
        if (currentsdoc) {
            isClip=NO;
            self.title=currentsdoc.gname;
            mytitle=currentsdoc.gname;
            if (self.myserachtext.length>0) {
                [self searchSokuho];
            }else{
                
                [self searchNoteAPI];
                [clipBtn setImage:[UIImage imageNamed:GETIMAGENAME(@"btn_tool_clip_off")] forState:UIControlStateNormal];
                
                BACK(^{
                    if ([NACheckNetwork sharedInstance].isHavenetwork) {
                        [[NADownloadHelper sharedInstance] downloadCurrentSokuho:currentsdoc completionBlock:^(id data, NSError *error) {
                        }];
                    }
                });
            }
            
        }else{
            isClip=YES;
            self.title=NSLocalizedString(@"Grip List", nil);
            mytitle=NSLocalizedString(@"Grip List", nil);
            [self getClipAPI];
            [clipBtn setImage:[UIImage imageNamed:GETIMAGENAME(@"icon_del_off")] forState:UIControlStateNormal];
        }
    } else {
        [[[iToast makeText:NSLocalizedString(@"networkerror", @"")]
          setGravity:iToastGravityBottom] show];
    }
}

/**
 * 検索
 *
 */
- (void)searchBarItemAction
{
    if ([NACheckNetwork sharedInstance].isHavenetwork) {
        NASearchViewController *search = [[NASearchViewController alloc] init];
        search.isfromWhere=TYPE_SOKUHO;
        search.sokuhoCompletion = ^(NSArray *result,NSString *keyword,NSString *fromdate,NSString *todate) {
            _fromdate=fromdate;
            _todate=todate;
            [self.noteArray removeAllObjects];
            [self.noteArray addObjectsFromArray:result];
            self.myserachtext=keyword;
            [self.swipeView reloadData];
            [self swipeViewDidEndDecelerating:self.swipeView];
        };
        ;
        search.currsDoc=self.currentsdoc;
        NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:search];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    } else {
        [[[iToast makeText:NSLocalizedString(@"networkerror", @"")]
          setGravity:iToastGravityBottom] show];
    }
    
}
/**
 * clip追加、削除処理
 *
 */
- (void)clipBtnAction
{
    if (![NACheckNetwork sharedInstance].isHavenetwork) {
        [[[iToast makeText:NSLocalizedString(@"networkerror", @"")]
          setGravity:iToastGravityBottom] show];
        return;
    }
    
    [self clipAPI];
}

/**
 * 横書、縦書を変更
 *
 */
-(void)changeBtnAction{
    NAGifuSWView *detailView = (NAGifuSWView *)self.swipeView.currentItemView;
    if (isTateShow) {
        isTateShow=NO;
        [changeBtn setImage:[UIImage imageNamed:@"btn_tate"] forState:UIControlStateNormal];
    }else{
        isTateShow=YES;
        [changeBtn setImage:[UIImage imageNamed:@"btn_yoko"] forState:UIControlStateNormal];
    }
    
    [NASaveData saveFastNewsTate:[NSNumber numberWithBool:isTateShow]];
    [detailView setShowStyle:isTateShow];
    
}

/**
 * 字体変更
 *
 */
-(void)bigFontBtnAction:(UIButton *)sender{
    sender.selected=YES;
    if ([sender tag]==1) {
        bigFontBtn.selected = YES;
        smallFontBtn.selected=NO;
        midFontBtn.selected=NO;
        
        self.fontSize = [NASaveData getSokuhoFontSize:0];
        [NASaveData saveSokuhoFontNum:0];
        
        
    }else if ([sender tag]==2){
        bigFontBtn.selected = NO;
        smallFontBtn.selected=NO;
        midFontBtn.selected=YES;
        self.fontSize = [NASaveData getSokuhoFontSize:1];
        [NASaveData saveSokuhoFontNum:1];
        
    }else if ([sender tag]==3){
        bigFontBtn.selected = NO;
        smallFontBtn.selected=YES;
        midFontBtn.selected=NO;
        self.fontSize = [NASaveData getSokuhoFontSize:2];
        [NASaveData saveSokuhoFontNum:2];
        
        
    }
    NAGifuSWView *detailView = (NAGifuSWView *)self.swipeView.currentItemView;
    detailView.myFontSize = self.fontSize;
    [detailView changeFontSize];
}

/**
 * view更新
 *
 */
- (void)updateViews
{
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    
    CGFloat navHeight = NAVBAR_HEIGHT;
    CGFloat barHeight = TOOLBAR_HEIGHT;
    self.toolBar.frame = CGRectMake(0, screenHeight - barHeight, screenWidth, barHeight);
    
    self.swipeView.frame = CGRectMake(0, navHeight, screenWidth, screenHeight - navHeight - barHeight-1);
    
}

#pragma mark - swipe delegate -
#pragma mark

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return (unsigned long)self.noteArray.count%5==0 ? self.noteArray.count/5:self.noteArray.count/5+1;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    NAGifuSWView *detailView = (NAGifuSWView *)view;
    
    // view初期化
    if (!detailView) {
        detailView = [[NAGifuSWView alloc] initWithFrame:self.swipeView.bounds];
    }
    detailView.isThefirst=isThefirst;
    if (isThefirst) {
        isThefirst=NO;
    }
    detailView.isTateShow=isTateShow;
    if (self.myserachtext.length>0) {
        detailView.keyword=self.myserachtext;
    }
    
    NSInteger i;
    NSInteger start = index * 5;
    NSInteger end = (index + 1) * 5;
    
    if (self.noteArray.count < end) {
        end = self.noteArray.count;
    }
    
    [detailView.displayNotes removeAllObjects];
    for (i = start; i < end; i++) {
        [detailView.displayNotes addObject:self.noteArray[i]];
    }
    
    detailView.myFontSize = self.fontSize;
    [detailView loadHtml];
    [detailView updateLayout];
    return detailView;
}

- (void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate{
    
}

- (void)swipeViewDidEndDecelerating:(SwipeView *)swipeView{
    //[pageitem setTitle:[NSString stringWithFormat:@"%ld/%lu",(long)self.swipeView.currentItemIndex+1,(unsigned long)self.noteArray.count%5==0 ? self.noteArray.count/5:self.noteArray.count/5+1]];
    
    self.title= [NSString stringWithFormat:@"%@ (%ld/%ld)",mytitle,(long)self.swipeView.currentItemIndex+1,(long)self.noteArray.count%5==0 ? self.noteArray.count/5:self.noteArray.count/5+1];
    
    self.currentIndex=self.swipeView.currentItemIndex;
}
- (void)swipeViewDidEndScrollingAnimation:(SwipeView *)swipeView{
    self.swipeView.hidden = NO;
}

#pragma mark - API -
#pragma mark

/**
 * 速報情報を取得（検索画面から）
 *
 */
- (void)searchSokuho{
    NSString *userId = [NASaveData getDefaultUserID];
    
    
    NSDictionary *searchParam = @{
                                  @"Userid"     :  userId,
                                  @"Rows"       :  [NSString stringWithFormat:@"%0.0ld",(long)[NASaveData getSearchFastNewsRows]],
                                  @"Start"      :  @"0",
                                  @"K002"       :  @"4",
                                  @"Mode"       :  @"1",
                                  @"K004"       :  self.currentsdoc.publisherGroupInfoId,
                                  @"K005"       :  self.currentsdoc.publisherInfoId,
                                  @"K008"       :  @"S",
                                  @"UseDevice"  :  NAUserDevice,
                                  @"K003"       :  [NSString stringWithFormat:@"%@:%@",_fromdate,_todate],
                                  @"Fl"         :  [NSString searchCurrentAtricleFl],
                                  @"Sort"       :  @"K053:desc,K032:desc",
                                  @"Keyword"    :  self.myserachtext,
                                  };
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    
    [[NANetworkClient sharedClient] postSearch:searchParam
                               completionBlock:^(id search, NSError *error) {
                                   if (!error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           [ProgressHUD dismiss];
                                           SHXMLParser *parser = [[SHXMLParser alloc] init];
                                           NSDictionary *dic = [parser parseData:search];
                                           NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                                           
                                           if (searchBaseClass.response.doc.count > 0) {
                                               [self.noteArray removeAllObjects];
                                               [self.noteArray addObjectsFromArray:searchBaseClass.response.doc];
                                               
                                               [self.swipeView reloadData];
                                               [self swipeViewDidEndDecelerating:self.swipeView];
                                               
                                           }else{
                                               [[[iToast makeText:NSLocalizedString(@"Search NO Note", nil)]
                                                 setGravity:iToastGravityBottom] show];
                                           }
                                           
                                       });
                                   }else{
                                       ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
                                   }
                               }];
}



/**
 * 速報情報を取得（メニューから）
 *
 */
- (void)searchNoteAPI
{
    NSString *path = [[NAFileManager sharedInstance] searchSokuhoName:currentsdoc withSokuhoName:SokuhoFileName];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:path isDirectory:FALSE]) {
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        SHXMLParser *parser = [[SHXMLParser alloc] init];
        NSDictionary *dic = [parser parseData:data];
        NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (clipBaseClass.response.doc.count > 0) {
                [self.noteArray removeAllObjects];
                [self.noteArray addObjectsFromArray:clipBaseClass.response.doc];
                
                [self.swipeView reloadData];
                [self swipeViewDidEndDecelerating:self.swipeView];
            }else{
                [[[iToast makeText:NSLocalizedString(@"NO Note", nil)]
                  setGravity:iToastGravityBottom] show];
            }
            
            [ProgressHUD dismiss];
        });
    } else {
        if ([NACheckNetwork sharedInstance].isHavenetwork) {
            [[NADownloadHelper sharedInstance] downloadCurrentSokuho:currentsdoc completionBlock:^(id data, NSError *error) {
                SHXMLParser *parser = [[SHXMLParser alloc] init];
                NSDictionary *dic = [parser parseData:data];
                NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (clipBaseClass.response.doc.count > 0) {
                        [self.noteArray removeAllObjects];
                        [self.noteArray addObjectsFromArray:clipBaseClass.response.doc];
                        
                        [self.swipeView reloadData];
                        [self swipeViewDidEndDecelerating:self.swipeView];
                    }else{
                        [[[iToast makeText:NSLocalizedString(@"NO Note", nil)]
                          setGravity:iToastGravityBottom] show];
                    }
                    
                    [ProgressHUD dismiss];
                });
            }];
        } else {
            [[[iToast makeText:NSLocalizedString(@"NO Note", nil)]
              setGravity:iToastGravityBottom] show];
            
            [ProgressHUD dismiss];
        }
    }
}

/**
 * クリップ情報を取得
 *
 */
- (void)getClipAPI
{
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"Rows"       :  @"999",
                            @"UseDevice"  :  NAUserDevice,
                            @"K002"       :  @"4",
                            @"Mode"       :  @"1",
                            @"Fl"         :  [NSString clipListFl],
                            };
    [[NANetworkClient sharedClient] postFavoritesSearch:param completionBlock:^(id favorites, NSError *error) {
        SHXMLParser *parser = [[SHXMLParser alloc] init];
        NSDictionary *dic = [parser parseData:favorites];
        NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (clipBaseClass.response.doc.count > 0) {
                [self.noteArray removeAllObjects];
                [self.noteArray addObjectsFromArray:clipBaseClass.response.doc];
                
                [self.swipeView reloadData];
                [self swipeViewDidEndDecelerating:self.swipeView];
                
            }else{
                [[[iToast makeText:NSLocalizedString(@"NO Note", nil)]
                  setGravity:iToastGravityBottom] show];
            }
            
            [ProgressHUD dismiss];
        });
    }];
}

/**
 * clip追加、削除処理のAPI
 *
 */
- (void)clipAPI
{
    NAGifuSWView *detailView = (NAGifuSWView *)self.swipeView.currentItemView;
    NSString *selectedNote = [detailView getSelectedNote];
    NSArray* noteIndexNos= [selectedNote componentsSeparatedByString:@","];
    clipArray = [NSMutableArray array];
    
    for (NSString *noteIndexNo in noteIndexNos) {
        if (![noteIndexNo isEqualToString:@""]) {
            for (NAClipDoc *noteDoc in detailView.displayNotes) {
                if ([noteIndexNo isEqualToString:noteDoc.indexNo]) {
                    [clipArray addObject:noteDoc];
                    break;
                }
            }
        }
    }
    
    if (clipArray.count > 0) {
        [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
        if (isClip) {
            [self deleteClip];
        } else {
            [self saveClip];
        }
    } else {
        [[[iToast makeText:NSLocalizedString(@"please seclect note", nil)]
          setGravity:iToastGravityBottom] show];
    }
}
/**
 * クリップ格納
 *
 */
-(void)saveClip{
    NAClipDoc *clipDoc;
    
    if (clipArray.count > 0) {
        clipDoc=[clipArray objectAtIndex:0];
    } else {
        [ProgressHUD dismiss];
        [[[iToast makeText:NSLocalizedString(@"note saved", nil)]
          setGravity:iToastGravityBottom] show];
        return;
    }
    
    // 格納
    NSDictionary *param = @{
                            @"Fl"         :  [NSString addclipListFl],
                            @"Mode"       :  @"1",
                            @"K001"       :  clipDoc.indexNo,
                            @"K002"       :  @"4",
                            @"Rows"       :  @"999",
                            @"Userid"     :  [NASaveData getDefaultUserID],
                            @"UseDevice"  :  @"N05"
                            };
    
    [[NANetworkClient sharedClient] postFavoritesSave:param completionBlock:^(id favorites, NSError *error) {
        SHXMLParser *parser = [[SHXMLParser alloc] init];
        NSDictionary *dic = [parser parseData:favorites];
        NSDictionary *resdic=[dic objectForKey:@"response"];
        NSString *status=[resdic objectForKey:@"status"];
        if (!error) {
            if ([status isEqualToString:@"9"]) {
                ITOAST_BOTTOM(NSLocalizedString(@"MaxSaveNote", nil));
            }else if ([status isEqualToString:@"0"]){
                // GA
                [TAGManagerUtil pushButtonClickEvent:ENClipSaveBtn label:[Util getLabelName:clipDoc]];
                [clipArray removeObjectAtIndex:0];
                [self saveClip];
            }
            
            
        }

    }];
}

/**
 * クリップ削除
 *
 */
-(void)deleteClip{
    NAClipDoc *clipDoc;
    
    if (clipArray.count > 0) {
        clipDoc=[clipArray objectAtIndex:0];
    } else {
        [self getClipAPI];
        [[[iToast makeText:NSLocalizedString(@"note deleted", nil)]
          setGravity:iToastGravityBottom] show];
        return;
    }
    
    // 削除
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getDefaultUserID],
                            @"Rows"       :  @"999",
                            @"UseDevice"  :  NAUserDevice,
                            @"K001"       :  clipDoc.indexNo,
                            @"K002"       :  @"4",
                            @"Mode"       :  @"1",
                            @"Fl"         :  [NSString addclipListFl],
                            };
    [[NANetworkClient sharedClient] postFavoritesDelete:param completionBlock:^(id favorites, NSError *error) {
        if (!error) {
            [TAGManagerUtil pushOpenScreenEvent:ENClipDelBtn ScreenName:[Util getLabelName:clipDoc]];
            [clipArray removeObjectAtIndex:0];
            [self deleteClip];
        }
    }];
}


/**
 * 記事詳細画面を表示
 *
 */
- (void)toNoteDetail:(NSNotification *)notify {
    NSDictionary *dic=[notify userInfo];
    NSString *noteIndexNo=[dic objectForKey:@"noteIndexNo"];
    
    int index;
    for (index = 0; index < self.noteArray.count; index++) {
        NAClipDoc *tempDoc = self.noteArray[index];
        if ([noteIndexNo isEqualToString:tempDoc.indexNo]) {
            break;
        }
    }
    
    NADetailViewController *detail = [[NADetailViewController alloc] init];
    detail.details = self.noteArray;
    detail.currentIndex = index;
    detail.myserachtext = self.myserachtext;
    if (isClip) {
        detail.isfromWhere = TYPE_CLIP;
    } else {
        detail.isfromWhere = TYPE_SOKUHO;
    }
    
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:detail];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
}
@end

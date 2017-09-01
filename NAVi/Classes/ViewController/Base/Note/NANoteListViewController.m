
#import "NANoteListViewController.h"
#import "NAGripTableViewCell.h"
#import "NADetailViewController.h"
#import "NAHomeViewController.h"

@interface NANoteListViewController ()

@property (nonatomic, strong) UITableView *tView;
@property (nonatomic, assign) NAGripTableViewCellDeviceType gripCellType;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) NAGripToolbar *gripToolbar;
@property (nonatomic, strong) NSArray *dataSouce;
@property (nonatomic, strong) NADoc *doc;
@property (nonatomic, strong) NADoc *other;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) NSMutableArray *clipArray;
@property (nonatomic, assign) UIInterfaceOrientation oldFromInterfaceOrientation;
@property (nonatomic, assign) UIInterfaceOrientation oldToInterfaceOrientation;

@end

@implementation NANoteListViewController{
    NSInteger titlelength;
    NSInteger detailtitlelength;
}

- (id)initWithDoc:(NADoc *)aDoc other:(NADoc *)aOther
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.doc = aDoc;
        self.other = aOther;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Article List", nil);
    self.clipArray = [NSMutableArray array];
    NSDictionary *dic=[NAFileManager ChangePlistTodic];
    NSString *titlestrlength=[dic objectForKey:NANewsTitleLengthkey];
    NSString *textstrlength=[dic objectForKey:NANewsTextLengthkey];
    titlelength=[titlestrlength integerValue];
    detailtitlelength=[textstrlength integerValue];
    
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
    
    [self.tView removeFromSuperview];
    _tView = nil;
    _tView = self.tView;
    
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
    
    self.gripCellType = [self deviceType:fromInterfaceOrientation];
    [self.view addSubview:self.tView];
    [self.tView addGestureRecognizer:self.singleTap];
    [self.tView addGestureRecognizer:self.longPressGesture];
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.presentingViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    if ([self isLandscape]) {
        if (self.other) {
            [self.view addSubview:self.segment];
            self.segment.selectedSegmentIndex = 1;
        }
        [self segmentValue:1];
    }else{
        [self.segment removeFromSuperview];
    }
    
}
- (BOOL)isLandscape
{
    return (isPad && [Util screenSize].width>[Util screenSize].height);
}

/**
 * view初期化
 *
 */
- (void)initViews
{
    [super initViews];
    self.navigationItem.leftBarButtonItem = self.backBtnItem;
    self.gripCellType = [self deviceType:self.interfaceOrientation];
    [self.view addSubview:self.gripToolbar];
    [self.view addSubview:self.tView];
    if ([self isLandscape]) {
        
        if (self.other) {
            [self.view addSubview:self.segment];
            self.segment.selectedSegmentIndex = 1;
        }
    }else{
        [self.segment removeFromSuperview];
    }
    [self segmentValue:1];
    [self.tView addGestureRecognizer:self.singleTap];
    [self.tView addGestureRecognizer:self.longPressGesture];
    [self.tView reloadData];
}

/**
 * view更新
 *
 */
- (void)updateViews
{
    [super updateViews];
    CGFloat barHeight = TOOLBAR_HEIGHT;
    self.gripToolbar.frame = CGRectMake(0, self.view.frame.size.height - barHeight, self.view.frame.size.width, barHeight);
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat navHeight = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    if (self.other) {
        self.segment.frame = CGRectMake(screenWidth / 2 - 100, navHeight, 200, 30);
        navHeight = navHeight + 30;
    }
    self.tView.frame = CGRectMake(0, navHeight, screenWidth, screenHeight - navHeight - barHeight);
    
}

- (void)segmentValue:(NSInteger)index
{
    NADoc *aDoc = self.other ? (index == 1 ? self.doc: self.other ) : self.doc;
    self.dataSouce = aDoc.notearray;
    for (NSInteger index=0; index<self.dataSouce.count; index++) {
        NAClipDoc *clipdoc=[self.dataSouce objectAtIndex:index];
        clipdoc.iselecton=@"No";
    }
    
}

/**
 * gripToolbar初期化
 *
 */
- (NAGripToolbar *)gripToolbar
{
    if (!_gripToolbar) {
        _gripToolbar = [[NAGripToolbar alloc] initWithFrame:CGRectZero delegate:self];
        _gripToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return _gripToolbar;
    
}

/**
 * tView初期化
 *
 */
- (UITableView *)tView
{
    if (!_tView) {
        _tView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tView.dataSource = self;
        _tView.delegate = self;
    }
    return _tView;
}

/**
 * segment初期化
 *
 */
- (UISegmentedControl *)segment
{
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:self.other.pageInfoName,self.doc.pageInfoName, nil]];
        [_segment addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
        _segment.frame = CGRectZero;
    }
    return _segment;
}


#pragma mark - button action -
#pragma mark

- (void)collectBtnAction:(id)sender
{
    NALog(@"collectBtnAction");
    
    
    if (self.clipArray.count==0) {
        [[[iToast makeText:NSLocalizedString(@"please seclect note", @"")]
          setGravity:iToastGravityBottom] show];
        return;
    }
    
    
    if ([NACheckNetwork sharedInstance].isHavenetwork) {
        [ProgressHUD show:NSLocalizedString(@"note saving", nil)];
        [self saveClip];
    }else{
        [[[iToast makeText:NSLocalizedString(@"networkerror", @"")]
          setGravity:iToastGravityBottom] show];
        
    }
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
    CGPoint p = [sender locationInView:self.tView];
    
    NSIndexPath *indexPath = [self.tView indexPathForRowAtPoint:p];
    if (indexPath) {
        NAGripTableViewCell *cell = (NAGripTableViewCell *)[self.tView cellForRowAtIndexPath:indexPath];
        if (cell) {
            NADetailViewController *detail = [[NADetailViewController alloc] init];
            detail.currentIndex = indexPath.row;
            detail.details = self.dataSouce;
            detail.isfromWhere=TYPE_NOTE;
            NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:detail];
            [self presentViewController:nav animated:YES completion:^{
                
            }];
                
        }
    }
}

/**
 * longPress event
 *
 */
- (UILongPressGestureRecognizer *)longPressGesture
{
    if (!_longPressGesture) {
        _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];
        _longPressGesture.minimumPressDuration = 0.6f;
    }
    return _longPressGesture;
}

- (void)longPressGestureAction:(UILongPressGestureRecognizer *)sender
{
    CGPoint p = [sender locationInView:self.tView];
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath = [self.tView indexPathForRowAtPoint:p];
        if (indexPath) {
            NAGripTableViewCell *cell = (NAGripTableViewCell *)[self.tView cellForRowAtIndexPath:indexPath];
            if (cell) {
                [cell cellClickStatus:!cell.clipType];
                NADoc *doc = self.dataSouce[indexPath.row];
                if (cell.clipType) {
                    doc.iselecton=@"YES";
                    [self.clipArray addObject:doc];
                }else{
                    [self.clipArray removeObject:doc];
                    doc.iselecton=@"NO";
                }
            }
        }
    }
    [self.tView reloadData];
}

- (void)segmentValueChange:(id)sender
{
    [self segmentValue:self.segment.selectedSegmentIndex];
    [self.tView reloadData];
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
    
    // cell初期化
    NAGripTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NAGripTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellType = self.gripCellType;
    
    // longpress場合、backgroundColorを設定
    NADoc *clipDoc = self.dataSouce[indexPath.row];
    cell.isSelected=clipDoc.iselecton;
    if ([clipDoc.iselecton isEqualToString:@"YES"]) {
        cell.contentView.backgroundColor = [Util colorWithHexString:Lightbulecolor];
        cell.detailLbl.backgroundColor=[Util colorWithHexString:Lightbulecolor];
    }else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.detailLbl.backgroundColor=[UIColor clearColor];
    }

    
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
    if ([clipDoc.newsText isKindOfClass:[NSString class]]) {
        NSString *mydetailtext=clipDoc.newsText;
        if ([CharUtil isHaveRubytext:mydetailtext]) {
            mydetailtext=[CharUtil deledateTheRT:clipDoc.newsText];
        }
        
        NSString *bundleFile = [[NSBundle mainBundle] pathForResource:@"htmlsource" ofType:@"bundle"];
        NSString *filePath = [NSString stringWithFormat:@"%@/listNote.html",bundleFile];
        NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        if (mydetailtext.length>detailtitlelength) {
            mydetailtext=[mydetailtext substringWithRange:NSMakeRange(0,detailtitlelength)];
            mydetailtext=[CharUtil getRightRubytext:clipDoc.newsText NORubytext:mydetailtext];
            cell.detailtext=mydetailtext;
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@myContent@" withString:[NSString stringWithFormat:@"%@...",mydetailtext]];
            [cell.detailLbl loadHTMLString:htmlString baseURL:nil];
        }else{
            cell.detailtext=clipDoc.newsText;
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@myContent@" withString:clipDoc.newsText];
            [cell.detailLbl loadHTMLString:htmlString baseURL:nil];
            
        }
        
    }else{
        cell.detailtext=@"";
        [cell.detailLbl loadHTMLString:@"" baseURL:nil];
    }
    
    cell.dateLbl.text = [NSString stringWithFormat:@"%@  %@  %@  %@",[Util getTheFormatString:clipDoc.publishDate],clipDoc.editionInfoName,clipDoc.pageInfoName,clipDoc.printRevisionInfoName];
    return cell;
}

/**
 * クリップ格納
 *
 */
-(void)saveClip{
    NAClipDoc *clipDoc;
    
    if (self.clipArray.count > 0) {
        clipDoc=[self.clipArray objectAtIndex:0];
    } else {
        [ProgressHUD dismiss];
        [[[iToast makeText:NSLocalizedString(@"note saved", nil)]
          setGravity:iToastGravityBottom] show];
        return;
    }
    
    NSDictionary *param = @{
                            @"Fl"         :  [NSString addclipListFl],
                            @"Mode"       :  @"1",
                            @"K001"       :  clipDoc.indexNo,
                            @"K002"       :  @"4",
                            @"Rows"       :  @"999",
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"UseDevice"  :  @"N05"
                            };
    [[NANetworkClient sharedClient] postFavoritesSave:param completionBlock:^(id favorites, NSError *error) {
        [ProgressHUD dismiss];
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
                [self.clipArray removeObjectAtIndex:0];
                [self saveClip];
            }
            
            
        }
    }];
    
}

- (NAGripTableViewCellDeviceType)deviceType:(UIInterfaceOrientation)orientation
{
    if (isPad) {
        if (UIDeviceOrientationIsPortrait(orientation)) {
            return NAiPadPortrait;
        }else{
            return NAiPadLandscape;
        }
    }else {
        if (UIDeviceOrientationIsPortrait(orientation)) {
            return NAiPhonePortrait;
        }else{
            return NAiPhoneLandscape;
        }
    }
    return NADeviceNone;
}
@end

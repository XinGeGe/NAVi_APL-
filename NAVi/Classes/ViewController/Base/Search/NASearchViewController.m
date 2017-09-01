
#import "NASearchViewController.h"
#import "NASearchResultViewController.h"
#import "NAPickerView.h"
#define DATEFORMAT @"yyyy/MM/dd"
#import "FontUtil.h"
@interface NASearchViewController () <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>{
    NSMutableArray *publicationArray;
    NSMutableArray *publicationinfonameArray;
    
    NSMutableArray *editionArray;
    NSMutableArray *editionnameArray;
    
    NSMutableArray *radioButtoArray;
    NSMutableArray *bgRadioButtoArray;
    NSMutableArray *bgEditionArray;
    
    NSString *fromDatestr;
    NSString *endDatestr;
    NSDate *currentEndDate;
    NSDate *currentFromDate;
    BOOL isSearchOrderNO;
}

@property (nonatomic, strong) UITableView *tView;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UITextField *searchText;
@property (nonatomic, strong) UILabel *searchLabel;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) UIScrollView *backView;
@property (nonatomic, strong) UILabel *storyLabel;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) UIButton *dateButton;
@property (nonatomic, strong) NAPickerView *datePicker;
@property (nonatomic, assign) UIInterfaceOrientation oldFromInterfaceOrientation;
@property (nonatomic, assign) UIInterfaceOrientation oldToInterfaceOrientation;
@property (nonatomic, strong) UIView *searchdateview;
@property (nonatomic, strong) UITextField *fromdateTF;
@property (nonatomic, strong) UITextField *todateTF;
@property (nonatomic, strong) UILabel *fromdatelab;
@property (nonatomic, strong) UILabel *todatelab;

@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) UIView *pageView;
@property (nonatomic, strong) UIView *radioView;
@property (nonatomic, strong) UILabel *endDateLab;
@property (nonatomic, strong) UITextField *endDateTF;

@property (nonatomic, strong) UILabel *editionLab;
@property (nonatomic, strong) UIButton *editionBtn;
@property (nonatomic, strong) UIButton *searchPageBtn;

@property (nonatomic, strong) UILabel *bgEditionLab;
@property (nonatomic, strong) UIView *bgRadioView;

@property (nonatomic, strong) UILabel *bgFromDateLab;
@property (nonatomic, strong) UITextField *bgFromDateTF;
@property (nonatomic, strong) UILabel *bgEndDateLab;
@property (nonatomic, strong) UITextField *bgEndDateTF;
@property (nonatomic, strong) UILabel *searchRangeLab;
@property (nonatomic, strong) UILabel *mediaPVLab;
@property (nonatomic, strong) UIButton *mediaPVBtn;
@property (nonatomic, strong) UILabel *editionPVLab;
@property (nonatomic, strong) UIButton *editionPVBtn;
@property (nonatomic, strong) UILabel *mediaNVLab;
@property (nonatomic, strong) UIButton *mediaNVBtn;
@property (nonatomic, strong) UILabel *editionNVLab;
@property (nonatomic, strong) UIButton *editionNVBtn;
@property (nonatomic, strong) UISegmentedControl *bgRedioSegment;
@property (nonatomic, strong) UIButton *clearFromDateBtn;
@property (nonatomic, strong) UIButton *clearEndDateBtn;
@property (nonatomic, strong) UITextField *searchOrderNoTF;



@end

@implementation NASearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
    [formatter setLocale:locale];
    [formatter setDateFormat:DATEFORMAT];
    NSDateFormatter *strformatter = [[NSDateFormatter alloc] init];
    [strformatter setDateFormat:@"yyyyMMdd"];
    [strformatter setLocale:locale];
    NSDate *mydate=[NSDate date];
    currentEndDate=mydate;
    endDatestr=[strformatter stringFromDate:mydate];
    _endDateTF.text = [formatter stringFromDate:mydate];
    [TAGManagerUtil pushOpenScreenEvent:ENSearchView ScreenName:NSLocalizedString(@"serachpage", nil)];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.presentingViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark - layout -
#pragma mark


- (UITableView *)tView
{
    if (!_tView) {
        _tView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tView.dataSource = self;
        _tView.delegate = self;
        _tView.backgroundColor = [UIColor clearColor];
        _tView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _tView.layer.borderWidth = 1.0f;
    }
    return _tView;
}
- (UIButton *)clearBtn
{
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearBtn.titleLabel.font=[FontUtil systemFontOfSize:12];
        _clearBtn.frame = CGRectMake(0, 0, 80, 45);
        _clearBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _clearBtn.layer.borderWidth = 1.0f;
        _clearBtn.layer.cornerRadius = 5;
        [_clearBtn setTitle:NSLocalizedString(@"search story delete", nil) forState:UIControlStateNormal];
        [_clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
}
/**
 * segment初期化
 *
 */
- (UISegmentedControl *)segment
{
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Paper Search", nil),NSLocalizedString(@"Article Search", nil), nil]];
        [_segment addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
        _segment.frame = CGRectZero;
        [_segment setSelectedSegmentIndex:0];
    }
    return _segment;
}
- (UISegmentedControl *)searchOrderNoSegment
{
    if (!_searchOrderNoSegment) {
        _searchOrderNoSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Publish Day", nil),NSLocalizedString(@"Order NO", nil), nil]];
        [_searchOrderNoSegment addTarget:self action:@selector(searchOrderNoSegmentValueChange:) forControlEvents:UIControlEventValueChanged];
        _searchOrderNoSegment.frame = CGRectZero;
        [_searchOrderNoSegment setSelectedSegmentIndex:0];
    }
    return _searchOrderNoSegment;
}
- (void)searchOrderNoSegmentValueChange:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex==0) {
        isSearchOrderNO=NO;
    }else{
        isSearchOrderNO=YES;
    }
    _searchOrderNoTF.hidden=!isSearchOrderNO;
    _endDateTF.hidden=isSearchOrderNO;
}
- (void)segmentValueChange:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex==0) {
        [self.backView removeFromSuperview];
        [self.view insertSubview:self.pageView belowSubview:self.segment];
        self.isNote=NO;
    }else if (sender.selectedSegmentIndex==1){
        [self.pageView removeFromSuperview];
        [self.view insertSubview:self.backView belowSubview:self.segment];
        self.isNote=YES;
    }
    self.title = self.isNote ? NSLocalizedString(@"Article Search", nil) : NSLocalizedString(@"Paper Search", nil);
}

- (UIButton *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = CGRectMake(0, 0, 80, 45);
        _searchBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _searchBtn.layer.borderWidth = 1.0f;
        _searchBtn.layer.cornerRadius = 5;
        [_searchBtn setTitle:NSLocalizedString(@"Search", nil) forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

- (UILabel *)searchLabel
{
    if (!_searchLabel) {
        _searchLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _searchLabel.backgroundColor = [UIColor clearColor];
        _searchLabel.text = NSLocalizedString(@"Search Comment", nil);
    }
    return _searchLabel;
}
- (UITextField *)searchOrderNoTF
{
    if (!_searchOrderNoTF) {
        _searchOrderNoTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _searchOrderNoTF.delegate = self;
        _searchOrderNoTF.borderStyle = UITextBorderStyleRoundedRect;
        _searchOrderNoTF.placeholder = NSLocalizedString(@"Order NO Placeholder", nil);
        _searchOrderNoTF.hidden=YES;
    }
    return _searchOrderNoTF;
}

- (UITextField *)searchText
{
    if (!_searchText) {
        _searchText = [[UITextField alloc] initWithFrame:CGRectZero];
        _searchText.delegate = self;
        _searchText.borderStyle = UITextBorderStyleRoundedRect;
        _searchText.placeholder = NSLocalizedString(@"Search Placeholder", nil);
        _searchText.returnKeyType=UIReturnKeyDone;
    }
    return _searchText;
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _backView.contentSize = CGSizeMake(0, 568);
        _backView.scrollEnabled = YES;
        _backView.backgroundColor = [UIColor clearColor];
    }
    return _backView;
}

- (UILabel *)storyLabel
{
    if (!_storyLabel) {
        _storyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _storyLabel.backgroundColor = [UIColor clearColor];
        _storyLabel.text = NSLocalizedString(@"Search Result", nil);
    }
    return _storyLabel;
}

- (UIButton *)clearButton
{
    if (!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearButton.frame = CGRectMake(0, 0, 80, 30);
        _clearButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _clearButton.layer.borderWidth = 1.0f;
        _clearButton.layer.cornerRadius = 5;
        [_clearButton setTitle:NSLocalizedString(@"Search", nil) forState:UIControlStateNormal];
        [_clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[_clearButton addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}

- (UIButton *)dateButton
{
    if (!_dateButton) {
        _dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dateButton.frame = CGRectZero;
        [_dateButton addTarget:self action:@selector(datePickerSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dateButton;
}

- (NAPickerView *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[NAPickerView alloc] initWithFrame:CGRectZero];
        __block NASearchViewController *_self = self;
        _datePicker.doneDateBlock = ^(NSDate *date) {
            _self.searchText.text = [NSString dateForSearch:date];
        };
        
    }
    return _datePicker;
}
#pragma mark - button action -
#pragma mark

- (void)searchBtnAction
{
    NALog(@"searchBtnAction");
    [TAGManagerUtil pushButtonClickEvent:ENSerachBtn label:self.searchText.text];
    NSString *result = [[NAFileManager sharedInstance] getSearchResult];
    if (result.length > 0) {
        if ([self.searchResults containsObject:self.searchText.text]) {
            [self searchAPI];
            return;
        }
        result = [result stringByAppendingFormat:@",%@",self.searchText.text];
    }else {
        result = self.searchText.text;
    }
    
    NSData *searchData = [result dataUsingEncoding:NSUTF8StringEncoding];
    [[NAFileManager sharedInstance] saveSearchResult:searchData];
    
    self.searchResults = [self reverseTheArray:[[[NAFileManager sharedInstance] getSearchResult] componentsSeparatedByString:@","]];
    
    [self.tView reloadData];
    [self searchAPI];
}

- (void)clearBtnAction{
    [[NAFileManager sharedInstance] deleteSearchResult];
    [[[iToast makeText:NSLocalizedString(@"delete done", nil)]
      setGravity:iToastGravityBottom] show];
    self.searchResults = [self reverseTheArray:[[[NAFileManager sharedInstance] getSearchResult] componentsSeparatedByString:@","]];
    [self.tView reloadData];
    //Ga
    [TAGManagerUtil pushButtonClickEvent:ENClearSearchHistoryBtn label:ENSerachLab];
}
-(void)searchPageBtnClick{
    [self searchAPI];
}
- (void)redioValueChange:(UISegmentedControl *)sender
{
    self.currDoc.editionInfoId=((NAEditionInfo *)[editionArray objectAtIndex:sender.selectedSegmentIndex]).editionInfoIdentifier;
    self.currDoc.editionInfoName=[editionnameArray objectAtIndex:sender.selectedSegmentIndex];
}
- (void)clearFromDateAction:(UIButton *)sender{
    _bgFromDateTF.text=@"";
    sender.hidden=YES;
}
- (void)clearEndDateAction:(UIButton *)sender{
    _bgEndDateTF.text=@"";
    sender.hidden=YES;
}
-(void)selectedBtnClick:(UIButton *)sender{
    NACheckListView *naexview=[[NACheckListView alloc]init];
    naexview.delegate=self;
    naexview.tag=sender.tag;
    naexview.backgroundColor=[UIColor clearColor];
    
    

    if (sender.tag==101) {
        naexview.checkarray=publicationinfonameArray;
        naexview.seclectindex=[publicationinfonameArray indexOfObject:_mediaPVBtn.titleLabel.text];
    }else if (sender.tag==102){
        NAPublicationInfo *publication=[publicationArray objectAtIndex:[publicationinfonameArray indexOfObject:_mediaPVBtn.titleLabel.text]];
        editionArray=[NSMutableArray arrayWithArray:publication.editionInfo];
        editionnameArray=[[NSMutableArray alloc]init];
        for (NAEditionInfo *editioninfo in publication.editionInfo) {
            if ([NASaveData getIsVisitorModel]) {
                if ([publication.dispOrder3 isEqualToString:@"1"]) {
                    [editionnameArray addObject:editioninfo.name];
                }
            }else{
                [editionnameArray addObject:editioninfo.name];
            }
        }
        naexview.checkarray=editionnameArray;
        naexview.seclectindex=[editionnameArray indexOfObject:_editionPVBtn.titleLabel.text];
    }else if (sender.tag==103){
        naexview.checkarray=publicationinfonameArray;
        naexview.seclectindex=[publicationinfonameArray indexOfObject:_mediaNVBtn.titleLabel.text];
    }else if (sender.tag==104){
        NAPublicationInfo *publication=[publicationArray objectAtIndex:[publicationinfonameArray indexOfObject:_mediaNVBtn.titleLabel.text]];
        editionArray=[NSMutableArray arrayWithArray:publication.editionInfo];
        editionnameArray=[[NSMutableArray alloc]init];
        for (NAEditionInfo *editioninfo in publication.editionInfo) {
            if ([NASaveData getIsVisitorModel]) {
                if ([publication.dispOrder3 isEqualToString:@"1"]) {
                    [editionnameArray addObject:editioninfo.name];
                }
            }else{
                [editionnameArray addObject:editioninfo.name];
            }
        }
        naexview.checkarray=editionnameArray;
        naexview.seclectindex=[publicationinfonameArray indexOfObject:_editionNVBtn.titleLabel.text];
    }
    
    
    [naexview show];
    
}
#pragma mark - NACheckDelegate
-(void)selcetClickName:(NSString *)myname MyView:(UIView *)myView{
    NACheckListView *cview=(NACheckListView *)myView;
    if (myView.tag==101) {
        NAPublicationInfo *publication=[publicationArray objectAtIndex:cview.seclectindex];
        if (![_mediaPVBtn.titleLabel.text isEqualToString:myname]) {
            [_mediaPVBtn setTitle:myname forState:UIControlStateNormal];
            
            editionArray=[NSMutableArray arrayWithArray:publication.editionInfo];
            editionnameArray=[[NSMutableArray alloc]init];
            for (NAEditionInfo *editioninfo in publication.editionInfo) {
                [editionnameArray addObject:editioninfo.name];
            }
            [_editionPVBtn setTitle:[editionnameArray objectAtIndex:0] forState:UIControlStateNormal];
            NAEditionInfo *enditioninfo=[editionArray objectAtIndex:0];
            self.currDoc.editionInfoId=enditioninfo.editionInfoIdentifier;
        }
        self.currDoc.publicationInfoId=publication.publicationInfoIdentifier;
        
    }else if (myView.tag==102){
        [_editionPVBtn setTitle:myname forState:UIControlStateNormal];
        NAEditionInfo *enditioninfo=[editionArray objectAtIndex:cview.seclectindex];
        self.currDoc.editionInfoId=enditioninfo.editionInfoIdentifier;
    }else if (myView.tag==103){
        NAPublicationInfo *publication=[publicationArray objectAtIndex:cview.seclectindex];
        if (![_mediaNVBtn.titleLabel.text isEqualToString:myname]) {
            [_mediaNVBtn setTitle:myname forState:UIControlStateNormal];
            
            editionArray=[NSMutableArray arrayWithArray:publication.editionInfo];
            editionnameArray=[[NSMutableArray alloc]init];
            for (NAEditionInfo *editioninfo in publication.editionInfo) {
                [editionnameArray addObject:editioninfo.name];
            }
            [_editionNVBtn setTitle:[editionnameArray objectAtIndex:0] forState:UIControlStateNormal];
            NAEditionInfo *enditioninfo=[editionArray objectAtIndex:0];
            self.currDoc.editionInfoId=enditioninfo.editionInfoIdentifier;
        }
        self.currDoc.publicationInfoId=publication.publicationInfoIdentifier;
    }else if (myView.tag==104){
        [_editionNVBtn setTitle:myname forState:UIControlStateNormal];
        NAEditionInfo *enditioninfo=[editionArray objectAtIndex:cview.seclectindex];
        self.currDoc.editionInfoId=enditioninfo.editionInfoIdentifier;
    }
}

#pragma mark - utility -
#pragma mark
- (void)getMyArray{
    publicationArray=[[NSMutableArray alloc]init];
    publicationinfonameArray=[[NSMutableArray alloc]init];
    
    
    NSArray *groupinfos=[[NAFileManager sharedInstance]masterPublisherGroupInfo];
    for (NAPublisherGroupInfo *groupinfo in groupinfos) {
        for (NAPublisherInfo *publisherInfo in groupinfo.publisherInfo) {
            for (NAPublicationInfo *publication in publisherInfo.publicationInfo) {
                if ([groupinfo.publisherGroupInfoIdentifier isEqualToString:self.currDoc.publisherGroupInfoId]&&[publisherInfo.publisherInfoIdentifier isEqualToString:self.currDoc.publisherInfoId]) {
                    if ([NASaveData getIsVisitorModel]) {
                        if ([publication.dispOrder3 isEqualToString:@"1"]) {
                            [publicationArray addObject:publication];
                            [publicationinfonameArray addObject:publication.name];
                        }
                    }else{
                        [publicationArray addObject:publication];
                        [publicationinfonameArray addObject:publication.name];
                    }
                    
                }
            }
        }
    }
    
    NAPublicationInfo *publication=[publicationArray objectAtIndex:0];
    editionArray=[NSMutableArray arrayWithArray:publication.editionInfo];
    editionnameArray=[[NSMutableArray alloc]init];
    for (NAEditionInfo *editioninfo in publication.editionInfo) {
         if ([NASaveData getIsVisitorModel]) {
             if ([publication.dispOrder3 isEqualToString:@"1"]) {
                 [editionnameArray addObject:editioninfo.name];
             }
         }else{
             [editionnameArray addObject:editioninfo.name];
         }
    }
}
-(void)checkTheFromAndToDate{
    NSDate *myfromdate;
    NSDate *mytodate;
    NSString *fromDateStr=_bgFromDateTF.text;
    NSString *endDateStr=_bgEndDateTF.text;
    if (![fromDateStr isEqualToString:@""]&&![endDateStr isEqualToString:@""]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:DATEFORMAT];
        myfromdate=[formatter dateFromString:fromDateStr];
        mytodate=[formatter dateFromString:endDateStr];
        if (myfromdate.timeIntervalSince1970>mytodate.timeIntervalSince1970) {
            //            NSString *mystr=[NSString stringWithFormat:@"掲載日は[%@]以降の日付を指定してください",fromDateStr];
            //            ITOAST_BOTTOM(mystr);
            //            return;
            
            if(myfromdate.timeIntervalSince1970>[NSDate date].timeIntervalSince1970){
                _bgFromDateTF.text=_bgEndDateTF.text;
            }else{
                if (isEndDateFirstEntered) {
                    _bgFromDateTF.text=_bgEndDateTF.text;
                }else{
                    _bgEndDateTF.text=_bgFromDateTF.text;
                }
            }
            
            
        }
        
    }
    
}
-(NSString *)getDateStr:(NSString *)fromDateStr EndDateStr:(NSString *)endDateStr{
    NSDate *myfromdate;
    NSDate *mytodate;
    NSString *formDate;
    NSString *toDate;
    if ([fromDateStr isEqualToString:@""]) {
        fromDateStr=@"2000/01/01";
    }
    if ([endDateStr isEqualToString:@""]) {
        endDateStr=@"2099/12/31";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
    [formatter setLocale:locale];
    [formatter setDateFormat:DATEFORMAT];
    myfromdate=[formatter dateFromString:fromDateStr];
    mytodate=[formatter dateFromString:endDateStr];
    [formatter setDateFormat:@"yyyyMMdd"];
    formDate = [formatter stringFromDate:myfromdate];
    toDate = [formatter stringFromDate:mytodate];
    
    
    return [NSString stringWithFormat:@"%@:%@",formDate,toDate];
}

- (NSString*)convertToFullwidth:(NSString*)string
{
    NSMutableString*  mstring = [string mutableCopyWithZone:nil];
    NSString*      result = string;
    if (mstring) {
        if (CFStringTransform ((CFMutableStringRef)mstring, NULL, kCFStringTransformFullwidthHalfwidth, TRUE)) {
            result = mstring;
        }
    }
    
    return result;
}

- (NSString *)whiteSpaceChange:(NSString *)text
{
    NSString *str = text;
    
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    
    NSArray *parts = [str componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    str = [filteredArray componentsJoinedByString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"*"];
    
    return str;
}

-(NSDate*) convertDateFromString:(NSString*)uiDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date=[formatter dateFromString:uiDate];
    return date;
}

- (void)toSearchResultList:(NSArray *)array KeyWord:(NSString *)keyWord
{
    NASearchResultViewController *result = [[NASearchResultViewController alloc] init];
    result.dataSouce = array;
    result.myserachtext=keyWord;
    result.mycurrDoc=self.currDoc;
    NSString *date = [self getDateStr:_bgFromDateTF.text EndDateStr:_bgEndDateTF.text];
    result.serachDate=date;
    
    [ProgressHUD dismiss];
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:result];
    
    [self presentViewController:nav animated:NO completion:^{
        
    }];
}

#pragma mark - initViews -
#pragma mark
- (void)initViews
{
    [super initViews];
    
   
    self.navigationItem.leftBarButtonItem = self.backBtnItem;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initPageView];
   
    
    [self.backView addSubview:self.tView];
    [self.backView addSubview:self.storyLabel];
    [self.backView addSubview:self.clearBtn];
    [self.backView addSubview:self.searchText];
    [self.backView addSubview:self.searchLabel];
    [self.backView addSubview:self.searchBtn];
    
    _bgFromDateLab=[[UILabel alloc]init];
    _bgFromDateLab.textColor=[UIColor blackColor];
    _bgFromDateLab.text=@"From";
    [_backView addSubview:_bgFromDateLab];
    
    _bgFromDateTF=[[UITextField alloc]init];
    _bgFromDateTF.borderStyle=UITextBorderStyleRoundedRect;
    _bgFromDateTF.delegate=self;
    //_bgFromDateTF.clearButtonMode = UITextFieldViewModeAlways;
    if (!isPad) {
        _bgFromDateTF.font=[FontUtil systemFontOfSize:12];
    }
    [_backView addSubview:_bgFromDateTF];
    
    _clearFromDateBtn=[[UIButton alloc]init];
    _clearFromDateBtn.hidden=YES;
    [_clearFromDateBtn setTitle:@"x" forState:UIControlStateNormal];
    [_clearFromDateBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_clearFromDateBtn addTarget:self action:@selector(clearFromDateAction:)  forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_clearFromDateBtn];
    
    _bgEndDateLab=[[UILabel alloc]init];
    _bgEndDateLab.textColor=[UIColor blackColor];
    _bgEndDateLab.text=@"To";
    [_backView addSubview:_bgEndDateLab];
    
    _bgEndDateTF=[[UITextField alloc]init];
    _bgEndDateTF.borderStyle=UITextBorderStyleRoundedRect;
    _bgEndDateTF.delegate=self;
    if (!isPad) {
        _bgEndDateTF.font=[FontUtil systemFontOfSize:12];
    }
    [_backView addSubview:_bgEndDateTF];
    
    _clearEndDateBtn=[[UIButton alloc]init];
    _clearEndDateBtn.hidden=YES;
    [_clearEndDateBtn setTitle:@"x" forState:UIControlStateNormal];
    [_clearEndDateBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_clearEndDateBtn addTarget:self action:@selector(clearEndDateAction:)  forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_clearEndDateBtn];
    
    
    _mediaNVLab=[[UILabel alloc]init];
    _mediaNVLab.text=NSLocalizedString(@"Publication", nil);
    [_backView addSubview:_mediaNVLab];
    
    _mediaNVBtn = [[UIButton alloc] init];
    _mediaNVBtn.tag=103;
   
    [_mediaNVBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_mediaNVBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _mediaNVBtn.layer.masksToBounds=YES;
    _mediaNVBtn.layer.borderColor=[UIColor grayColor].CGColor;
    _mediaNVBtn.layer.cornerRadius = 4;
    _mediaNVBtn.layer.borderWidth=0.5;
    [_backView addSubview:_mediaNVBtn];
    
    _editionNVLab=[[UILabel alloc]init];
    _editionNVLab.text=NSLocalizedString(@"Edition", nil);
    [_backView addSubview:_editionNVLab];
    
    _editionNVBtn = [[UIButton alloc] init];
    _editionNVBtn.tag=104;
   
    [_editionNVBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_editionNVBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _editionNVBtn.layer.masksToBounds=YES;
    _editionNVBtn.layer.borderColor=[UIColor grayColor].CGColor;
    _editionNVBtn.layer.cornerRadius = 4;
    _editionNVBtn.layer.borderWidth=0.5;
    [_backView addSubview:_editionNVBtn];
    
    
    _searchRangeLab=[[UILabel alloc]init];
    _searchRangeLab.text=NSLocalizedString(@"SearchRange", nil);
    [_backView addSubview:_searchRangeLab];
    
    if ([NASaveData getIsShowSearchPage]) {
        self.isNote=NO;
        [self.view addSubview:self.pageView];
        self.segment.selectedSegmentIndex=0;
    }else{
        self.isNote=YES;
        [self.view addSubview:self.backView];
        self.segment.selectedSegmentIndex=1;
    }
     self.title = self.isNote ? NSLocalizedString(@"Article Search", nil) : NSLocalizedString(@"Paper Search", nil);
    [self.view addSubview:self.segment];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    MAIN(^{
        [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    });
    BACK(^{
        [self getMyArray];
        MAIN(^{
            [ProgressHUD dismiss];
            self.currDoc.publicationInfoId=((NAPublicationInfo *)[publicationArray objectAtIndex:0]).publicationInfoIdentifier;
            [_mediaPVBtn setTitle:[publicationinfonameArray objectAtIndex:0] forState:UIControlStateNormal];
            
            self.currDoc.editionInfoId=((NAEditionInfo *)[editionArray objectAtIndex:0]).editionInfoIdentifier;
            [_editionPVBtn setTitle:[editionnameArray objectAtIndex:0] forState:UIControlStateNormal];
            
            self.currDoc.publicationInfoId=((NAPublicationInfo *)[publicationArray objectAtIndex:0]).publicationInfoIdentifier;
            [_mediaNVBtn setTitle:[publicationinfonameArray objectAtIndex:0] forState:UIControlStateNormal];
            
            self.currDoc.editionInfoId=((NAEditionInfo *)[editionArray objectAtIndex:0]).editionInfoIdentifier;
            [_editionNVBtn setTitle:[editionnameArray objectAtIndex:0] forState:UIControlStateNormal];
            
        });
    });
    
    self.searchResults = [self reverseTheArray:[[[NAFileManager sharedInstance] getSearchResult] componentsSeparatedByString:@","]];
    [self.tView reloadData];
    
}
-(void)searchdateView{
    _searchdateview=[[UIView alloc]init];
    _searchdateview.backgroundColor=[UIColor clearColor];
    
    _fromdatelab=[[UILabel alloc]init];
    _fromdatelab.text=NSLocalizedString(@"From Day", nil);
    [_searchdateview addSubview:_fromdatelab];
    
    _fromdateTF=[[UITextField alloc]init];
    _fromdateTF.borderStyle=UITextBorderStyleRoundedRect;
    _fromdateTF.delegate=self;
    [_searchdateview addSubview:_fromdateTF];
    
    _todatelab=[[UILabel alloc]init];
    _todatelab.text=NSLocalizedString(@"To Day", nil);
    [_searchdateview addSubview:_todatelab];
    
    _todateTF=[[UITextField alloc]init];
    _todateTF.borderStyle=UITextBorderStyleRoundedRect;
    _todateTF.delegate=self;
    [_searchdateview addSubview:_todateTF];
    
    [self.backView addSubview:_searchdateview];
}
- (void)initPageView
{
    _pageView = [[UIView alloc] initWithFrame:CGRectZero];
    _pageView.backgroundColor = [UIColor clearColor];

    
    _endDateLab=[[UILabel alloc]init];
    _endDateLab.text=NSLocalizedString(@"Page Day", nil);
    //[_pageView addSubview:_endDateLab];
    
    if ([NASaveData getIsHaveSearchOrderNO]) {
        [_pageView addSubview:self.searchOrderNoSegment];
    }
    
    _endDateTF=[[UITextField alloc]init];
    _endDateTF.borderStyle=UITextBorderStyleRoundedRect;
    //_endDateTF.clearButtonMode = UITextFieldViewModeAlways;
    _endDateTF.delegate=self;
    [_pageView addSubview:_endDateTF];
    
    [_pageView addSubview:self.searchOrderNoTF];
    
    
    _mediaPVLab=[[UILabel alloc]init];
    _mediaPVLab.text=NSLocalizedString(@"Publication", nil);
    [_pageView addSubview:_mediaPVLab];
    
    
    _mediaPVBtn = [[UIButton alloc] init];
    _mediaPVBtn.tag=101;
    
    [_mediaPVBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_mediaPVBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _mediaPVBtn.layer.masksToBounds=YES;
    _mediaPVBtn.layer.borderColor=[UIColor grayColor].CGColor;
    _mediaPVBtn.layer.cornerRadius = 4;
    _mediaPVBtn.layer.borderWidth=0.5;

    [_pageView addSubview:_mediaPVBtn];
    
    
    _editionPVLab=[[UILabel alloc]init];
    _editionPVLab.text=NSLocalizedString(@"Edition", nil);
    [_pageView addSubview:_editionPVLab];
    
    
    _editionPVBtn = [[UIButton alloc] init];
    _editionPVBtn.tag=102;
    
    [_editionPVBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_editionPVBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _editionPVBtn.layer.masksToBounds=YES;
    _editionPVBtn.layer.borderColor=[UIColor grayColor].CGColor;
    _editionPVBtn.layer.cornerRadius = 4;
    _editionPVBtn.layer.borderWidth=0.5;
    
    [_pageView addSubview:_editionPVBtn];
    
    _searchPageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_searchPageBtn setTitle:NSLocalizedString(@"Search", nil) forState:UIControlStateNormal];
    [_searchPageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_searchPageBtn addTarget:self action:@selector(searchPageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _searchPageBtn.layer.masksToBounds=YES;
    _searchPageBtn.layer.borderColor=[UIColor grayColor].CGColor;
    _searchPageBtn.layer.cornerRadius = 4;
    _searchPageBtn.layer.borderWidth=0.5;
    [_pageView addSubview:_searchPageBtn];
    
    

    
}

- (void)updateViews
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat navBarHeight = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    self.segment.frame = CGRectMake((width-200)/2, navBarHeight+10, 200, 30);
    // self.segment.center=CGPointMake(width/2, 20);
    if (isPad) {
        CGRect frame = CGRectZero;
        frame.origin.x = (width - 500) / 2;
        frame.origin.y = navBarHeight+10;
        frame.size.width = 500;
        frame.size.height = height - navBarHeight-100;
        self.backView.frame = frame;
        
        
        self.searchLabel.frame = CGRectMake(0, 30, self.backView.frame.size.width, 30);
        self.searchText.frame = CGRectMake(0, CGRectGetMaxY(self.searchLabel.frame), self.backView.frame.size.width - 90, 30);
        self.searchBtn.frame = CGRectMake(CGRectGetMaxX(self.searchText.frame)+ 20,
                                          CGRectGetMaxY(self.searchLabel.frame),
                                          70, 30);
        _mediaNVLab.frame =CGRectMake(0,CGRectGetMaxY(self.searchText.frame)+ 10 , self.backView.frame.size.width ,30);
        self.mediaNVBtn.frame=CGRectMake(0,CGRectGetMaxY(self.mediaNVLab.frame)+ 10 , self.backView.frame.size.width , 30);
        _editionNVLab.frame =CGRectMake(0,CGRectGetMaxY(self.mediaNVBtn.frame)+ 10 , self.backView.frame.size.width ,30);
        self.editionNVBtn.frame=CGRectMake(0,CGRectGetMaxY(self.editionNVLab.frame)+ 10 , self.backView.frame.size.width , 30);
        
        self.searchRangeLab.frame=CGRectMake(0, CGRectGetMaxY(self.editionNVBtn.frame)+ 5, (self.backView.frame.size.width-30)/2, 30);
        self.bgFromDateLab.frame=CGRectMake(0, CGRectGetMaxY(self.searchRangeLab.frame), (self.backView.frame.size.width-30)/2, 30);
        self.bgFromDateTF.frame=CGRectMake(10,CGRectGetMaxY(self.bgFromDateLab.frame)+ 5 , (self.backView.frame.size.width-30)/2 , 30);
        self.clearFromDateBtn.frame=CGRectMake((self.backView.frame.size.width-30)/2-20,CGRectGetMaxY(self.bgFromDateLab.frame)+ 5 , 30 , 30);
        self.bgEndDateLab.frame=CGRectMake(self.backView.frame.size.width/2+15, CGRectGetMaxY(self.searchRangeLab.frame), (self.backView.frame.size.width-30)/2, 30);
        self.bgEndDateTF.frame=CGRectMake(self.backView.frame.size.width/2+15,CGRectGetMaxY(self.bgEndDateLab.frame)+ 5 , (self.backView.frame.size.width-30)/2 , 30);
        self.clearEndDateBtn.frame=CGRectMake(self.backView.frame.size.width/2+15+(self.backView.frame.size.width-30)/2-30,CGRectGetMaxY(self.bgEndDateLab.frame)+ 5 , 30 , 30);
        self.storyLabel.frame = CGRectMake(20, CGRectGetMaxY(self.bgEndDateTF.frame)+ 10, 100, 30);
        self.clearBtn.frame  = CGRectMake(CGRectGetMaxX(self.searchBtn.frame) - 80, CGRectGetMaxY(self.bgEndDateTF.frame)+ 10, 80, 30);
        
        self.tView.frame = CGRectMake(20,
                                      CGRectGetMaxY(self.storyLabel.frame) + 10,
                                      self.backView.frame.size.width - 40,
                                      self.backView.frame.size.height - (CGRectGetMaxY(self.storyLabel.frame) + 10) - 30);
        
        self.pageView.frame=frame;
        CGFloat orginy;
        
        self.searchOrderNoSegment.frame=CGRectMake((frame.size.width-200)/2, 60, 200, 30);
        orginy=CGRectGetMaxY(self.searchOrderNoSegment.frame);
        self.endDateTF.frame=CGRectMake(0,orginy+10 , self.pageView.frame.size.width-90 , 30);
        self.searchOrderNoTF.frame=CGRectMake(0,orginy+10 , self.pageView.frame.size.width-90 , 30);
        self.searchPageBtn.frame=CGRectMake(CGRectGetMaxX(self.searchText.frame)+ 20,orginy + 10, 70 , 30);
        orginy=CGRectGetMaxY(self.endDateTF.frame);
        
        self.mediaPVLab.frame=CGRectMake(0, orginy+60 , self.pageView.frame.size.width , 30);
        orginy=CGRectGetMaxY(self.mediaPVLab.frame);
        self.mediaPVBtn.frame=CGRectMake(0,orginy+10 , self.pageView.frame.size.width , 30);
        orginy=CGRectGetMaxY(self.mediaPVBtn.frame);
        self.editionPVLab.frame=CGRectMake(0, orginy+10, self.pageView.frame.size.width , 30);
        orginy=CGRectGetMaxY(self.editionPVLab.frame);
        self.editionPVBtn.frame=CGRectMake(0, orginy+10, self.pageView.frame.size.width , 30);
        
        
        
    }else{
        CGRect frame = CGRectZero;
        frame.origin.x = 0;
        frame.origin.y = navBarHeight+10;
        frame.size.width = width;
        frame.size.height = height - navBarHeight;
        self.backView.frame = frame;
        
        
        self.searchLabel.frame = CGRectMake(20, 30, self.backView.frame.size.width, 30);
        self.searchText.frame = CGRectMake(10, CGRectGetMaxY(self.searchLabel.frame), self.backView.frame.size.width - 100, 30);
        self.searchBtn.frame = CGRectMake(CGRectGetMaxX(self.searchText.frame)+10,
                                          CGRectGetMaxY(self.searchLabel.frame),
                                          70, 30);
        _mediaNVLab.frame =CGRectMake(20,CGRectGetMaxY(self.searchText.frame)+ 10 , self.backView.frame.size.width ,30);
        self.mediaNVBtn.frame=CGRectMake(5,CGRectGetMaxY(self.mediaNVLab.frame)+ 10 , self.backView.frame.size.width-10 , 30);
        _editionNVLab.frame =CGRectMake(20,CGRectGetMaxY(self.mediaNVBtn.frame)+ 10 , self.backView.frame.size.width ,30);
        self.editionNVBtn.frame=CGRectMake(5,CGRectGetMaxY(self.editionNVLab.frame)+ 10 , self.backView.frame.size.width-10 , 30);
        
        self.searchRangeLab.frame=CGRectMake(20, CGRectGetMaxY(self.editionNVBtn.frame)+ 5, (self.backView.frame.size.width-30)/2, 30);
        self.bgFromDateLab.frame=CGRectMake(20, CGRectGetMaxY(self.searchRangeLab.frame), (self.backView.frame.size.width-30)/2, 30);
        self.bgFromDateTF.frame=CGRectMake(10,CGRectGetMaxY(self.bgFromDateLab.frame)+ 5 , (self.backView.frame.size.width-30)/2 , 30);
        self.clearFromDateBtn.frame=CGRectMake((self.backView.frame.size.width-30)/2-20,CGRectGetMaxY(self.bgFromDateLab.frame)+ 5 , 30 , 30);
        self.bgEndDateLab.frame=CGRectMake(self.backView.frame.size.width/2+15, CGRectGetMaxY(self.searchRangeLab.frame), (self.backView.frame.size.width-30)/2, 30);
        self.bgEndDateTF.frame=CGRectMake(self.backView.frame.size.width/2+10,CGRectGetMaxY(self.bgEndDateLab.frame)+ 5 , (self.backView.frame.size.width-30)/2 , 30);
        self.clearEndDateBtn.frame=CGRectMake(self.backView.frame.size.width/2+10+(self.backView.frame.size.width-30)/2-30,CGRectGetMaxY(self.bgEndDateLab.frame)+ 5 , 30 , 30);
        self.storyLabel.frame = CGRectMake(20, CGRectGetMaxY(self.bgEndDateTF.frame)+ 10, 100, 30);
        self.clearBtn.frame  = CGRectMake(CGRectGetMaxX(self.backView.frame) - 90,CGRectGetMaxY(self.bgEndDateTF.frame)+ 10, 80, 30);
        self.tView.frame = CGRectMake(20,
                                      CGRectGetMaxY(self.storyLabel.frame)+ 10,
                                      self.backView.frame.size.width - 40,
                                      self.backView.contentSize.height - (CGRectGetMaxY(self.storyLabel.frame) + 10) - 30);
        
        
        CGRect pframe = CGRectZero;
        pframe.origin.x = 0;
        pframe.origin.y = navBarHeight+10;
        pframe.size.width = width;
        pframe.size.height = height - navBarHeight;
        self.pageView.frame=pframe;
        CGFloat orginy = 0;
        self.searchOrderNoSegment.frame=CGRectMake((pframe.size.width-200)/2, orginy+40, 200, 30);
        orginy=CGRectGetMaxY(self.searchOrderNoSegment.frame);
        self.endDateTF.frame=CGRectMake(5,orginy + 10, self.pageView.frame.size.width-90 , 30);
        self.searchOrderNoTF.frame=CGRectMake(5,orginy + 10, self.pageView.frame.size.width-90 , 30);
        self.searchPageBtn.frame=CGRectMake(CGRectGetMaxX(self.searchText.frame)+ 15,orginy + 10, 70 , 30);
        orginy=CGRectGetMaxY(self.endDateTF.frame);
    
        self.mediaPVLab.frame=CGRectMake(10, orginy+10, self.pageView.frame.size.width-10 , 30);
        orginy=CGRectGetMaxY(self.mediaPVLab.frame);
        self.mediaPVBtn.frame=CGRectMake(5,orginy+10, self.pageView.frame.size.width-10 , 30);
        orginy=CGRectGetMaxY(self.mediaPVBtn.frame);
        self.editionPVLab.frame=CGRectMake(10, orginy+10, self.pageView.frame.size.width-10 , 30);
        orginy=CGRectGetMaxY(self.editionPVLab.frame);
        self.editionPVBtn.frame=CGRectMake(5, orginy+10, self.pageView.frame.size.width-10 , 30);
        
    }
    
    
}

#pragma mark - UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField != _searchText && textField != _searchOrderNoTF ) {
        
        [textField resignFirstResponder];
        RMActionControllerStyle style = RMActionControllerStyleWhite;
        
        RMAction *selectAction = [RMAction actionWithTitle:NSLocalizedString(@"Decision", nil) style:RMActionStyleDone andHandler:^(RMActionController *controller) {
            //NSLog(@"Successfully selected date: %@", ((UIDatePicker *)controller.contentView).date);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:DATEFORMAT];
            NSDateFormatter *strformatter = [[NSDateFormatter alloc] init];
            [strformatter setDateFormat:@"yyyyMMdd"];
            
            
            NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
            [formatter setLocale:locale];
            [strformatter setLocale:locale];
            if (textField==_endDateTF) {
                currentEndDate=((UIDatePicker *)controller.contentView).date;
                endDatestr=[strformatter stringFromDate:((UIDatePicker *)controller.contentView).date];
            }
            if (_bgEndDateTF.text.length>0&&_bgFromDateTF.text.length==0) {
                isEndDateFirstEntered=YES;
            }else{
                isEndDateFirstEntered=NO;
            }
            textField.text = [formatter stringFromDate:((UIDatePicker *)controller.contentView).date];
            
            [self checkTheFromAndToDate];
            
            if (textField.text.length>0) {
                if (textField==_bgFromDateTF) {
                    _clearFromDateBtn.hidden=NO;
                }else if (textField==_bgEndDateTF){
                    _clearEndDateBtn.hidden=NO;
                }
                
            }
        }];
        
        RMAction *cancelAction = [RMAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
            NSLog(@"Date selection was canceled");
        }];
        
        RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:style];
        //dateSelectionController.title = @"Test";
        //dateSelectionController.message = @"This is a test message.\nPlease choose a date and press 'Select' or 'Cancel'.";
        
        [dateSelectionController addAction:selectAction];
        [dateSelectionController addAction:cancelAction];
        
        
        
        
        
        //You can enable or disable blur, bouncing and motion effects
        dateSelectionController.disableBouncingEffects = YES;
        dateSelectionController.disableMotionEffects = YES;
        dateSelectionController.disableBlurEffects = YES;
        
        //You can access the actual UIDatePicker via the datePicker property
        dateSelectionController.datePicker.datePickerMode = UIDatePickerModeDate;
        dateSelectionController.datePicker.minuteInterval = 5;
       
        if (textField.text.length==0) {
            dateSelectionController.datePicker.date=[NSDate date];
        }else{
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
            [formatter setLocale:locale];
            [formatter setDateFormat:DATEFORMAT];
            NSDate *date=[formatter dateFromString:textField.text];
            dateSelectionController.datePicker.date= date;
        }
        
        
        //On the iPad we want to show the date selection view controller within a popover. Fortunately, we can use iOS 8 API for this! :)
        //(Of course only if we are running on iOS 8 or later)
        if([dateSelectionController respondsToSelector:@selector(popoverPresentationController)] && [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            //First we set the modal presentation style to the popover style
            dateSelectionController.modalPresentationStyle = UIModalPresentationPopover;
            
            //Then we tell the popover presentation controller, where the popover should appear
            dateSelectionController.popoverPresentationController.sourceView = textField.superview;
            dateSelectionController.popoverPresentationController.sourceRect = textField.frame;
        }
        
        //Now just present the date selection controller using the standard iOS presentation method
        [self presentViewController:dateSelectionController animated:YES completion:nil];
        return NO;
    }else{
        return YES;
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
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.searchResults[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *search = self.searchResults[indexPath.row];
    self.searchText.text = search;
    [self searchBtnAction];
}


-(NSArray *)reverseTheArray:(NSArray *)myarray{
    NSMutableArray *array = [NSMutableArray arrayWithArray:myarray];
    NSArray *reversedArray = [[array reverseObjectEnumerator] allObjects];
    return reversedArray;
}

- (void)datePickerSelect
{
    NSDate *date = nil;
    if (![self.searchText.text isEqualToString:@""] && self.searchText.text == nil) {
        date = [self convertDateFromString:self.searchText.text];
    }
    [self.datePicker showPickerView:date];
}

#pragma mark - API -
#pragma mark


- (void)searchAPI
{
    [self.searchText resignFirstResponder];
    if ([self.isfromWhere isEqualToString:TYPE_SOKUHO]) {
        [self searchSokuho];
        return;
    }
    if (self.isNote) {
        [self searchNoteAPI];
    }else{
        if (isSearchOrderNO) {
            [self searchOrderNo];
        }else{
            [self searchPageAPI];
        }
    }
}
- (void)searchSokuho{
    NSString *userId = [NASaveData getLoginUserId];
    
    NSString *formDate = _fromdateTF.text;
    NSString *toDate = _todateTF.text;
    NSDate *myfromdate;
    NSDate *mytodate;
    
    if (formDate.length==0&toDate.length==0) {
        if ([self.isfromWhere isEqualToString:TYPE_SOKUHO]) {
            ITOAST_BOTTOM(@"速報検索時は、掲載日を指定してください!");
            return;
        }
    }
    
    
    if ([formDate isEqualToString:@""]) {
        formDate=@"2000年01月01日";
    }
    if ([toDate isEqualToString:@""]) {
        toDate=@"2099年12月31日";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    myfromdate=[formatter dateFromString:formDate];
    mytodate=[formatter dateFromString:toDate];
    [formatter setDateFormat:@"yyyyMMdd"];
    formDate = [formatter stringFromDate:myfromdate];
    toDate = [formatter stringFromDate:mytodate];
    
    if (myfromdate.timeIntervalSince1970>mytodate.timeIntervalSince1970) {
        NSString *mystr=[NSString stringWithFormat:@"掲載日は[%@]以降の日付を指定してください",_fromdateTF.text];
        ITOAST_BOTTOM(mystr);
        return;
    }
   
    
    NSString *datestr=[NSString stringWithFormat:@"%@:%@",formDate,toDate];
   
    NSDictionary *searchParam = @{
                                  @"Userid"     :  userId,
                                  @"Rows"       :  [NSString stringWithFormat:@"%0.0ld",(long)[NASaveData getSearchFastNewsRows]],
                                  @"Start"      :  @"0",
                                  @"K002"       :  @"4",
                                  @"Mode"       :  @"1",
                                  @"K004"       :  self.currsDoc.publisherGroupInfoId,
                                  @"K005"       :  self.currsDoc.publisherInfoId,
                                  @"K008"       :  @"S",
                                  @"UseDevice"  :  NAUserDevice,
                                  @"K003"       :  datestr,
                                  @"Fl"         :  [NSString searchCurrentAtricleFl],
                                  @"Sort"       :  @"K053:desc,K032:desc",
                                  @"Keyword"    :  _searchText.text,
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
                                               [self dismissViewControllerAnimated:YES completion:^{
                                                   if (self.sokuhoCompletion) {
                                                       self.sokuhoCompletion (searchBaseClass.response.doc,_searchText.text,formDate,toDate);
                                                   }
                                               }];
                                           }else{
                                               [[[iToast makeText:NSLocalizedString(@"NO Note", nil)]
                                                 setGravity:iToastGravityBottom] show];
                                           }
                                           
                                       });
                                   }else{
                                       ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
                                   }
                               }];
}
- (void)searchPageAPI
{
    NSString *userId = [NASaveData getLoginUserId];
    NSString *date = [NSString stringWithFormat:@"%@:%@",endDatestr,endDatestr];
    
    NSDictionary *searchParam = @{
                                  @"Userid"     :  userId,
                                  @"Rows"       :  @"1",
                                  @"K002"       :  @"2",
                                  @"Mode"       :  @"1",
                                  @"K004"       :  self.currDoc.publisherGroupInfoId,
                                  @"K005"       :  self.currDoc.publisherInfoId,
                                  @"K006"       :  self.currDoc.publicationInfoId,
                                  @"K008"       :  self.currDoc.editionInfoId,
                                  @"K014"       :  @"1",
                                  @"UseDevice"  :  NAUserDevice,
                                  @"K003"       :  date,
                                  @"Fl"         :  [NSString searchWithPublicationInfoId],
                                  @"Sort"       :  @"K006:asc,K090:asc,K012:asc",
                                  
                                  };
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    
    [[NANetworkClient sharedClient] postSearch:searchParam
                               completionBlock:^(id search, NSError *error) {
                                   [ProgressHUD dismiss];
                                   if (!error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           SHXMLParser *parser = [[SHXMLParser alloc] init];
                                           NSDictionary *dic = [parser parseData:search];
                                           NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                                           
                                           if (searchBaseClass.response.doc.count > 0) {
                                               [self dismissViewControllerAnimated:YES completion:^{
                                                   if (self.resultCompletion) {
                                                       self.resultCompletion (searchBaseClass.response.doc);
                                                   }
                                               }];
                                           }else{
                                               [UIAlertView showNormalAlert:NSLocalizedString(@"Zero Search", nil)];
                                           }
                                           
                                       });
                                   }else{
                                       ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
                                   }
                                   
                               }];
}

- (void)searchOrderNo
{
    NSString *userId = [NASaveData getLoginUserId];
   // NSString *date = [NSString stringWithFormat:@"%@:%@",self.searchText.text,self.searchText.text];
    
 //   NSString *searchStr = [self whiteSpaceChange:self.searchOrderNoTF.text];
//    NSString *search = [self convertToFullwidth:searchStr];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyyMMdd"];
    NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
    [formatter setLocale:locale];
    NSString *nowDate = [formatter stringFromDate:[NSDate date]];
    NSString *date = [NSString stringWithFormat:@"20000101:%@",nowDate];
    
    NSDictionary *searchParam = @{
                                  @"Userid"     :  userId,
                                  @"Rows"       :  @"1",
                                  @"K002"       :  @"2",
                                  @"Mode"       :  @"1",
                                  @"K003"       :  [NSString stringWithFormat:@"20000101:%@",nowDate],
                                  @"K004"       :  self.currDoc.publisherGroupInfoId,
                                  @"K005"       :  self.currDoc.publisherInfoId,
                                  @"K006"       :  self.currDoc.publicationInfoId,
                                  @"K008"       :  self.currDoc.editionInfoId,
                                  @"K080"       :  self.searchOrderNoTF.text,
                                  @"K014"       :  @"1",
                                  @"UseDevice"  :  NAUserDevice,
                                  @"K003"       :  date,
                                  @"Fl"         :  [NSString searchWithPublicationInfoId],
                                  @"Sort"       :  @"K006:asc,K090:asc,K012:asc,K003:asc",
                                  
                                  };
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    
    [[NANetworkClient sharedClient] postSearch:searchParam
                               completionBlock:^(id search, NSError *error) {
                                   [ProgressHUD dismiss];
                                   if (!error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           SHXMLParser *parser = [[SHXMLParser alloc] init];
                                           NSDictionary *dic = [parser parseData:search];
                                           NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                                               if (searchBaseClass.response.doc.count > 0) {
                                                   [self dismissViewControllerAnimated:YES completion:^{
                                                       if (self.resultCompletion) {
                                                           self.resultCompletion (searchBaseClass.response.doc);
                                                       }
                                                   }];
                                               }else{
                                                   [UIAlertView showNormalAlert:NSLocalizedString(@"Zero Search", nil)];
                                               }
                                               
                                           
                                       });
                                   }else{
                                       ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
                                   }
                                   
                               }];
}


- (void)searchNoteAPI
{
    
    NSDate *myfromdate;
    NSDate *mytodate;
    NSString *fromDateStr=_bgFromDateTF.text;
    NSString *endDateStr=_bgEndDateTF.text;
    NSString *date = [self getDateStr:_bgFromDateTF.text EndDateStr:_bgEndDateTF.text];
    if (![fromDateStr isEqualToString:@""]&&![endDateStr isEqualToString:@""]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:DATEFORMAT];
        myfromdate=[formatter dateFromString:fromDateStr];
        mytodate=[formatter dateFromString:endDateStr];
        if (myfromdate.timeIntervalSince1970>mytodate.timeIntervalSince1970) {
            //            NSString *mystr=[NSString stringWithFormat:@"掲載日は[%@]以降の日付を指定してください",fromDateStr];
            //            ITOAST_BOTTOM(mystr);
            //            return;
            
            if(myfromdate.timeIntervalSince1970>[NSDate date].timeIntervalSince1970){
                date = [self getDateStr:_bgEndDateTF.text EndDateStr:_bgEndDateTF.text];
                _bgFromDateTF.text=_bgEndDateTF.text;
            }else{
                if (isEndDateFirstEntered) {
                    date = [self getDateStr:_bgEndDateTF.text EndDateStr:_bgEndDateTF.text];
                    _bgFromDateTF.text=_bgEndDateTF.text;
                }else{
                    date = [self getDateStr:_bgFromDateTF.text EndDateStr:_bgFromDateTF.text];
                    _bgEndDateTF.text=_bgFromDateTF.text;
                }
            }
            
            
        }
        
    }
    
    
    
    NSString *searchStr = [self whiteSpaceChange:self.searchText.text];
    NSString *search = [self convertToFullwidth:searchStr];
    NSString *userId = [NASaveData getLoginUserId];
    
    NSDictionary *searchParam = @{
                                  @"Userid"     :  userId,
                                  @"Rows"       :  @"15",
                                  @"K002"       :  @"4",
                                  @"Mode"       :  @"1",
                                  @"K003"       :  date,
                                  @"K004"       :  self.currDoc.publisherGroupInfoId,
                                  @"K005"       :  self.currDoc.publisherInfoId,
                                  @"K006"       :  self.currDoc.publicationInfoId,
                                  @"K008"       :  self.currDoc.editionInfoId,
                                  @"UseDevice"  :  NAUserDevice,
                                  @"Keyword"    :  search,
                                  @"Fl"         :  [NSString searchCurrentAtricleFl],
                                  @"Sort"       :  @"K053:desc,K032:desc",
                                  
                                  };
    
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    
    [[NANetworkClient sharedClient] postSearch:searchParam
                               completionBlock:^(id search, NSError *error) {
                                   
                                   if (!error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           
                                           SHXMLParser *parser = [[SHXMLParser alloc] init];
                                           NSDictionary *dic = [parser parseData:search];
                                           NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                                           
                                               if (searchBaseClass.response.doc.count > 0) {
                                                   [self toSearchResultList:searchBaseClass.response.doc KeyWord:searchStr];
                                               }else{
                                                   [ProgressHUD dismiss];
                                                   [[[iToast makeText:NSLocalizedString(@"NO Note", nil)]
                                                     setGravity:iToastGravityBottom] show];
                                               }
                                           
                                       });
                                   }else{
                                       MAIN(^{
                                           [ProgressHUD dismiss];
                                           ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
                                       });
                                       
                                   }
                                   
                                   
                               }];
    
}

@end

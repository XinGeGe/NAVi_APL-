//
//  NANewDayJournalViewController.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/17.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NANewDayJournalViewController.h"
#import "DAYCalendarView.h"
#define dairyHeight [Util screenSize].height/10*6
#define dairyWidth [Util screenSize].width/10*6
#define screenHeight [Util screenSize].height
#define screenWidth [Util screenSize].width
@interface NANewDayJournalViewController ()<DAYCalendarViewDelegate>{
    NADoc *currentDoc;
    NALoginAlertView *myalertview;
    BOOL isTempAutoLogin;
    BOOL isTempAllDownload;
    
}
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIImageView *pictureView;
@property (nonatomic, strong) NSMutableArray *dateSelectedArray;
@property (nonatomic, strong) DAYCalendarView *calendarView;
@property (nonatomic, strong) NSMutableArray *nowMonthArray;
@property (nonatomic, strong) UIView *lineViewVertical;
@property (nonatomic, strong) UIView *lineViewHor;
@end

@implementation NANewDayJournalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.backBarItem;
    self.view.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:245.0/255.0 alpha:1];
    
}
- (UIBarButtonItem *)backBarItem
{
    if (!_backBarItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"19_blue"]
                          forState:UIControlStateNormal];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 78/2, 36/2);
        _backBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }
    return _backBarItem;
}

- (void)back{
    _calendarView.noReload = 1;
    [self dismissViewControllerAnimated:YES completion:^{
        _calendarView.noReload = 1;
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [self getDateSelected];
}

/**
 * 一覧情報を取得
 *
 */
- (void)getDateSelected
{
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    NADoc *doc = self.currDoc;
    NSDictionary *param;
    NSString *month = nil;
    NSString *date = nil;
    NSString *year = [[Util getSystemDate] substringWithRange:NSMakeRange(0, 4)];
    if ([[self.currDoc.publishDate substringWithRange:NSMakeRange(4, 2)] hasPrefix:@"0"]) {
        month = [self.currDoc.publishDate substringWithRange:NSMakeRange(5, 1)];
         date = [NSString stringWithFormat:@"%@0%ld01:%@",year,month.integerValue -1,[Util getSystemDate]];
    }else{
        month = [self.currDoc.publishDate substringWithRange:NSMakeRange(4, 2)];
        date = [NSString stringWithFormat:@"%@%ld01:%@",year,month.integerValue -1,[Util getSystemDate]];
    }
    
    param = @{
              @"Userid"     :  [NASaveData getDefaultUserID],
              @"K090"       :  @"010",
              @"Rows"       :  @"99",
              @"K003"       :  date,
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
    [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
        if (error) {
            ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
            return;
        }
        SHXMLParser *parser = [[SHXMLParser alloc] init];
        NSDictionary *dic = [parser parseData:search];
        NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
        NSArray *array = searchBaseClass.response.doc;
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (NADoc *doc in array) {
            [mutableArray addObject:doc];
        }
        
        [self.dateSelectedArray removeAllObjects];
        self.dateSelectedArray=mutableArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.dateSelectedArray.count > 0) {
                
                _nowMonthArray= [NSMutableArray array];
                NSString *month = nil;
                NSString *day = nil;
                if ([[self.currDoc.publishDate substringWithRange:NSMakeRange(4, 2)] hasPrefix:@"0"]) {
                    month = [self.currDoc.publishDate substringWithRange:NSMakeRange(5, 1)];
                }else{
                    month = [self.currDoc.publishDate substringWithRange:NSMakeRange(4, 2)];
                }
                if ([[self.currDoc.publishDate substringWithRange:NSMakeRange(6, 2)] hasPrefix:@"0"]) {
                    day = [self.currDoc.publishDate substringWithRange:NSMakeRange(7, 1)];
                }else{
                    day = [self.currDoc.publishDate substringWithRange:NSMakeRange(6, 2)];
                }
                NSInteger nowMonthNumber = [month integerValue];
                for (NADoc *doc in self.dateSelectedArray) {
                    NSString *month2 = nil;
                    if ([[doc.publishDate substringWithRange:NSMakeRange(4, 2)] hasPrefix:@"0"]) {
                        month2 = [doc.publishDate substringWithRange:NSMakeRange(5, 1)];
                    }else{
                        month2 = [doc.publishDate substringWithRange:NSMakeRange(4, 2)];
                    }
                    if ([month2 integerValue] == nowMonthNumber) {
                        [self searchCurrentApi:doc ByUserid:[NASaveData getDefaultUserID]];
                    }else if ([month2 integerValue] == nowMonthNumber -1){
                        [self searchCurrentApi:doc ByUserid:[NASaveData getDefaultUserID]];
                    }
                }
                
            }else{
                [ProgressHUD dismiss];
            }
            
        });
        
    }];
}
- (void)searchCurrentApi:(NADoc *)doc ByUserid:(NSString *)myUserid{
    NSDictionary *param = @{
                            @"K008"       :  doc.editionInfoId,
                            @"Userid"     :  myUserid,
                            @"UseDevice"  :  NAUserDevice,
                            @"Rows"       :  @"999",
                            @"K004"       :  doc.publisherGroupInfoId,
                            @"K003"       :  [NSString stringWithFormat:@"%@:%@",doc.publishDate,doc.publishDate],
                            @"K006"       :  doc.publicationInfoId,
                            @"K005"       :  doc.publisherInfoId,
                            @"K014"       :  @"1",
                            @"K002"       :  @"2",//2纸面4记事
                            @"Mode"       :  @"1",//1数据2件数
                            @"Sort"       :  @"K006:asc,K090:asc,K012:asc",
                            @"Fl"         :  [NSString searchCurrentFl],
                            @"K084"       :  @"1",
                            };
    [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
        
        if (!error) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                SHXMLParser *parser = [[SHXMLParser alloc] init];
                NSDictionary *dic = [parser parseData:search];
                NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                NSArray *arr = searchBaseClass.response.doc;
                if (arr.count>0) {
                    NSDictionary *dictt = [[NSDictionary alloc] initWithObjectsAndKeys:doc.publishDate,@"publishDate",@"1",@"regionViewFlg", nil];
                    [_nowMonthArray addObject:dictt];
                    NSLog(@"%lu",(unsigned long)_nowMonthArray.count);
                }else{
                    NSDictionary *dictt = [[NSDictionary alloc] initWithObjectsAndKeys:doc.publishDate,@"publishDate",@"0",@"regionViewFlg", nil];
                    [_nowMonthArray addObject:dictt];
                }
                if (_nowMonthArray.count == self.dateSelectedArray.count) {
                    [self configControls];
                    [ProgressHUD dismiss];
                }
            });
        }
    }];
}
- (void)configControls{
    NSString *month = nil;
    NSString *day = nil;
    if ([[self.currDoc.publishDate substringWithRange:NSMakeRange(4, 2)] hasPrefix:@"0"]) {
        month = [self.currDoc.publishDate substringWithRange:NSMakeRange(5, 1)];
    }else{
        month = [self.currDoc.publishDate substringWithRange:NSMakeRange(4, 2)];
    }
    if ([[self.currDoc.publishDate substringWithRange:NSMakeRange(6, 2)] hasPrefix:@"0"]) {
        day = [self.currDoc.publishDate substringWithRange:NSMakeRange(7, 1)];
    }else{
        day = [self.currDoc.publishDate substringWithRange:NSMakeRange(6, 2)];
    }
    if ([self isLandscape]) {
        if (isPhone) {
            _calendarView = [[DAYCalendarView alloc]initWithFrame:CGRectMake(0, 36/2+10, dairyWidth, screenHeight-36/2-10)];
        }else{
            _calendarView = [[DAYCalendarView alloc]initWithFrame:CGRectMake(0, 36/2+20, dairyWidth, screenHeight-36/2-20)];
        }
        
    }else{
        _calendarView = [[DAYCalendarView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, dairyHeight)];
        
    }
    _calendarView.nowMonthArray = _nowMonthArray;
    _calendarView.publishDate = month;
    _calendarView.monthNew = month;
    _calendarView.dayNew = day;
    _calendarView.select = 0;
    _calendarView.delegate = self;
    [_calendarView addTarget:self action:@selector(calendarViewDidChange2:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_calendarView];
    
    
    NADoc *doc = self.currDoc;
    UIImage *image =doc.thumbimage;
    if ([self isLandscape]) {
        _pictureView = [[UIImageView alloc]initWithFrame:CGRectMake(dairyWidth+2, 0, screenWidth-dairyWidth-1, screenHeight)];
        _pictureView.layer.contentsRect=CGRectMake(0,0,1,1);

    }else{
        _pictureView = [[UIImageView alloc]initWithFrame:CGRectMake(0, dairyHeight+2, screenWidth, screenHeight -dairyHeight-2)];
        _pictureView.layer.contentsRect=CGRectMake(0,0,1,0.5);
    }
    
    [self.view addSubview:_pictureView];
    [_pictureView setImage:image];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pictureView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_pictureView);
    }];
    [btn addTarget:self action:@selector(tapPage3:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    _pictureView.userInteractionEnabled = YES;
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[UIImage imageNamed:@"19_blue"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    if (isPhone) {
        _backBtn.frame = CGRectMake(5,10, 78/2, 36/2);
    }else{
        _backBtn.frame = CGRectMake(5,20, 78/2, 36/2);
    }
    
    [self.view addSubview:_backBtn];
    if ([self isLandscape]) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        _backBtn.hidden = NO;
        
    }else{
        _backBtn.hidden = YES;
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        
    }
    if (isPhone) {
        _lineViewVertical = [[UIView alloc]initWithFrame:CGRectMake(dairyWidth, 0, 1, screenHeight)];
        
    }else{
        _lineViewVertical = [[UIView alloc]initWithFrame:CGRectMake(dairyWidth, 15, 1, screenHeight-15)];
        
    }
    
    [self.view addSubview:_lineViewVertical];
    _lineViewHor = [[UIView alloc]initWithFrame:CGRectMake(0, dairyHeight+1, screenWidth, 1)];
    
    [self.view addSubview:_lineViewHor];
    _lineViewHor.backgroundColor = [UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1];
    _lineViewVertical.backgroundColor = [UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1];
    if ([self isLandscape]) {
        _lineViewHor.hidden = YES;
        _lineViewVertical.hidden = NO;
    }else{
        _lineViewVertical.hidden = YES;
        _lineViewHor.hidden = NO;
        
    }
}
- (void)tapPage3:(UIButton *)btn
{
    
    btn.backgroundColor =[UIColor clearColor];
    NADoc *tmpDoc=self.currDoc;
    _calendarView.noReload = 1;
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.selectedDocCompletionBlock) {
            NSInteger isHaveRegion = 0;
            for (int i = 0; i < _nowMonthArray.count; i++) {
                NSString *publishDate = [[_nowMonthArray objectAtIndex:i] objectForKey:@"publishDate"];
                NSString *regionFlg = [[_nowMonthArray objectAtIndex:i] objectForKey:@"regionViewFlg"];
                if ([tmpDoc.publishDate isEqualToString:publishDate]) {
                    isHaveRegion = regionFlg.integerValue;
                }
            }
            self.selectedIsHaveRegionBlock(isHaveRegion);
            self.selectedDocCompletionBlock (tmpDoc);
        }
        
    }];
    
}
- (void)button1BackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:0.48];
}
- (BOOL)isLandscape
{
    
    return ([Util screenSize].width>[Util screenSize].height);
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
    if ([self isLandscape]) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        _backBtn.hidden = NO;
        if (isPhone) {
            _calendarView.frame = CGRectMake(0, 36/2+10, dairyWidth, screenHeight-36/2-10);
            _pictureView.frame = CGRectMake(dairyWidth+2, 0, screenWidth-dairyWidth-2, screenHeight);
            _lineViewVertical.frame = CGRectMake(dairyWidth, 0, 1, screenHeight);
            _lineViewHor.frame = CGRectMake(0, dairyHeight+1, screenWidth, 1);
        }else{
            _calendarView.frame = CGRectMake(0, 36/2+20, dairyWidth, screenHeight-36/2-20);
            _pictureView.frame = CGRectMake(dairyWidth+2, 0, screenWidth-dairyWidth-2, screenHeight);
            _lineViewVertical.frame = CGRectMake(dairyWidth, 20, 1, screenHeight-20);
            _lineViewHor.frame = CGRectMake(0, dairyHeight+1, screenWidth, 1);
        }
        _lineViewHor.hidden = YES;
        _lineViewVertical.hidden = NO;
        _pictureView.layer.contentsRect=CGRectMake(0,0,1,1);
    }else{
        _backBtn.hidden = YES;
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        _calendarView.frame = CGRectMake(0, 0, screenWidth, dairyHeight);
        _pictureView.frame = CGRectMake(0, dairyHeight+2, screenWidth, screenHeight -dairyHeight-2);
        _lineViewVertical.frame = CGRectMake(screenWidth/2, 20, 1, screenHeight-20);
        _lineViewHor.frame = CGRectMake(0, dairyHeight+1, screenWidth, 1);
        _lineViewVertical.hidden = YES;
        _lineViewHor.hidden = NO;
        _pictureView.layer.contentsRect=CGRectMake(0,0,1,0.5);
    }
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.presentingViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)calendarViewDidChange:(id)sender {
    if ([self isLandscape]) {
        _pictureView.image=[UIImage imageNamed:@"nextep_logo_blue_1024_768.png"];
    }else{
        _pictureView.image=[UIImage imageNamed:@"nextep_logo_blue.png"];
    }
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
    [dateformatter setLocale:locale];
    [dateformatter setDateFormat:@"yyyyMMdd"];
    NSString *date = [dateformatter stringFromDate:sender];
    for (NADoc *doc in self.dateSelectedArray) {
        if ([doc.publishDate isEqualToString:date]) {
            NSString *urlString = doc.miniPagePath;
            NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
            UIImage *image = [UIImage imageWithData:data];
            [_pictureView setImage:image];
            if ([self isLandscape]) {
                _pictureView.layer.contentsRect=CGRectMake(0,0,1,1);
            }else{
                _pictureView.layer.contentsRect=CGRectMake(0,0,1,0.5);
            }
            self.currDoc = doc;
        }
        
    }
}
- (void)calendarViewDidChange2:(id)sender {
    if ([self isLandscape]) {
        _pictureView.image=[UIImage imageNamed:@"nextep_logo_blue_1024_768.png"];
    }else{
        _pictureView.image=[UIImage imageNamed:@"nextep_logo_blue.png"];
    }
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
    [dateformatter setLocale:locale];
    [dateformatter setDateFormat:@"yyyyMMdd"];
    NSString *date = [dateformatter stringFromDate:self.calendarView.selectedDate];
    for (NADoc *doc in self.dateSelectedArray) {
        if ([doc.publishDate isEqualToString:date]) {
            NSString *urlString = doc.miniPagePath;
            NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
            UIImage *image = [UIImage imageWithData:data];
            [_pictureView setImage:image];
            if ([self isLandscape]) {
                _pictureView.layer.contentsRect=CGRectMake(0,0,1,1);
            }else{
                _pictureView.layer.contentsRect=CGRectMake(0,0,1,0.5);
            }
            self.currDoc = doc;
        }
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

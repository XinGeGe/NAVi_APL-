//
//  NoteTableView.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/10.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NoteTableView.h"

#import "NAGripTableViewCell.h"
#import "NADetailViewController.h"
#import "NANoteCell.h"
#import "NADetailBaseViewController.h"
@interface NoteTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tView;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) NSMutableArray *clipArray;
@property (nonatomic, assign) NAGripTableViewCellDeviceType gripCellType;
@end

@implementation NoteTableView{
    NSInteger titlelength;
    NSInteger detailtitlelength;
    NSInteger myChangeNum;
}

- (void)reloadData {
    [self.tView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:245.0/255.0 alpha:1];
    
    NSData *data = [NSData dataWithContentsOfFile:self.path];
    
    NSMutableArray *noteListArray = [[NSMutableArray alloc]init];
    [noteListArray addObjectsFromArray:[[NAFileManager sharedInstance] arrayWithData:data]];
    self.dataSouce = noteListArray;
    
    self.clipArray = [NSMutableArray array];
    self.gripCellType = [self deviceType:self.interfaceOrientation];
    NSDictionary *dic=[NAFileManager ChangePlistTodic];
    NSString *titlestrlength=[dic objectForKey:NANewsTitleLengthkey];
    NSString *textstrlength=[dic objectForKey:NANewsTextLengthkey];
    titlelength=[titlestrlength integerValue];
    detailtitlelength=[textstrlength integerValue];
    

    [self.tView reloadData];
}
/**
 * view初期化
 *
 */
- (void)initViews
{
    [super initViews];

    self.gripCellType = [self deviceType:self.interfaceOrientation];
    self.tView = [[UITableView alloc]init];
    self.tView.delegate=self;
    self.tView.dataSource=self;
    self.tView.userInteractionEnabled=YES;
    
    [self.view addSubview:self.tView];
    
    [self.tView addGestureRecognizer:self.singleTap];
    [self.tView addGestureRecognizer:self.longPressGesture];
    
    self.tView.tableFooterView = [UIView new];
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
    if (isPhone) {
        self.tView.frame = CGRectMake(0, 0, screenWidth, screenHeight-44);
    }else{
        self.tView.frame = CGRectMake(0, 0, screenWidth, screenHeight-49);
    }
}
- (BOOL)isLandscape
{
    
    return ([Util screenSize].width>[Util screenSize].height);
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
            NADetailBaseViewController *detail = [[NADetailBaseViewController alloc] init];
            detail.currentIndex = indexPath.row;
            detail.details = self.dataSouce;
            detail.isfromWhere=TYPE_NOTE;
            detail.regionDic = _regionDic;
            NADoc *doc = [self.dataSouce objectAtIndex:indexPath.row];
            detail.topPageDoc = doc;
            detail.indexNoFromClip = doc.indexNo;
            detail.pageArray = _pageArray;
            detail.clipDataSource = _clipDataSource;
//            detail.noteNumber = _noteNumber;
//            detail.NoteArray = _NoteArray;
            NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:detail];
            [self presentViewController:nav animated:YES completion:^{
                
            }];
            NADoc *tmpDoc=[self.dataSouce objectAtIndex:indexPath.row];
            // GA(tag manager)
            [TAGManagerUtil pushButtonClickEvent:ENSelectKiji label:[NSString stringWithFormat:@"%@/%@",tmpDoc.publishDate,tmpDoc.newsGroupTitle]];
            
        }
    }}

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
            cellHeight = NANoteiPadLandscapeCellHeight;
            break;
        case NAiPadPortrait:
            cellHeight = NANoteiPadPortraitCellHeight;
            break;
        case NAiPhoneLandscape:
            cellHeight = NANoteiPhoneLandscapeCellHeight;
            break;
        case NAiPhonePortrait:
            cellHeight = NANoteiPhonePortraitCellHeight;
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
    NANoteCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NANoteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellType = self.gripCellType;
    
    // longpress場合、backgroundColorを設定
    //    if (indexPath.row>=self.dataSouce.count) {
    //        return cell;
    //    }
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
//    if ([clipDoc.newsGroupTitle isKindOfClass:[NSString class]]) {
//        cell.titleLbl.text = clipDoc.newsGroupTitle;
//    }else{
//        cell.titleLbl.text = @"";
//    }
    cell.lineView.hidden = YES;
    // 記事内容を設定
    if ([clipDoc.newsGroupTitle isKindOfClass:[NSString class]]) {
        NSString *mydetailtext=clipDoc.newsGroupTitle;
        if ([CharUtil isHaveRubytext:mydetailtext]) {
            cell.isHaveRuby=YES;
            [cell loadDetailWithisHaveRuby:YES];
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
            [cell loadDetailWithisHaveRuby:NO];
            
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
    
    //cell.dateLbl.text = [NSString stringWithFormat:@"%@  %@  %@",clipDoc.editionInfoName,clipDoc.pageInfoName,clipDoc.printRevisionInfoName];
    return cell;
}
/**
 * グリップ格納
 *
 */
-(void)saveClip{
    NAClipDoc *clipDoc;
    
    if (self.clipArray.count > 0) {
        clipDoc=[self.clipArray objectAtIndex:0];
    } else {
        [ProgressHUD dismiss];
        //        [[[iToast makeText:NSLocalizedString(@"note saved", nil)]
        //          setGravity:iToastGravityBottom] show];
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
                ITOAST_BOTTOM(NSLocalizedString(@"note Max", nil));
            }else if([status isEqualToString:@"1"]){
                MAIN(^{
                    [[[iToast makeText:NSLocalizedString(@"note indexNo error", nil)]
                      setGravity:iToastGravityBottom] show];
                });
            }else if ([status isEqualToString:@"0"]){
                [[[iToast makeText:NSLocalizedString(@"note saved", nil)]
                  setGravity:iToastGravityBottom] show];
                // GA
                [TAGManagerUtil pushButtonClickEvent:ENClipSaveBtn label:[Util getLabelName:clipDoc]];
                [self.clipArray removeObjectAtIndex:0];
                [self saveClip];
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
        // GA(tag manager)
        [TAGManagerUtil pushButtonClickEvent:ENAddClipBtn label:ENAddClipLab];
        
    }else{
        [[[iToast makeText:NSLocalizedString(@"networkerror", @"")]
          setGravity:iToastGravityBottom] show];
        
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

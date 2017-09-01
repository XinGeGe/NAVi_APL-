
#import "NANewsViewController.h"
#import "NADocCell.h"
#import "NADocPadCell.h"

@interface NANewsViewController () <UITableViewDataSource, UITableViewDelegate>{
    NSArray *myinfoarray;
}

@property (nonatomic, strong) UITableView *tView;
@property (nonatomic, strong) NSMutableArray *publisherInfoDocs;
@property (nonatomic,strong)NSMutableArray *publisherInfoArray;


@end

@implementation NANewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getNewsList];
    
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
    self.title = NSLocalizedString(@"News List", nil);
    self.navigationItem.leftBarButtonItem = self.backBtnItem;
    self.publisherInfoDocs = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.tView.hidden = YES;
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
 * 新聞一覧情報を取得
 *
 */
- (void)getNewsList
{
    if (![NACheckNetwork sharedInstance].isHavenetwork) {
        ITOAST_BOTTOM(NSLocalizedString(@"networkerror", nil));
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [ProgressHUD show:NSLocalizedString(@"messageloading", nil)];
    BACK(^{
        NSArray *info = [[NAFileManager sharedInstance] masterPublisherGroupInfo];
        [self.publisherInfoDocs removeAllObjects];
        
        if ([NACheckNetwork sharedInstance].isHavenetwork) {
            myinfoarray=info;
            
            [self getDocsFromNetwork:info groupIndex:0 index:0];
        }else{
            
            //[self getDocsFromLocal:info];
        }
        
        
        NSMutableArray *publisherInfos = [NSMutableArray array];
        for (NAPublisherGroupInfo *publisherGroupInfo in info) {
            for (NAPublisherInfo *publisherInfo in publisherGroupInfo.publisherInfo) {
                [publisherInfos addObject:publisherInfo];
            }
        }
        self.publisherInfoArray = publisherInfos;
    });
    
    
    
    
}
-(void)addMyTview{
    if (myinfoarray.count==1) {
        _tView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }else{
        _tView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    _tView.dataSource = self;
    _tView.delegate = self;
    _tView.tableFooterView=[[UIView alloc]init];
    
    [self.view addSubview:_tView];
}
/**
 * tView初期化
 *
 */
/*
 - (UITableView *)tView
 {
 if (!_tView) {
 _tView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
 _tView.dataSource = self;
 _tView.delegate = self;
 _tView.tableFooterView=[[UIView alloc]init];
 }
 return _tView;
 }
 */
#pragma mark - tableView delegate -
#pragma mark

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (myinfoarray.count==1) {
//        return nil;
//    }else{
//        if (section<self.publisherInfoDocs.count) {
//            NADoc *doc = self.publisherInfoDocs[section];
//            return doc.publisherGroupInfoName;
//            
//        }else{
//            return nil;
//        }
//    }
//    
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (myinfoarray.count==1) {
        return nil;
        
    }else{
        UIView *myHeadview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tView.frame.size.width, 30)];
        CGFloat labY=0;
        if (section==0) {
            labY=10;
        }else{
            labY=-8;
        }
        UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(20,labY, self.tView.frame.size.width-10, 30)];
        NADoc *doc = self.publisherInfoDocs[section];
        titleLab.textColor=[UIColor grayColor];
        titleLab.text=doc.publisherGroupInfoName;
        [myHeadview addSubview:titleLab];
        return myHeadview;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
     if (myinfoarray.count==1) {
         return 0;
     }else{
         if (section==0) {
             return 50;
         }else{
             return 30;
         }
     }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.publisherInfoDocs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count  = 0;
    NSInteger item = isPad ? 4 : 2;
    NAPublisherGroupInfo *publisherGroupInfo=[myinfoarray objectAtIndex:section];
    NSArray *tmparray=publisherGroupInfo.publisherInfo;
    count = tmparray.count / item;
    if (tmparray.count % item != 0) {
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
    NSInteger preCount  = 0;
    NSInteger count  = 0;
    
    for (NSInteger i=0; i<indexPath.section; i++) {
        NAPublisherGroupInfo *prePublisherGroupInfo=[myinfoarray objectAtIndex:i];
        preCount = preCount + prePublisherGroupInfo.publisherInfo.count;
    }
    
    NAPublisherGroupInfo *publisherGroupInfo=[myinfoarray objectAtIndex:indexPath.section];
    count = publisherGroupInfo.publisherInfo.count ;
    
    if (isPad) {
        static NSString *CellIdentifier = @"Cell";
        NADocPadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[NADocPadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            //cell.backgroundColor=[UIColor blackColor];
        }
        NSInteger index = preCount + indexPath.row * 4;
        if (index < preCount + count && index < self.publisherInfoDocs.count) {
            NADoc *doc = self.publisherInfoDocs[index];
            cell.docView1.tag = index + 1;
            [self setMyCollectionView:cell.docView1 withDoc:doc];
        }
        index = preCount + indexPath.row * 4 + 1;
        if (index < preCount + count && index < self.publisherInfoDocs.count) {
            NADoc *doc = self.publisherInfoDocs[index];
            cell.docView2.tag = index + 1;
            [self setMyCollectionView:cell.docView2 withDoc:doc];
        }
        index = preCount + indexPath.row * 4 + 2;
        if (index < preCount + count && index < self.publisherInfoDocs.count) {
            NADoc *doc = self.publisherInfoDocs[index];
            cell.docView3.tag = index + 1;
            [self setMyCollectionView:cell.docView3 withDoc:doc];
        }
        index = preCount + indexPath.row * 4 + 3;
        if (index < preCount + count && index < self.publisherInfoDocs.count) {
            NADoc *doc = self.publisherInfoDocs[index];
            cell.docView4.tag = index + 1;
            [self setMyCollectionView:cell.docView4 withDoc:doc];
        }
        cell.selectedObjectCompletionBlock = ^(id object) {
            UIView *view = (UIView *)object;
            if (view.tag) {
                [self dismissViewControllerAnimated:YES completion:^{
                    if (self.selectedDocCompletionBlock) {
                        self.selectedDocCompletionBlock (self.publisherInfoDocs[view.tag - 1]);
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
        NSInteger index = preCount + indexPath.row * 2;
        if (index < preCount + count && index < self.publisherInfoDocs.count) {
            NADoc *doc = self.publisherInfoDocs[index];
            cell.leftDocView.tag = index + 1;
            [self setMyCollectionView:cell.leftDocView withDoc:doc];
        }
        index = preCount + indexPath.row * 2 + 1;
        if (index < preCount + count && index < self.publisherInfoDocs.count) {
            NADoc *doc = self.publisherInfoDocs[index];
            cell.rightDocView.tag = index + 1;
            [self setMyCollectionView:cell.rightDocView withDoc:doc];
        }
        cell.selectedObjectCompletionBlock = ^(id object) {
            UIView *view = (UIView *)object;
            if (view.tag) {
                [self dismissViewControllerAnimated:YES completion:^{
                    if (self.selectedDocCompletionBlock) {
                        self.selectedDocCompletionBlock (self.publisherInfoDocs[view.tag - 1]);
                    }
                    
                }];
            }
        };
        return cell;
    }
}
-(void)setMyCollectionView:(UIView *)myCollectionView withDoc:(NADoc *)mydoc{
    NASubPagerView *myPageView=(NASubPagerView *)myCollectionView;
    [myPageView imageViewWthInfo:mydoc];
    [myPageView updateMainTitleWithName:[self getMainTitleText:mydoc]];
    [myPageView updateTitleWithName:[self getSubTitleText:mydoc]];
    
    
    if ([NASaveData getIsVisitorModel]) {
        myPageView.imageIdentfier.hidden=NO;
        if ([mydoc.publicationInfoId isEqualToString:@"004"]) {
            [myPageView.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_sample"]];
        }else{
            [myPageView.imageIdentfier setImage:[UIImage imageNamed:@"icon_mark_cost"]];
        }
        
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
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
//    for (NAPublisherInfo *findDoc in self.publisherInfoArray) {
//        if ([findDoc.publisherInfoIdentifier isEqualToString: doc.publisherInfoId]) {
//            title = findDoc.name;
//            break;
//        }
//    }
    
    
    title = [title stringByAppendingString:@" "];
    title = [title stringByAppendingString:doc.editionInfoName ];
    return title;
}

/**
 * networkから、新聞一覧情報を取得
 *
 */
- (void)getDocsFromNetwork:(NSArray *)publisherGroupInfos groupIndex:(NSInteger)groupIndex index:(NSInteger)index
{
    if (groupIndex >= publisherGroupInfos.count) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.publisherInfoDocs.count > 0) {
                [self addMyTview];
            }else{
                self.tView.hidden = YES;
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            [ProgressHUD dismiss];
        });
        return;
    }
    
    NAPublisherGroupInfo *info = publisherGroupInfos[groupIndex];
    NSString *K004 = info.publisherGroupInfoIdentifier;
    
    NSArray *array = info.publisherInfo;
    
    NAPublisherInfo *publisherInfo = array[index];
    NSString *K005 = publisherInfo.publisherInfoIdentifier;
    if (publisherInfo.publicationInfo) {
        NAPublicationInfo *publicationInfo = publisherInfo.publicationInfo[0];
        NSString *K006 = publicationInfo.publicationInfoIdentifier;
        NSDictionary *param = @{
                                @"Userid"     :  [NASaveData getLoginUserId],
                                @"UseDevice"  :  NAUserDevice,
                                @"K090"       :  @"010",
                                @"K014"       :  @"1",
                                @"Rows"       :  @"1",
                                @"K004"       :  K004,
                                @"K005"       :  K005,
                                @"K006"       :  K006,
                                @"K002"       :  @"2",
                                @"Mode"       :  @"1",
                                @"Sort"       :  @"K003:desc,K008:desc,K012:asc",
                                @"Fl"         :  [NSString searchWithPublicationInfoId]
                                };
        [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
            if (!error) {
                SHXMLParser *parser = [[SHXMLParser alloc] init];
                NSDictionary *dic = [parser parseData:search];
                NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                if (searchBaseClass.response.doc.count > 0) {
                    NADoc *currentDoc = searchBaseClass.response.doc[0];
                    if ([self.currDoc.publisherGroupInfoId isEqualToString:currentDoc.publisherGroupInfoId]&&[self.currDoc.publisherInfoId isEqualToString:currentDoc.publisherInfoId]&&[self.currDoc.publicationInfoId isEqualToString:currentDoc.publicationInfoId]) {
                        [self.publisherInfoDocs addObject:self.currDoc];
                    }else{
                        [self.publisherInfoDocs addObject:currentDoc];
                    }
                }
                
                if (index == array.count - 1) {
                    [self getDocsFromNetwork:publisherGroupInfos groupIndex:groupIndex + 1 index:0];
                } else {
                    [self getDocsFromNetwork:publisherGroupInfos groupIndex:groupIndex index:index + 1];
                }
                
            }else{
                ITOAST_BOTTOM(error.localizedDescription);
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        
    }
    
}

/**
 * Localから、新聞一覧情報を取得
 *
 */
- (void)getDocsFromLocal:(NSArray *)info
{
    NSMutableArray *muarray=[[NSMutableArray alloc]init];
    
    NSArray *tmpdocarray=[[NASQLHelper sharedInstance]getPaperInfoByUserId:[NASaveData getLoginUserId]];
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
                    if (![muarray containsObject:napg]) {
                        [muarray addObject:napg];
                    }
                    
                }
            }
            [self.publisherInfoDocs addObject:doc];
        }
    }
    myinfoarray=muarray;
    MAIN(^{
        if (self.publisherInfoDocs.count > 0) {
            [self addMyTview];
        }else{
            self.tView.hidden = YES;
        }
        [ProgressHUD dismiss];
    });
    
}

@end

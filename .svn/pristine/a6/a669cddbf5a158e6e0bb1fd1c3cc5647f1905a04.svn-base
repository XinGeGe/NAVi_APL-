//
//  NANewSearchViewController.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/19.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NANewSearchViewController.h"
#import "NASearchResultViewController.h"
#import "FontUtil.h"
#import "NaSearchClipResultViewController.h"
@interface NANewSearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *textSearch;
    NSInteger searchNumber;
    UITableView *tabSearchHistory;
    UIButton *paperBtn;
    UIButton *clipBtn;
    
}
@property (nonatomic, strong) NSArray *searchResults;
@end

@implementation NANewSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:117.0/255.0 green:117.0/255.0 blue:117.0/255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:117.0/255.0 green:117.0/255.0 blue:117.0/255.0 alpha:1];
    self.navigationItem.leftBarButtonItem = self.backBarItem;
    NSInteger titleWidth = 200;
    if (isPad) {
        titleWidth = 400;
    }
    //set  titleview
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleWidth, self.navigationController.navigationBar.frame.size.height)];
    //titleView.backgroundColor = [UIColor colorWithRed:117.0/255.0 green:117.0/255.0 blue:117.0/255.0 alpha:1];
    self.navigationItem.titleView = titleView;
    
    paperBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleView addSubview:paperBtn];
    [paperBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_top).offset((self.navigationController.navigationBar.frame.size.height-25)/2);
        make.left.mas_equalTo(5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo((titleWidth-15)/2);
    }];
    paperBtn.backgroundColor = [UIColor colorWithRed:234/255.0 green:115/255.0 blue:160/255.0 alpha:1];
    [paperBtn setTitle:@"全紙面" forState:UIControlStateNormal];
    [paperBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    paperBtn.layer.borderWidth=1;
    paperBtn.layer.borderColor=[UIColor colorWithRed:234/255.0 green:115/255.0 blue:160/255.0 alpha:1].CGColor;
    paperBtn.layer.masksToBounds=YES;
    paperBtn.layer.cornerRadius=10;
    paperBtn.titleLabel.font = [FontUtil systemFontOfSize:14];
    [paperBtn addTarget:self action:@selector(paperSearch) forControlEvents:UIControlEventTouchUpInside];
    
    clipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleView addSubview:clipBtn];
    [clipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_top).offset((self.navigationController.navigationBar.frame.size.height-25)/2);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo((titleWidth-15)/2);
    }];
    clipBtn.backgroundColor = [UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1];
    [clipBtn setTitle:@"スクラップ" forState:UIControlStateNormal];
    [clipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    clipBtn.layer.borderWidth=1;
    clipBtn.layer.borderColor=[UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
    clipBtn.layer.masksToBounds=YES;
    clipBtn.layer.cornerRadius=10;
    clipBtn.titleLabel.font = [FontUtil systemFontOfSize:14];
    [clipBtn addTarget:self action:@selector(clipSearch) forControlEvents:UIControlEventTouchUpInside];
    

    //search
    UIView *searchView = [[UIView alloc]init];
    [self.view addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    searchView.backgroundColor = [UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1];
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [searchView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchView.mas_left).offset(10);
        make.top.equalTo(searchView.mas_top).offset(5);
        make.right.equalTo(searchView.mas_right).offset(-100);
        make.height.mas_equalTo(30);
    }];
    backView.layer.borderWidth=1;
    backView.layer.borderColor=[UIColor whiteColor].CGColor;
    backView.layer.masksToBounds=YES;
    backView.layer.cornerRadius=5;
    
    UIImageView *imageViewSearch = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"06_blue"]];
    [backView addSubview:imageViewSearch];
    [imageViewSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(2);
        make.top.equalTo(backView.mas_top).offset(5);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    textSearch = [[UITextField alloc]init];
    textSearch.placeholder = @"キーワードのタップで検索";
    textSearch.delegate = self;
    textSearch.returnKeyType =UIReturnKeySearch;
    [textSearch setFont:[FontUtil systemFontOfSize:15]];
    [backView addSubview:textSearch];
    [textSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top);
        make.left.equalTo(imageViewSearch.mas_right);
        make.right.equalTo(backView.mas_right);
        make.height.mas_equalTo(30);
    }];
    //点击空白区域回收键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchView addSubview:btnCancel];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_right).offset(5);
        make.top.equalTo(searchView.mas_top).offset(5);
        make.right.equalTo(searchView.mas_right).offset(-5);
        make.height.mas_equalTo(30);
    }];
    [btnCancel setTitle:@"キャンセル" forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [FontUtil systemFontOfSize:14];
    [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(searchBarCancel) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *attentionView = [[UILabel alloc]init];
    [self.view addSubview:attentionView];
    [attentionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    attentionView.textColor = [UIColor whiteColor];
    attentionView.backgroundColor = [UIColor colorWithRed:62.0/255.0 green:58.0/255.0 blue:57.0/255.0 alpha:1];
    attentionView.textAlignment = NSTextAlignmentCenter;
    attentionView.text = @"注目のキーワード";
    attentionView.font = [FontUtil systemFontOfSize:16];
    
    
    tabSearchHistory = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tabSearchHistory.delegate = self;
    tabSearchHistory.dataSource = self;
    tabSearchHistory.backgroundColor = [UIColor colorWithRed:117.0/255.0 green:117.0/255.0 blue:117.0/255.0 alpha:1];
    tabSearchHistory.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tabSearchHistory];
    [tabSearchHistory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(attentionView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    

    self.searchResults = [self reverseTheArray:[[[NAFileManager sharedInstance] getSearchResult] componentsSeparatedByString:@","]];
    searchNumber = 0;
}
-(NSArray *)reverseTheArray:(NSArray *)myarray{
    NSMutableArray *array = [NSMutableArray arrayWithArray:myarray];
    NSArray *reversedArray = [[array reverseObjectEnumerator] allObjects];
    return reversedArray;
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
    cell.backgroundColor = [UIColor colorWithRed:117.0/255.0 green:117.0/255.0 blue:117.0/255.0 alpha:1];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.searchResults[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *search = self.searchResults[indexPath.row];
    textSearch.text = search;
    [self searchBtnAction];
}
- (void)searchBtnAction
{
    if (textSearch.text.length > 0) {
        NALog(@"searchBtnAction");
        [TAGManagerUtil pushButtonClickEvent:ENSerachBtn label:textSearch.text];
        NSString *result = [[NAFileManager sharedInstance] getSearchResult];
        if (result.length > 0) {
            if ([self.searchResults containsObject:textSearch.text]) {
                [self searchAPI];
                return;
            }
            result = [result stringByAppendingFormat:@",%@",textSearch.text];
        }else {
            result = textSearch.text;
        }
        
        NSData *searchData = [result dataUsingEncoding:NSUTF8StringEncoding];
        [[NAFileManager sharedInstance] saveSearchResult:searchData];
        
        self.searchResults = [self reverseTheArray:[[[NAFileManager sharedInstance] getSearchResult] componentsSeparatedByString:@","]];
        
        [tabSearchHistory reloadData];
//        [self searchAPI];
    }
    
}
- (void)searchAPI
{
    [textSearch resignFirstResponder];
    if (textSearch.text.length > 0) {
        if (searchNumber == 0) {
            [self searchNoteAPI];
        }else{
            [self searchFavoriteAPI];
        }
    }
    
}
- (void)searchFavoriteAPI
{
    
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"Rows"       :  @"999",
                            @"Keyword"    :  textSearch.text,
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
                [ProgressHUD dismiss];
                if (array.count == 0) {
                    [[[iToast makeText:NSLocalizedString(@"NO Note", nil)]
                      setGravity:iToastGravityBottom] show];
                }else{
                    [self toSearchClipResultList:array KeyWord:textSearch.text];
                }
            });
        }else{
            ITOAST_BOTTOM(error.localizedDescription);
            //[self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    
}
- (void)toSearchClipResultList:(NSArray *)array KeyWord:(NSString *)keyWord
{
    NaSearchClipResultViewController *result = [[NaSearchClipResultViewController alloc] init];
    result.dataSouce = array;
    result.myserachtext=keyWord;
//    result.mycurrDoc=self.currDoc;
//    result.serachDate=@"mycurrDoc";
    result.pageArray = _pageArray;
    result.regionDic =_regionDic;
    result.topPageDoc = _topPageDoc;
    result.clipDataSource = _clipDataSource;
    //    result.noteNumber = _noteNumber;
    //     result.NoteArray = _NoteArray;
    [ProgressHUD dismiss];
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:result];
    
    [self presentViewController:nav animated:NO completion:^{
        
    }];
}
- (void)searchNoteAPI
{
    NSString *searchStr = [self whiteSpaceChange:textSearch.text];
    NSString *search = [self convertToFullwidth:searchStr];
    NSString *userId = [NASaveData getDefaultUserID];
    
    NSDictionary *searchParam = @{
                                  @"Userid"     :  userId,
                                  @"Rows"       :  @"15",
                                  @"K002"       :  @"4",
                                  @"Mode"       :  @"1",
                                  @"K003"       :  @"20000101:20991231",
                                  @"K004"       :  @"KM",
                                  @"K005"       :  @"K",
                                  @"K006"       :  @"S01",
                                  @"K008"       :  @"M",
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
                                           NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
                                           NSArray *array = clipBaseClass.response.doc;
                                           
                                           if (array.count > 0) {
                                               [self toSearchResultList:array KeyWord:searchStr];
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
- (void)toSearchResultList:(NSArray *)array KeyWord:(NSString *)keyWord
{
    NASearchResultViewController *result = [[NASearchResultViewController alloc] init];
    result.dataSouce = array;
    result.regionDic =_regionDic;
    result.myserachtext=keyWord;
    result.mycurrDoc=self.currDoc;
    result.serachDate=@"mycurrDoc";
    result.pageArray = _pageArray;
    result.topPageDoc = _topPageDoc;
    result.clipDataSource = _clipDataSource;
//    result.noteNumber = _noteNumber;
//     result.NoteArray = _NoteArray;
    [ProgressHUD dismiss];
    NABaseNavigationController *nav = [[NABaseNavigationController alloc] initWithRootViewController:result];
    
    [self presentViewController:nav animated:NO completion:^{
        
    }];
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

//全紙面検索
- (void)paperSearch{
    searchNumber = 0;
    [self searchBtnAction];
    paperBtn.backgroundColor = [UIColor colorWithRed:234/255.0 green:115/255.0 blue:160/255.0 alpha:1];
    paperBtn.layer.borderColor=[UIColor colorWithRed:234/255.0 green:115/255.0 blue:160/255.0 alpha:1].CGColor;
    clipBtn.backgroundColor = [UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1];
    clipBtn.layer.borderColor=[UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
}
//スクラップ検索
- (void)clipSearch{
    searchNumber = 1;
    [self searchBtnAction];
    clipBtn.backgroundColor = [UIColor colorWithRed:234/255.0 green:115/255.0 blue:160/255.0 alpha:1];
    clipBtn.layer.borderColor=[UIColor colorWithRed:234/255.0 green:115/255.0 blue:160/255.0 alpha:1].CGColor;
    paperBtn.backgroundColor = [UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1];
    paperBtn.layer.borderColor=[UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searchBtnAction];
    
    [textField resignFirstResponder];
    return YES;
}
- (void)keyboardHide:(UITapGestureRecognizer*)tap{
    [textSearch resignFirstResponder];
    
}
- (void)searchBarCancel{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (UIBarButtonItem *)backBarItem
{
    if (!_backBarItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"20_white"]
                          forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backBarItemAction) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 25, 25);
        _backBarItem= [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }
    return _backBarItem;
}

- (void)backBarItemAction{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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

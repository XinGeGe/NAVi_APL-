//
//  NALeftMenuViewController.m
//  NAVi
//
//  Created by y fs on 15/7/14.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NALeftMenuViewController.h"
#import "FontUtil.h"
@implementation NALeftMenuViewController{
    
    NSArray *publicationarray;
    NSArray *publisherinfroarray;
    NSArray *publishergrouparray;
    NSArray *docarray;
    UILabel *titlelab;
    UIView  *titleview;
    NSUInteger selectedNum;
}
@synthesize tView;
@synthesize menuarray;
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[Util colorWithHexString:@"e5e5e5"];
    
    [self initTview];
    selectedNum=0;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tView reloadData];
}
-(void)initTview{
    tView=[[UITableView alloc]init];
    tView.delegate=self;
    tView.dataSource=self;
    tView.tableFooterView=[[UIView alloc]init];
    self.tView.backgroundColor=[Util colorWithHexString:@"e5e5e5"];
    [self.view addSubview:tView];
    
    titleview=[[UIView alloc]init];
    [self.view addSubview:titleview];
    titlelab=[[UILabel alloc]init];
    
    titlelab.text=NSLocalizedString(@"Genre List", @"");
    titlelab.font=[FontUtil boldSystemFontOfSize:17];
    titlelab.textAlignment=NSTextAlignmentCenter;
    [titleview addSubview:titlelab];
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
    titleview.frame=CGRectMake(0, 10, 250, 44);
    titlelab.frame=CGRectMake(0, 0, 250, 44);
    tView.frame=CGRectMake(0, 44, screenWidth, screenHeight-44);
}
#pragma mark - tableView delegate -
#pragma mark

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return menuarray.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"Cell";
    
    NALeftMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NALeftMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row<menuarray.count) {
        NASDoc *sdoc=[menuarray objectAtIndex:indexPath.row];
        cell.titlelab.text=sdoc.gname;
        if ([sdoc.imagepath isKindOfClass:[NSString class]]) {
            [cell.menuimage sd_setImageWithURL:[NSURL URLWithString:sdoc.imagepath] placeholderImage:[UIImage imageNamed:NANOImage]];
        }else{
            cell.menuimage.image=[UIImage imageNamed:NANOImage];
        }
        
    }else{
        cell.titlelab.text=@"clip";
        cell.menuimage.image=[UIImage imageNamed:@"btn_tool_clip_off_1"];
    }
    if (indexPath.row==selectedNum) {
        cell.backgroundColor=[Util colorWithHexString:Lightbulecolor];
    }else{
        cell.backgroundColor=[Util colorWithHexString:@"e5e5e5"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"seclet image index = %ld",(long)indexPath.row);
    selectedNum=indexPath.row;
    if (indexPath.row<menuarray.count) {
        NASDoc *sdoc=[menuarray objectAtIndex:indexPath.row];
        if (sdoc.publisherGroupInfoId.length>0) {
            [[DHSlideMenuController sharedInstance]hideSlideMenuViewController:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTYGetNASDoc object:sdoc];
        }
    }
    if (indexPath.row==menuarray.count) {
        [[DHSlideMenuController sharedInstance]hideSlideMenuViewController:YES];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"clip",[NSNumber numberWithBool:YES], nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTYGetNASDoc object:nil userInfo:dic];
    }
}

/**
 * ジャンル初期化
 *
 */
- (void)initGenre:(NSMutableArray *)array
{
    menuarray = array;
    [self.tView reloadData];
    
    for (NASDoc *sdoc in menuarray) {
        [self searchGenre:sdoc];
    }
}

/**
 * ジャンル検索
 *
 */
- (void)searchGenre:(NASDoc *)doc
{
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"UseDevice"  :  NAUserDevice,
                            @"Rows"       :  @"1",
                            @"K004"       :  doc.publisherGroupInfoId,
                            @"K006"       :  doc.publicationInfoId,
                            @"K005"       :  doc.publisherInfoId,
                            @"K009"       :  doc.genreid,
                            @"K014"       :  @"1",
                            @"K002"       :  @"2",
                            @"Mode"       :  @"1",
                            @"Sort"       :  @"K053:desc,K032:desc",
                            @"Fl"         :  [NSString searchCurrentFl]
                            };
    [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
        
        if (!error) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                SHXMLParser *parser = [[SHXMLParser alloc] init];
                NSDictionary *dic = [parser parseData:search];
                NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                docarray=searchBaseClass.response.doc;
                if (docarray.count>0) {
                    [self searchGenrePhoto:[docarray objectAtIndex:0] SDoc:doc];
                }
            });
        }else{
            ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        }
    }];
}

/**
 * ジャンルmini画像検索
 *
 */
-(void)searchGenrePhoto:(NADoc *)doc SDoc:(NASDoc *)sdoc{
    
    NSDictionary *param = @{  @"Userid"       :  [NASaveData getLoginUserId],
                              @"UseDevice"    :  NAUserDevice,
                              @"Rows"         :  @"20",
                              @"K002"         :  @"4",
                              @"K001"         :  doc.indexNo,
                              @"Mode"         :  @"1",
                              @"Fl"           :  [NSString clipListFl],
                              };
    [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
        if (!error) {
            SHXMLParser *parser = [[SHXMLParser alloc] init];
            NSDictionary *dic = [parser parseData:search];
            NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
            NSArray *array = searchBaseClass.response.doc;
            
            for (NSInteger index=0; index<array.count; index++) {
                NADoc *temdoc=[array objectAtIndex:index];
                if (temdoc.miniPhotoPath) {
                    sdoc.imagepath=temdoc.miniPhotoPath;
                    MAIN(^{
                        [self.tView reloadData];
                    });
                    
                    break;
                }
            }
        }
        
    }];
}
@end

//
//  NaSearchClipResultViewController.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/8/28.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NABaseViewController.h"
#import "NAGripToolbar.h"
#import "NAMyClipTableViewCell.h"
@interface NaSearchClipResultViewController : NABaseViewController<UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *dataSouce;
@property (nonatomic, strong) NSString *myserachtext;
//@property (nonatomic, assign)NSInteger noteNumber;
//@property (nonatomic, strong) NSMutableDictionary *NoteArray;
@property (nonatomic, strong) UIBarButtonItem *searchBarItem;
@property (nonatomic, strong) UIBarButtonItem *webBarItem;
@property (nonatomic, assign) NADoc *topPageDoc;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) NSMutableArray *clipDataSource;
@property (nonatomic, assign) NSInteger clipNumber;
@property (nonatomic,strong) NSString *labYearDetail;
@property (nonatomic,strong) NSMutableAttributedString *labMonthDayDetail;
@property (nonatomic,strong) NSString *labMianDetail;
@property (nonatomic,strong) UILabel *labYearHore;
@property (nonatomic,strong) UILabel *labMonthDayHore;
@property (nonatomic,strong) UILabel *labMianHore;
@property (nonatomic, strong) NSMutableDictionary *regionDic;
@end

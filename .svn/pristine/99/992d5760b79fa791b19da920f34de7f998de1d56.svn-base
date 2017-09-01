//
//  NANewDayJournalViewController.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/17.
//  Copyright © 2017年 dxc. All rights reserved.
//
#import "NALoginAlertView.h"
#import "NALoginClient.h"

typedef void(^selectedDoc)(NADoc *obj);
typedef void(^selectedIsHaveRegion)(NSInteger isHavreRegion);
#import "NABaseViewController.h"

@interface NANewDayJournalViewController : NABaseViewController
@property (nonatomic, strong) NSMutableDictionary *regionDic;
@property (nonatomic, strong) NADoc *currDoc;
@property (nonatomic, strong) selectedDoc selectedDocCompletionBlock;
@property (nonatomic, strong) selectedIsHaveRegion selectedIsHaveRegionBlock;
@property (nonatomic, strong) UIBarButtonItem *backBarItem;
@end

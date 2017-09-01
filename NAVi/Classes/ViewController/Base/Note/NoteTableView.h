//
//  NoteTableView.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/10.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableView : NABaseViewController

//@property (nonatomic, strong) NSArray *dataSouce;
@property (nonatomic, strong) NSArray *dataSouce;
@property (nonatomic, assign) NSInteger pendingVCIndex;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) NADoc *topPageDoc;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) NSMutableDictionary *regionDic;
@property (nonatomic, strong) NSMutableArray *clipDataSource;
//@property (nonatomic, assign)NSInteger noteNumber;
//@property (nonatomic, strong) NSMutableDictionary *NoteArray;
- (void)reloadData;

@end

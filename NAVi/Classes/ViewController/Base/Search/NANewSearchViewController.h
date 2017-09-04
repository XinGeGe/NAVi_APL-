//
//  NANewSearchViewController.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/19.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NANewSearchViewController : NABaseViewController
@property (nonatomic, strong) UIBarButtonItem *backBarItem;
@property (nonatomic, strong) NADoc *currDoc;
@property (nonatomic, assign) NADoc *topPageDoc;
@property (nonatomic, strong) NSMutableDictionary *regionDic;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) NSMutableArray *clipDataSource;
    @property (nonatomic, assign) NSInteger haveChangeIndex;
//@property (nonatomic, assign)NSInteger noteNumber;
//@property (nonatomic, strong) NSMutableDictionary *NoteArray;
@end

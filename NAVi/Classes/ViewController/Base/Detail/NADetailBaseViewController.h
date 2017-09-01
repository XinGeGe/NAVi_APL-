//
//  NADetailBaseViewController.h
//  NAVi
//
//  Created by y fs on 15/11/20.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NABaseViewController.h"
#import "NADetailView.h"
#import "UIImageView+WebCache.h"
#import "NADetailSwipeImageViewController.h"
#import "NAImageDetailClass.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NAMoviePlayerController.h"
typedef NS_ENUM(NSInteger, NADetailModel) {
    NADetailModelTitle   = 101,
    NADetailModelComment = 102,
    NADetailModelPaper   = 103,
};
@interface NADetailBaseViewController : NABaseViewController@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger totalIndex;
@property (nonatomic, strong) NSArray *details;
@property (nonatomic, assign) BOOL deleteClip;
@property (nonatomic, strong) NSString *myserachtext;
@property (nonatomic, strong) NSString *indexNoFromClip;
@property (nonatomic, strong) NSMutableArray *mudetails;

@property (nonatomic, strong) NSString *isfromWhere;
@property (nonatomic, strong) UIBarButtonItem *refreshBarItem;
@property (nonatomic, strong) SwipeView *swipeView;

@property (nonatomic, strong) UIBarButtonItem *clipButtonItem;
@property (nonatomic, strong) UIBarButtonItem *fontButtonItem;

@property (nonatomic, assign) NADoc *topPageDoc;
@property (nonatomic, strong) NSMutableDictionary *regionDic;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) NSMutableArray *clipDataSource;
//@property (nonatomic, assign)NSInteger noteNumber;
//@property (nonatomic, strong) NSMutableDictionary *NoteArray;
- (void)setHorToolBar;
- (void)setVerToolBar;
@end

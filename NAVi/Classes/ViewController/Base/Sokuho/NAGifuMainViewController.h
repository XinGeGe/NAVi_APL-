//
//  NAGifuMainViewController.h
//  NAVi
//
//  Created by y fs on 15/7/14.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NABaseViewController.h"
#import "SwipeView.h"
#import "NASDoc.h"
#import "NAGifuSWView.h"
#import "KxMenu.h"

@interface NAGifuMainViewController : NABaseViewController<SwipeViewDataSource,SwipeViewDelegate>{
    NSMutableDictionary *searchdic;
    BOOL isThefirst;
    BOOL isSearchNoteAPI;
}
@property (nonatomic, strong) SwipeView *swipeView;
@property (nonatomic, strong)NSString *isfromWhere;
@property (nonatomic, assign)CGFloat fontSize;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *noteArray;
@property (nonatomic, strong) NSArray *sdocarray;
@property (nonatomic, strong) NASDoc *currentsdoc;
@property (nonatomic, strong) NSString *myserachtext;
@property (nonatomic, strong) NSString *fromdate;
@property (nonatomic, strong) NSString *todate;


@property (nonatomic, assign) UIInterfaceOrientation oldFromInterfaceOrientation;
@property (nonatomic, assign) UIInterfaceOrientation oldToInterfaceOrientation;
@end

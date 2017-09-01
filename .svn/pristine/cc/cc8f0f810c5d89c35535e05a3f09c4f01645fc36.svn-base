//
//  NAExpansionView.h
//  NAVi
//
//  Created by y fs on 15/5/11.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGWindowView.h"
#import "BRScrollBarController.h"

@protocol NACheckDelegate
-(void)selcetClickName:(NSString *)myname MyView:(UIView *)myView;
@end

@interface NACheckListView : UIView<UITableViewDelegate,UITableViewDataSource,BRScrollBarControllerDelegate>

@property(assign,nonatomic)id<NACheckDelegate> delegate;

@property (nonatomic, readonly, strong) BRScrollBarController *brScrollBarController;
@property (nonatomic,strong)UITableView *mytableview;
@property (nonatomic,assign)NSArray *checkarray;
@property (nonatomic,readwrite)NSInteger seclectindex;
@property (nonatomic,strong)UIView *mybackview;
-(void)show;
@end

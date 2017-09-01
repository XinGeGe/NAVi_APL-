//
//  NATopPageUIViewController.h
//  NAVi
//
//  Created by y fs on 15/12/2.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NALoginAlertView.h"
#import "NADocCell.h"
#import "NADocPadCell.h"
#import "TOWebViewController.h"
#import "NAHomeViewController.h"
#import "NALoginClient.h"
#import "NAAgreementViewController.h"
#import "NASettingViewController.h"




typedef void(^selectedDoc)(NADoc *obj);
@interface NATopPageUIViewController : NABaseViewController<UITableViewDataSource,UITableViewDelegate,NALoginAlertViewDelegate,NAAgreementViewDelegate,UIWebViewDelegate>
@property (nonatomic, strong) UITableView *tView;
@property (nonatomic, strong) NSMutableArray *topPageArray;
@property (nonatomic, strong) selectedDoc selectedDocCompletionBlock;
@property (nonatomic, assign)BOOL isLoginToTop;
@property (nonatomic, strong) UIWebView *mywebview;
@end

//
//  NAAgreementViewController.h
//  NAVi
//
//  Created by y fs on 15/12/2.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NAAgreementViewDelegate
-(void)IAgree;

@end
@interface NAAgreementViewController : NABaseViewController<UIWebViewDelegate>
@property(assign,nonatomic)id<NAAgreementViewDelegate> delegate;
@property (nonatomic,strong)UIWebView *myWebView;
@property (nonatomic,strong)UIButton *agreeBtn;
@property (nonatomic,strong)UIButton *notAgreeBtn;
@property (nonatomic,strong)UIButton *OkBtn;
@end

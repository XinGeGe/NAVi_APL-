//
//  NALoginAlertView.h
//  NAVi
//
//  Created by y fs on 15/12/2.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NALoginAlertViewDelegate
-(void)loginClick:(NSString *)username Password:(NSString *)password;
-(void)cancelLoginClick;
@end
@interface NALoginAlertView : UIView<UITextFieldDelegate>{
     AGWindowView *windowView;
}
@property(assign,nonatomic)id<NALoginAlertViewDelegate> delegate;

@property (nonatomic,readwrite)BOOL isBgToDismiss;
@property (nonatomic,readwrite)BOOL isShowCancelBtn;
@property (nonatomic,strong)UIView *myAlertView;
@property (nonatomic,strong)UILabel *loginInfoLabel;
@property (nonatomic,strong)UITextField *usernameTF;
@property (nonatomic,strong)UILabel *loginPassLabel;
@property (nonatomic,strong)UITextField *passwordTF;
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIView *mybackview;

-(void)show;
-(void)dismissMyview;
-(void)setCancelBtnHidden;
@end

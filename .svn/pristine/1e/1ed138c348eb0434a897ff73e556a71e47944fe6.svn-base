//
//  NALoginAlertView.m
//  NAVi
//
//  Created by y fs on 15/12/2.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import "NALoginAlertView.h"
#import "FontUtil.h"
@implementation NALoginAlertView

@synthesize delegate;
@synthesize mybackview;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isBgToDismiss=YES;
        self.isShowCancelBtn=YES;
        [self initViews];
        
    }
    
    return self;
}
- (void)dismissClick:(UITapGestureRecognizer *)recognizer
{
    if (self.isBgToDismiss) {
        [self dismissMyview];
    }
}
-(void)dismissMyview{
    
    [windowView removeFromSuperview];
}
-(void)initViews{
    mybackview=[[UIView alloc]init];
    mybackview.alpha=0.4;
    mybackview.backgroundColor=[UIColor whiteColor];
    [mybackview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissClick:)]];
    [self addSubview:mybackview];
    
    _myAlertView=[[UIView alloc]init];
    _myAlertView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_myAlertView];
    
    _loginInfoLabel=[[UILabel alloc]init];
    _loginInfoLabel.text=@"ユーザーID";
    _loginInfoLabel.font = [FontUtil systemFontOfSize:13];
    [_myAlertView addSubview:_loginInfoLabel];
    
    _usernameTF=[[UITextField alloc]init];
    _usernameTF.delegate=self;
    _usernameTF.layer.borderColor = [UIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:250.0/255.0 alpha:1].CGColor;
    _usernameTF.layer.borderWidth = 1.0;
    _usernameTF.layer.cornerRadius = 10;
    _usernameTF.font = [FontUtil systemFontOfSize:14];
    _usernameTF.placeholder=NSLocalizedString(@"usernamePH", nil);
    _usernameTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    _usernameTF.leftViewMode = UITextFieldViewModeAlways;
    [_myAlertView addSubview:_usernameTF];

    
    _loginPassLabel=[[UILabel alloc]init];
    _loginPassLabel.text=@"ユーザパスワード";
    _loginPassLabel.font = [FontUtil systemFontOfSize:13];
    [_myAlertView addSubview:_loginPassLabel];
    
    
    _passwordTF=[[UITextField alloc]init];
    _passwordTF.delegate=self;
    _passwordTF.secureTextEntry=YES;
    _passwordTF.layer.borderColor = [UIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:250.0/255.0 alpha:1].CGColor;
    _passwordTF.layer.borderWidth = 1.0;
    _passwordTF.layer.cornerRadius = 10;
    _passwordTF.font = [FontUtil systemFontOfSize:14];
    _passwordTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    _passwordTF.placeholder=NSLocalizedString(@"User PassWord", nil);
    [_myAlertView addSubview:_passwordTF];
    
    _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setImage:[UIImage imageNamed:@"24_btnLogIn"] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [_myAlertView addSubview:_loginBtn];
    
    _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.hidden=NO;
    [_cancelBtn setImage:[UIImage imageNamed:@"25_btnCancel"] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [_myAlertView addSubview:_cancelBtn];

    // TODO
    _usernameTF.text = @"komei";
    _passwordTF.text = @"komei123";

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

-(void)loginAction{
    [self.usernameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    [self.delegate loginClick:_usernameTF.text Password:_passwordTF.text];
    
}
-(void)cancelAction{
    
        [self.delegate cancelLoginClick];
        [self dismissMyview];
}
-(void)show{
    windowView = [[AGWindowView alloc] initAndAddToKeyWindow];
    self.frame =windowView.bounds;
    windowView.supportedInterfaceOrientations = AGInterfaceOrientationMaskAll;
    [windowView addSubview:self];
    
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIView *)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        self.frame = object.bounds;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat screenWidth = self.frame.size.width;
    CGFloat screenHeight = self.frame.size.height;
    mybackview.frame=self.frame;
    _myAlertView.frame=self.frame;
   
    _loginInfoLabel.frame=CGRectMake(20, screenHeight/2-110, screenWidth-40, 20);
    _usernameTF.frame=CGRectMake(20, screenHeight/2-80, screenWidth-40, 30);
    _loginPassLabel.frame=CGRectMake(20, screenHeight/2-30, screenWidth-40, 20);
    _passwordTF.frame=CGRectMake(20, screenHeight/2, screenWidth-40, 30);

    
    
    if (self.isShowCancelBtn) {
        _loginBtn.frame=CGRectMake(screenWidth/2-60, screenHeight/2+50, 100, 30);
        _cancelBtn.frame=CGRectMake(screenWidth/2-60, screenHeight/2+100, 100, 30);
        
    }else{
        _loginBtn.frame=CGRectMake(screenWidth/2, 270, 100, 40);
    }
    
}
-(void)setCancelBtnHidden{
    CGFloat screenWidth = self.frame.size.width;
    self.cancelBtn.hidden=YES;
    _loginBtn.frame=CGRectMake(screenWidth/2-80, 270, 100, 40);
}
@end

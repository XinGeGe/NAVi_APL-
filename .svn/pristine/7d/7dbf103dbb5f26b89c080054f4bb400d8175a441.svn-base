//
//  NALoginReminAlertView.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/13.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NALoginReminAlertView.h"
#import "FontUtil.h"
@implementation NALoginReminAlertView
@synthesize delegate;
@synthesize mybackview;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        
    }
    
    return self;
}
- (void)dismissClick:(UITapGestureRecognizer *)recognizer
{
    [self dismissMyview];
}
-(void)dismissMyview{
    [windowView removeFromSuperview];
    
}
-(void)initViews{
    mybackview=[[UIView alloc]init];
    mybackview.alpha=0.4;
    mybackview.backgroundColor=[UIColor blackColor];
    [mybackview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissClick:)]];
    [self addSubview:mybackview];
    
    _myAlertView=[[UIView alloc]init];
    _myAlertView.backgroundColor=[UIColor whiteColor];
    _myAlertView.layer.cornerRadius = 10;
    _myAlertView.layer.masksToBounds = YES;
    [self addSubview:_myAlertView];
    
    _titleLabel=[[UILabel alloc]init];
    _titleLabel.backgroundColor=[UIColor whiteColor];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    _titleLabel.font=[FontUtil boldSystemFontOfSize:15];
    _titleLabel.numberOfLines = 2;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.text=@"利用権限がありません";
    _titleLabel.textColor=[UIColor blackColor];
    [_myAlertView addSubview:_titleLabel];
    
    
    
    _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    if (_haveJurisdiction == 0) {
        //haveJurisdiction
        [_loginBtn setImage:[UIImage imageNamed:@"24_btnLogIn"] forState:UIControlStateNormal];
    }else{
        //noJurisdiction
        [_loginBtn setImage:[UIImage imageNamed:@"ok"] forState:UIControlStateNormal];
    }
    [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [_myAlertView addSubview:_loginBtn];
    
    _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:NSLocalizedString(@"canceltitle", nil) forState:UIControlStateNormal];
    self.cancelBtn.hidden=NO;
    [_cancelBtn setImage:[UIImage imageNamed:@"25_btnCancel"] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [_myAlertView addSubview:_cancelBtn];
    if (_haveJurisdiction == 0) {
        _cancelBtn.hidden = NO;
    }else{
        _cancelBtn.hidden = YES;
    }
    
    
}

-(void)loginAction{
    [self dismissMyview];
    if (_haveJurisdiction == 0) {
        [self.delegate loginClick];
    }
}
-(void)cancelAction{
    
    [self.delegate cancelLoginClick];
    [self dismissMyview];
}
-(void)show{
    windowView = [[AGWindowView alloc] initAndAddToKeyWindow];
    self.frame =windowView.bounds;
    if (_haveJurisdiction == 0) {
        //haveJurisdiction
        
        [_loginBtn setImage:[UIImage imageNamed:@"24_btnLogIn"] forState:UIControlStateNormal];
         _cancelBtn.hidden = NO;
    }else{
        //noJurisdiction
        [_loginBtn setImage:[UIImage imageNamed:@"ok"] forState:UIControlStateNormal];
        _cancelBtn.hidden = YES;
    }
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
    CGFloat myAlertViewHeight=240;
    _myAlertView.frame=CGRectMake(40, (screenHeight-myAlertViewHeight)/2, screenWidth-80, myAlertViewHeight);
    _titleLabel.frame=CGRectMake(20, 30, screenWidth-120, 60);
    _loginBtn.frame=CGRectMake(screenWidth/2-90, 120, 100, 30);
    _cancelBtn.frame=CGRectMake(screenWidth/2-90, 180, 100, 30);
    
}

@end

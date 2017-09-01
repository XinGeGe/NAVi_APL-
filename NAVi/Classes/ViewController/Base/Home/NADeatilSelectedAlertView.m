//
//  NADeatilSelectedAlertView.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/13.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NADeatilSelectedAlertView.h"
#import "FontUtil.h"
@implementation NADeatilSelectedAlertView

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
    mybackview.backgroundColor=[UIColor clearColor];
    mybackview.layer.cornerRadius = 10;
    mybackview.layer.masksToBounds = YES;
    [mybackview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissClick:)]];
    [self addSubview:mybackview];
    
    _myAlertView=[[UIImageView alloc]init];
    [_myAlertView setImage:[UIImage imageNamed:@"detailSelected"]];
    _myAlertView.userInteractionEnabled = YES;
    [mybackview addSubview:_myAlertView];
    
    _clipLab = [[UILabel alloc]init];
    _clipLab.text = @"スクラップ";
    _clipLab.textAlignment = NSTextAlignmentRight;
    _clipLab.font = [FontUtil systemFontOfSize:10];
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clipAction)];
    [_clipLab addGestureRecognizer:labelTapGestureRecognizer];
    _clipLab.userInteractionEnabled = YES;
    [_myAlertView addSubview:_clipLab];
    
    _printLab = [[UILabel alloc]init];
    _printLab.text = @"フリント";
    _printLab.textAlignment = NSTextAlignmentRight;
    _printLab.font = [FontUtil systemFontOfSize:10];
    UITapGestureRecognizer *labelTapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(printAction)];
    [_printLab addGestureRecognizer:labelTapGestureRecognizer2];
    _printLab.userInteractionEnabled = YES;
    [_myAlertView addSubview:_printLab];
    
    _shareLab = [[UILabel alloc]init];
    _shareLab.text = @"シェア";
    _shareLab.textAlignment = NSTextAlignmentRight;
    _shareLab.font = [FontUtil systemFontOfSize:10];
    UITapGestureRecognizer *labelTapGestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction:)];
    [_shareLab addGestureRecognizer:labelTapGestureRecognizer3];
    _shareLab.userInteractionEnabled = YES;
    [_myAlertView addSubview:_shareLab];
    
    _clipBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_clipBtn setImage:[UIImage imageNamed:@"16_blue"] forState:UIControlStateNormal];
    [_clipBtn addTarget:self action:@selector(clipAction) forControlEvents:UIControlEventTouchUpInside];
    [_myAlertView addSubview:_clipBtn];
    
    _printBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_printBtn setImage:[UIImage imageNamed:@"17_blue"] forState:UIControlStateNormal];
    [_printBtn addTarget:self action:@selector(printAction) forControlEvents:UIControlEventTouchUpInside];
    [_myAlertView addSubview:_printBtn];
    
    _shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_shareBtn setImage:[UIImage imageNamed:@"18_blue"] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [_myAlertView addSubview:_shareBtn];
    
    
}

-(void)clipAction{
    [self.delegate clipClick];
    
}
-(void)printAction{
    [self.delegate printClick];
}
- (void)shareAction:(UIButton *)btn{
    [self.delegate shareClick:btn];
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
    mybackview.frame=self.frame;
    [_myAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mybackview.mas_right).offset(18);;
        make.bottom.equalTo(mybackview.mas_bottom).offset(-40);
        make.width.height.mas_equalTo(150);
    }];
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_myAlertView.mas_right).offset(-28);;
        make.bottom.equalTo(mybackview.mas_bottom).offset(-40-30);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [_shareLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_shareBtn.mas_left).offset(-2);;
        make.bottom.equalTo(mybackview.mas_bottom).offset(-40-30);
        make.left.equalTo(_myAlertView.mas_left).offset(25);
        make.height.mas_equalTo(30);
    }];

    
    [_printBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_myAlertView.mas_right).offset(-28);;
        make.bottom.equalTo(mybackview.mas_bottom).offset(-40-30-35);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [_printLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_printBtn.mas_left).offset(-2);;
        make.bottom.equalTo(mybackview.mas_bottom).offset(-40-30-35);
        make.left.equalTo(_myAlertView.mas_left).offset(30);
        make.height.mas_equalTo(30);
    }];
    
    
    [_clipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_myAlertView.mas_right).offset(-28);;
        make.bottom.equalTo(mybackview.mas_bottom).offset(-40-30-35-35);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [_clipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_clipBtn.mas_left).offset(-2);;
        make.bottom.equalTo(mybackview.mas_bottom).offset(-40-30-35-35);
        make.left.equalTo(_myAlertView.mas_left).offset(20);
        make.height.mas_equalTo(30);
    }];
    
}

@end

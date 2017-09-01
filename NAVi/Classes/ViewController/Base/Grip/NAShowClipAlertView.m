//
//  NAShowClipAlertView.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/28.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NAShowClipAlertView.h"
#import "FontUtil.h"
@implementation NAShowClipAlertView
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
    
    _myAlertView=[[UIView alloc]init];
    _myAlertView.backgroundColor=[UIColor whiteColor];
    _myAlertView.layer.cornerRadius = 5;
    _myAlertView.layer.masksToBounds = YES;
    [self addSubview:_myAlertView];
    

    
    _addClipBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _addClipBtn.layer.cornerRadius = 5;
    _addClipBtn.layer.masksToBounds = YES;
    _addClipBtn.layer.borderWidth=1;
    _addClipBtn.layer.borderColor=[UIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:250.0/255.0 alpha:1].CGColor;
    [_addClipBtn addTarget:self action:@selector(addClipBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_myAlertView addSubview:_addClipBtn];
    
    _addClipImageView = [[UIImageView alloc]init];
    _addClipImageView.backgroundColor = [UIColor whiteColor];
    _addClipImageView.image = [UIImage imageNamed:@"12_blue"];
    [_addClipBtn addSubview:_addClipImageView];
    
}
- (void)addClipBtnAction{
    [self.delegate addClipClick];
}
//- (void)clipOneBtnAction:(UIButton *)btn{
//    [self.delegate chooseclipOneClick:btn];
//}
//- (void)clipTwoBtnAction:(UIButton *)btn{
//    [self.delegate chooseclipTwoClick:btn];
//}
//- (void)clipThreeBtnAction:(UIButton *)btn{
//    [self.delegate chooseclipThreeClick:btn];
//}

- (void)clipBtnAction:(UIButton *)btn {
    NSInteger selectTag = [NASaveData getClipSelectedBtnTag];
 
        if (selectTag == btn.tag) {
            [NASaveData saveClipSelectedBtnTag:999999];
        } else {
            [NASaveData saveClipSelectedBtnTag:btn.tag];
        }
    
    [self.delegate chooseClipButton:btn];
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
    
    if (isPhone) {
        if ([Util screenSize].width >  [Util screenSize].height) {
            [_myAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(mybackview.mas_right).offset(-[Util screenSize].width/5/2);
                make.bottom.equalTo(mybackview.mas_bottom).offset(-50);
                make.height.mas_equalTo(20*self.btnArray.count + 20);
                make.width.mas_equalTo(60);
            }];
        }else{
            [_myAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(mybackview.mas_right).offset(-[Util screenSize].width/5);
                make.bottom.equalTo(mybackview.mas_bottom).offset(-50);
                make.height.mas_equalTo(20*self.btnArray.count + 20);
                make.width.mas_equalTo(60);
            }];
        }
    } else {
        if ([Util screenSize].width >  [Util screenSize].height) {
            [_myAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(mybackview.mas_right).offset(-[Util screenSize].width/5/2+30);
                make.bottom.equalTo(mybackview.mas_bottom).offset(-60);
                make.height.mas_equalTo(20*self.btnArray.count*2 + 40);
                make.width.mas_equalTo(60*2);
            }];
        }else{
            [_myAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(mybackview.mas_right).offset(-[Util screenSize].width/5);
                make.bottom.equalTo(mybackview.mas_bottom).offset(-60);
                make.height.mas_equalTo(20*self.btnArray.count*2 + 40);
                make.width.mas_equalTo(60*2);
            }];
        }
        
    }
    
    UIButton *lastBtn = nil;
    
    NSInteger selectedTag = [NASaveData getClipSelectedBtnTag];
    
    if (self.btnArray.count > 0) {
        for (int i = 0; i < self.btnArray.count; i++) {
            UIButton *clipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            clipBtn.layer.cornerRadius = 5;
            clipBtn.layer.masksToBounds = YES;
            clipBtn.layer.borderWidth=1;
            
            [clipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            NAClipDoc *dicBtn = self.btnArray[i];
            NSString *btnTitle = dicBtn.tagName;
            [clipBtn setTitle:btnTitle forState:UIControlStateNormal];
            clipBtn.layer.borderColor=[UIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:250.0/255.0 alpha:1].CGColor;
            clipBtn.tag = dicBtn.tagid.integerValue;
            [clipBtn addTarget:self action:@selector(clipBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_myAlertView addSubview:clipBtn];
            
            UIImage *btnBgImage = [self createImageWithColor:[UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1]];
            
            [clipBtn setBackgroundImage:btnBgImage forState:UIControlStateSelected];
            
            if (clipBtn.tag == selectedTag) {
                [clipBtn setSelected:YES];
            }
            
            if (isPhone) {
                clipBtn.titleLabel.font = [FontUtil systemFontOfSize:10];
                
                [clipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (lastBtn) {
                        make.bottom.equalTo(lastBtn.mas_top);
                    } else {
                        make.bottom.equalTo(_myAlertView.mas_bottom);
                    }
                    make.left.right.equalTo(_myAlertView);
                    make.height.mas_equalTo(20);
                }];
            } else {
                clipBtn.titleLabel.font = [FontUtil systemFontOfSize:15];
                
                [clipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (lastBtn) {
                        make.bottom.equalTo(lastBtn.mas_top);
                    } else {
                        make.bottom.equalTo(_myAlertView.mas_bottom);
                    }
                    make.left.right.equalTo(_myAlertView);
                    make.height.mas_equalTo(20*2);
                }];
            }
            
            lastBtn = clipBtn;
        }
        
        if (lastBtn) {
            if (isPhone) {
                [_addClipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(lastBtn.mas_top);
                    make.left.right.equalTo(_myAlertView);
                    make.height.mas_equalTo(20);
                }];
                
                
                [_addClipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_addClipBtn.mas_top).offset(5);
                    make.centerX.equalTo(_addClipBtn.mas_centerX);
                    make.width.mas_equalTo(10);
                    make.height.mas_equalTo(10);
                }];
            } else {
                [_addClipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(lastBtn.mas_top);
                    make.left.right.equalTo(_myAlertView);
                    make.height.mas_equalTo(20*2);
                }];
                
                
                [_addClipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_addClipBtn.mas_top).offset(10);
                    make.centerX.equalTo(_addClipBtn.mas_centerX);
                    make.width.mas_equalTo(10*2);
                    make.height.mas_equalTo(10*2);
                }];
            }
        }
    } else {
        [_myAlertView addSubview:_addClipBtn];
        if (isPhone) {
            [_addClipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_myAlertView.mas_bottom);
                make.left.right.equalTo(_myAlertView);
                make.height.mas_equalTo(20);
            }];
            
            
            [_addClipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_addClipBtn.mas_top).offset(5);
                make.centerX.equalTo(_addClipBtn.mas_centerX);
                make.width.mas_equalTo(10);
                make.height.mas_equalTo(10);
            }];
        } else {
            [_addClipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_myAlertView.mas_bottom);
                make.left.right.equalTo(_myAlertView);
                make.height.mas_equalTo(20*2);
            }];
            
            
            [_addClipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_addClipBtn.mas_top).offset(10);
                make.centerX.equalTo(_addClipBtn.mas_centerX);
                make.width.mas_equalTo(10*2);
                make.height.mas_equalTo(10*2);
            }];
        }
    }

}

-(UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



@end

//
//  NAHomeProgressView.m
//  NAVi
//
//  Created by xiaoyu.zhang on 15/5/15.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NAHomeProgressView.h"
#import "NADefine.h"
#import "FontUtil.h"
@interface NAHomeProgressView()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblStatus;

@property (nonatomic,assign) CGRect rect;


@end

@implementation NAHomeProgressView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)updateViews{
    _progressData.center =CGPointMake([Util screenSize].width-55,PROGRESS_HEIGHT/2);
   // _progressData.bounds =CGRectMake([Util screenSize].width-105,(PROGRESS_HEIGHT-_progressData.frame.size.height)/2, 100, 20);
   
}
-(void) initViews
{
    self.backgroundColor = [UIColor grayColor];
    _rect = [UIScreen mainScreen].bounds;
    
    _lblTitle =[[UILabel alloc]initWithFrame:CGRectMake(2,0,100,60)];
    [_lblTitle setFont:[FontUtil systemFontOfSize:8]];
    [self addSubview:_lblTitle];
    
    _progressData = [[UIProgressView alloc]init];
    //[_progressData sizeThatFits:CGSizeMake(100, 60)];
    _progressData.progressViewStyle = UIProgressViewStyleDefault;
    _progressData.trackTintColor = [UIColor darkGrayColor];
    _progressData.progressTintColor = [UIColor orangeColor];
    _progressData.progress = 0.0f;

    _progressData.frame =CGRectMake(_rect.size.width-105,(PROGRESS_HEIGHT-_progressData.frame.size.height)/2, 100, 60);
    _progressData.transform = CGAffineTransformMakeScale(1.0f,3.0f);
    
    [self addSubview:_progressData];
    
    _lblStatus = [[UILabel alloc]init];
    [_lblStatus setFont:[FontUtil systemFontOfSize:8]];

    [self addSubview:_lblStatus];
}


-(void) initProgressNum
{
    _progressData.progress= 0.0f;
}

-(void) setProgressNum:(CGFloat) value
{
    [self.progressData setProgress:value animated:YES];
}

-(void) setTitleText:(NSString *)value
{
    self.lblTitle.text = value;
    
    
    self.lblTitle.frame = CGRectMake(5, (PROGRESS_HEIGHT-_lblTitle.frame.size.height)/2, self.lblTitle.frame.size.width, self.lblTitle.frame.size.height);
    
}

-(void)setStatus:(NSString *)value
{
    self.lblStatus.text = value;
    

    _lblStatus.frame = CGRectMake([Util screenSize].width-_progressData.frame.size.width-_lblStatus.frame.size.width-10, (PROGRESS_HEIGHT-_lblStatus.frame.size.height)/2, _lblStatus.frame.size.width, _lblStatus.frame.size.height);
    [_lblStatus sizeToFit];
}


@end

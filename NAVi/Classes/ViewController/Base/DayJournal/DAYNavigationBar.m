//
//  DAYNavigationBar.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/12.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "DAYNavigationBar.h"
#import "FontUtil.h"
@interface DAYNavigationBar ()

@end

@implementation DAYNavigationBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.font = [FontUtil systemFontOfSize:25];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(40);
    }];
    
    
    
    
    
    self.prevButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.prevButton setImage:[UIImage imageNamed:@"15_glay"] forState:UIControlStateNormal];
    [self.prevButton addTarget:self action:@selector(prevButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.prevButton];
    [self.prevButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.right.equalTo(self.textLabel.mas_left).offset(-20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);

    }];
    self.prevTitle = [[UILabel alloc] init];
    self.prevTitle.textColor = [UIColor colorWithRed:158.0/255.0 green:156.0/255.0 blue:156.0/255.0 alpha:1];
    self.prevTitle.font = [FontUtil systemFontOfSize:15];
    self.prevTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.prevTitle];
    [self.prevTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.right.equalTo(self.prevButton.mas_left).offset(-20);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextButton setImage:[UIImage imageNamed:@"14_glay"] forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.textLabel.mas_right).offset(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        
    }];
    self.nextTitle = [[UILabel alloc] init];
    self.nextTitle.textColor = [UIColor colorWithRed:158.0/255.0 green:156.0/255.0 blue:156.0/255.0 alpha:1];
    self.nextTitle.font = [FontUtil systemFontOfSize:15];
    self.nextTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nextTitle];
    [self.nextTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.nextButton.mas_right).offset(20);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(49);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    self.localLab = [[UILabel alloc]init];
    self.localLab.text = @"地方版あり";
    self.localLab.textColor = [UIColor colorWithRed:158.0/255.0 green:156.0/255.0 blue:156.0/255.0 alpha:1];
    self.localLab.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.localLab];
    [self.localLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineView.mas_top).offset(-2);
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    
    self.localImg = [[UIImageView alloc]init];
    self.localImg.image = [UIImage imageNamed:@"30_star"];
    [self addSubview:self.localImg];
    [self.localImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.localLab.mas_top).offset(5);
        make.right.equalTo(self.localLab.mas_left).offset(-2);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    
    self.nextButton.hidden = YES;
    self.nextTitle.hidden = YES;
    self.prevButton.hidden = YES;
    self.prevTitle.hidden = YES;
}

- (void)prevButtonDidTap:(id)sender {
    self.lastCommand = DAYNaviagationBarCommandPrevious;
    [self sendActionsForControlEvents:UIControlEventValueChanged];

}

- (void)nextButtonDidTap:(id)sender {
    self.lastCommand = DAYNaviagationBarCommandNext;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end

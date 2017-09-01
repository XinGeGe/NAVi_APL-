//
//  ChooseClipCollectionViewCell.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/24.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "ChooseClipCollectionViewCell.h"
#import "FontUtil.h"
@implementation ChooseClipCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _clipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clipBtn.layer.masksToBounds = YES;
        _clipBtn.layer.cornerRadius = 10;
        _clipBtn.layer.borderWidth=1;
        if (isPhone) {
            [_clipBtn.titleLabel setFont:[FontUtil systemFontOfSize:10]];
        }else{
            [_clipBtn.titleLabel setFont:[FontUtil systemFontOfSize:15]];
        }
        
        [self.contentView addSubview:_clipBtn];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (isPhone) {
        [_clipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.height.mas_equalTo(20);
        }];
    }else{
        [_clipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.height.mas_equalTo(40);
        }];
    }
    
}

@end

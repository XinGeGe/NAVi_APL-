//
//  NAEditClipTableViewCell.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/28.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NAEditClipTableViewCell.h"
#import "FontUtil.h"
@implementation NAEditClipTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:245/255.0 alpha:1];
        
        _clipView = [[UIView alloc]init];
        _clipView.backgroundColor = [UIColor whiteColor];
        _clipView.layer.cornerRadius = 5;
        _clipView.layer.masksToBounds = YES;
        _clipView.layer.borderWidth=1;
        _clipView.layer.borderColor=[UIColor whiteColor].CGColor;

        [self.contentView addSubview:self.clipView];
        
        self.clipTextField = [[UITextField alloc]init];
        self.clipTextField.font = [FontUtil systemFontOfSize:13];
        [_clipView addSubview:self.clipTextField];
        
        self.deleteClipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteClipBtn setImage:[UIImage imageNamed:@"21_glay"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.deleteClipBtn];
        

    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.clipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(2);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
    }];
    [self.clipTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.left.equalTo(_clipView.mas_left).offset(5);
        make.top.equalTo(_clipView.mas_top);
    }];
    [self.deleteClipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.top.equalTo(_clipView.mas_top).offset(8);
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

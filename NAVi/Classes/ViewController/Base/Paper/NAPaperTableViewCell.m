//
//  NAPaperTableViewCell.m
//  NAVi
//
//  Created by dxc on 15-3-4.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NAPaperTableViewCell.h"
#import "NADefine.h"

#define IPHONE_LEFT_MARGIN 20
#define IPHONE_RIGHT_MARGIN 10
#define IPHONE_VIEW_TOP_MARGIN 15

@implementation NAPaperTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateViews];
}

#pragma mark - utility -
#pragma mark

- (void)initViews
{
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
}

- (void)updateViews
{
    CGFloat width = self.frame.size.width / 2;
    CGFloat height = self.frame.size.height;
//    if (!isPad) {
        self.leftView.frame = CGRectMake(IPHONE_LEFT_MARGIN, IPHONE_RIGHT_MARGIN, width - IPHONE_LEFT_MARGIN - IPHONE_RIGHT_MARGIN, height - IPHONE_VIEW_TOP_MARGIN);
        self.rightView.frame = CGRectMake(width + IPHONE_RIGHT_MARGIN, IPHONE_RIGHT_MARGIN, width - IPHONE_LEFT_MARGIN - IPHONE_RIGHT_MARGIN, height - IPHONE_VIEW_TOP_MARGIN);
//    }
    
}

#pragma mark - layout -
#pragma mark

- (NAPaperCellView *)leftView
{
    if (!_leftView) {
        _leftView = [[NAPaperCellView alloc] initWithFrame:CGRectZero];
        _leftView.backgroundColor = [UIColor yellowColor];
    }
    return _leftView;
}

- (NAPaperCellView *)rightView
{
    if (!_rightView) {
        _rightView = [[NAPaperCellView alloc] initWithFrame:CGRectZero];
        _rightView.backgroundColor = [UIColor redColor];
    }
    return _rightView;
}

@end

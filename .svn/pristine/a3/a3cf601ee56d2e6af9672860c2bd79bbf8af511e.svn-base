//
//  NAPaperCellView.m
//  NAVi
//
//  Created by dxc on 15-3-4.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NAPaperCellView.h"

@interface NAPaperCellView ()

@property (nonatomic, strong) UIButton *downloadButton;

@end

@implementation NAPaperCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
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
    [self addSubview:self.imageView];
    [self addSubview:self.downloadButton];
}

- (void)updateViews
{
    self.imageView.frame = self.bounds;
    self.downloadButton.frame = self.bounds;
}


#pragma mark - layout -
#pragma mark

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}

- (UIButton *)downloadButton
{
    if (!_downloadButton) {
        _downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _downloadButton.frame = self.bounds;
        [_downloadButton addTarget:self action:@selector(downloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadButton;
}

#pragma mark - button action -
#pragma mark

- (void)downloadButtonAction:(id)sender
{
    NSLog(@"downloadButtonAction == %@",@(self.tag));
}

@end

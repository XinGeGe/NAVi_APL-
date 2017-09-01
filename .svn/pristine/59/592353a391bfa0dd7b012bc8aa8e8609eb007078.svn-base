//
//  DAYIndicatorView.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/12.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "DAYIndicatorView.h"

@interface DAYIndicatorView ()

@property (strong, nonatomic) CAShapeLayer *ellipseLayer;

@end

@implementation DAYIndicatorView

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    self.ellipseLayer = [CAShapeLayer layer];
    self.ellipseLayer.fillColor = self.color.CGColor;
    [self.layer addSublayer:self.ellipseLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.ellipseLayer.path = CGPathCreateWithEllipseInRect(self.bounds, nil);
    self.ellipseLayer.frame = self.bounds;
}

- (void)setColor:(UIColor *)color {
    self->_color = color;
    self.ellipseLayer.fillColor = color.CGColor;
}


@end

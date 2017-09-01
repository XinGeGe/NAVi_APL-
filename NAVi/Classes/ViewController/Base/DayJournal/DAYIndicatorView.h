//
//  DAYIndicatorView.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/12.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAYIndicatorView : UIView

@property (copy, nonatomic) UIColor *color;
@property (weak, nonatomic) UIView *attachingView;
@property (strong, nonatomic) NSString *selectDay;
@property (strong, nonatomic) NSString *selectMonth;
@end

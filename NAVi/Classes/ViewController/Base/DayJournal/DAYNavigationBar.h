//
//  DAYNavigationBar.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/12.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DAYNaviagationBarCommand) {
    DAYNaviagationBarCommandNoCommand = 0,
    DAYNaviagationBarCommandPrevious,
    DAYNaviagationBarCommandNext
};
@interface DAYNavigationBar : UIControl

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIButton *prevButton;
@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UILabel *prevTitle;
@property (strong, nonatomic) UILabel *nextTitle;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIImageView *localImg;
@property (strong, nonatomic) UILabel *localLab;
@property (assign, nonatomic) DAYNaviagationBarCommand lastCommand;

@end

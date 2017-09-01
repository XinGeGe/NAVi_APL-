//
//  DAYComponentView.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/12.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
@interface DAYComponentView : UIControl
@property (readonly) UILabel *textLabel;
@property (copy, nonatomic) UIColor *textColor;
@property (copy, nonatomic) UIColor *highlightTextColor;
@property (strong, nonatomic) EKEvent *containingEvent;
@property (strong, nonatomic) id representedObject;

@end

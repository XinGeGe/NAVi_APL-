//
//  NALoginReminAlertView.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/13.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NALoginReminAlertViewDelegate
-(void)loginClick;
-(void)cancelLoginClick;
@end
@interface NALoginReminAlertView : UIView{
    AGWindowView *windowView;
}
@property(assign,nonatomic)id<NALoginReminAlertViewDelegate> delegate;
@property (nonatomic,strong)UIView *mybackview;
@property (nonatomic,strong)UIView *myAlertView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,assign)NSInteger haveJurisdiction;
-(void)show;
-(void)dismissMyview;
@end

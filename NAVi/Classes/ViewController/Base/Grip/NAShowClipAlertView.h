//
//  NAShowClipAlertView.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/28.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NAShowClipAlertViewDelegate
-(void)addClipClick;
-(void)chooseclipOneClick:(UIButton *)sender;
-(void)chooseclipTwoClick:(UIButton *)sender;
-(void)chooseclipThreeClick:(UIButton *)sender;
-(void)chooseClipButton:(UIButton *)sender;
@end
@interface NAShowClipAlertView : UIView{
    AGWindowView *windowView;
}
@property(assign,nonatomic)id<NAShowClipAlertViewDelegate> delegate;
@property (nonatomic,strong)UIView *mybackview;
@property (nonatomic,strong)UIView *myAlertView;
@property (nonatomic,strong)UIButton *addClipBtn;
@property (nonatomic,strong)UIButton *clipOneBtn;
@property (nonatomic,strong)UIButton *clipTwoBtn;
@property (nonatomic,strong)UIImageView  *addClipImageView;
@property (nonatomic,strong)UIButton *clipThreeBtn;
// 数组
@property (nonatomic,strong)NSMutableArray *btnArray;
-(void)show;
-(void)dismissMyview;

@end

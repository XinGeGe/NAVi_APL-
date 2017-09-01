//
//  NoteViewPagerViewController.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/10.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NoteViewPagerViewController;
#pragma mark View Pager Delegate
@protocol  NoteViewPagerViewControllerDelegate <NSObject>
@optional
/**
 控制器结束滑动时调用该方法，返回当前显示的视图控制器
 */
-(void)viewPagerViewController:(NoteViewPagerViewController *)viewPager didFinishScrollWithCurrentViewController:(UIViewController *)viewController nowIndex:(NSInteger)index;
/**
 控制器将要开始滑动时调用该方法，返回当前将要滑动的视图控制器
 */
-(void)viewPagerViewController:(NoteViewPagerViewController *)viewPager willScrollerWithCurrentViewController:(UIViewController *)ViewController;

-(void)viewPagerViewController:(NoteViewPagerViewController *)viewPager selectNowIndex:(NSInteger)index;
@end

#pragma mark View Pager DataSource
@protocol NoteViewPagerViewControllerDataSource <NSObject>

@required
/**
 设置返回需要滑动的控制器数量
 */
-(NSInteger)numberOfViewControllersInViewPager:(NoteViewPagerViewController *)viewPager;
/**
 用来设置当前索引下返回的控制器
 */
-(UIViewController *)viewPager:(NoteViewPagerViewController *)viewPager indexOfViewControllers:(NSInteger)index;
/**
 给每一个控制器设置一个标题
 */
-(NSString *)viewPager:(NoteViewPagerViewController *)viewPager titleWithIndexOfViewControllers:(NSInteger)index;
@optional
/**
 设置控制器标题按钮的样式，如果不设置将使用默认的样式，选择为红色，不选中为黑色带有选中下划线
 */
-(UIButton *)viewPager:(NoteViewPagerViewController *)viewPager titleButtonStyle:(NSInteger)index;
/**
 设置控制器上面标题的高度
 */
-(CGFloat)heightForTitleOfViewPager:(NoteViewPagerViewController *)viewPager;
/**
 如果有需要还要在控制器标题顶上添加视图。用来设置控制器标题上面的头部视图
 */
-(UIView *)headerViewForInViewPager:(NoteViewPagerViewController *)viewPager;
/**
 设置头部视图的高度
 */
-(CGFloat)heightForHeaderOfViewPager:(NoteViewPagerViewController *)viewPager;
@end


@interface NoteViewPagerViewController : UIViewController
@property (nonatomic,weak) id<NoteViewPagerViewControllerDataSource>dataSource;
@property (nonatomic,weak) id<NoteViewPagerViewControllerDelegate>delegate;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, assign) NSInteger isfirst;
@property (nonatomic, assign) NSInteger nowIndex;

- (void)initViews;
- (void)updateViews;
- (void)setNavMainTitle:(NSString *)mtitle
               subTitle:(NSString *)sTitle;
@end
#pragma mark View Controller Title Button

@interface LSYViewPagerTitleButton : UIButton

@end
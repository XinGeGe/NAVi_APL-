//
//  NoteViewPagerViewController.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/10.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NoteViewPagerViewController.h"
#import "FontUtil.h"
@interface NoteViewPagerViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
{
    NSInteger numberOfViewController;   //VC的总数量
    NSArray *arrayOfViewController;     //存放VC的数组
    NSArray *arrayOfViewControllerButton;    //存放VC Button的数组
    UIView *headerView;     //头部视图
    CGRect oldRect;   //用来保存title布局的Rect
    LSYViewPagerTitleButton *oldButton;
    NSInteger pendingVCIndex;   //将要显示的View Controller 索引
    NSMutableArray *ArrayOfBtn;
    NSInteger btnNumber;
}
@property (nonatomic,strong) UIPageViewController *pageViewController;
@property (nonatomic,strong) UIScrollView *titleBackground;
@property (nonatomic, strong) UIView *leftCustomView;
@end

@implementation NoteViewPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isfirst = 0;
    [self initViews];
    
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self updateViews];
}

/**
 * view初期化
 *
 */
- (void)initViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.view addSubview:self.titleBackground];
    
}

/**
 * view更新
 *
 */
- (void)updateViews
{

    if (ArrayOfBtn.count && ((UIButton *)ArrayOfBtn.lastObject).frame.origin.x + ((UIButton *)ArrayOfBtn.lastObject).frame.size.width<[Util screenSize].width) //当所有按钮尺寸小于屏幕宽度的时候要重新布局
    {
    oldRect = CGRectZero;
    CGFloat padding = self.view.frame.size.width-(((UIButton *)ArrayOfBtn.lastObject).frame.origin.x + ((UIButton *)ArrayOfBtn.lastObject).frame.size.width);
    for (LSYViewPagerTitleButton *button in ArrayOfBtn) {
        button.frame = CGRectMake(oldRect.origin.x+oldRect.size.width, 0,button.frame.size.width+padding/ArrayOfBtn.count+10, [self.dataSource respondsToSelector:@selector(heightForTitleOfViewPager:)]?[self.dataSource heightForTitleOfViewPager:self]:0);
        oldRect = button.frame;
    }
    }
    [self viewDidLayoutSubviews];
}

/**
 * Titleを設定
 *
 */
- (void)setNavMainTitle:(NSString *)mtitle subTitle:(NSString *)sTitle
{
    NSInteger titleWidth = 200;
    if (isPad) {
        titleWidth = 400;
    }
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleWidth, self.navigationController.navigationBar.frame.size.height)];
    titleView.backgroundColor = [UIColor clearColor];
    UILabel *mLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth, 14)];
    mLabel.backgroundColor = [UIColor clearColor];
    mLabel.textAlignment = NSTextAlignmentCenter;
    mLabel.font = [FontUtil systemFontOfSize:12];
    UILabel *sLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, titleWidth, 20)];
    sLabel.backgroundColor = [UIColor clearColor];
    sLabel.textAlignment = NSTextAlignmentCenter;
    sLabel.font = [FontUtil systemFontOfSize:16];
    sLabel.textColor = [UIColor blackColor];
    
    [titleView addSubview:mLabel];
    [titleView addSubview:sLabel];
    
    if ([NASaveData getIsPublication]) {
        UILabel *publication=[[UILabel alloc]init];
        publication.text=NSLocalizedString(@"publication", nil);
        publication.textColor=[UIColor redColor];
        if (isPad) {
            publication.frame=CGRectMake(0, 15, 100, 20);
            publication.font=[FontUtil systemFontOfSize:14];
        }else{
            mLabel.frame=CGRectMake(0, 0, titleWidth, 10);
            mLabel.font = [FontUtil systemFontOfSize:10];
            sLabel.frame= CGRectMake(0, 11, titleWidth, 20);
            sLabel.font = [FontUtil systemFontOfSize:14];
            publication.frame=CGRectMake(0, 30, titleWidth, 14);
            publication.textAlignment = NSTextAlignmentCenter;
            publication.font=[FontUtil systemFontOfSize:12];
        }
        
        //[titleView addSubview:publication];
    }
    [mLabel setTextColor:[UIColor blueColor]];
    
    mLabel.text = mtitle;
    if ([sTitle isKindOfClass:[NSString class]]) {
        sLabel.text = sTitle;
    }else{
        sLabel.text = @"";
    }
    
    self.navigationItem.titleView = titleView;
    
}

/**
 * toolBar初期化
 *
 */
- (UIToolbar *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        _toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        //        [_toolBar setBackgroundImage:[UIImage imageNamed:GETIMAGENAME(@"bg_navigation_footer")] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
        _toolBar.backgroundColor = [UIColor whiteColor];
        
    }
    return _toolBar;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 * UIPageViewController set
 *
 */
-(UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        
    }
    return _pageViewController;
}
-(UIScrollView *)titleBackground
{
    if (!_titleBackground) {
        _titleBackground = [[UIScrollView alloc] init];
        _titleBackground.showsHorizontalScrollIndicator = NO;
        _titleBackground.showsVerticalScrollIndicator = NO;
        _titleBackground.backgroundColor = [UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1];
    }
    return _titleBackground;
}
-(void)setDataSource:(id<NoteViewPagerViewControllerDataSource>)dataSource
{
    _dataSource = dataSource;
    [self p_reload];
    
}
-(void)p_reload
{
    if ([self.dataSource respondsToSelector:@selector(numberOfViewControllersInViewPager:)]) {
        oldRect = CGRectZero;
        if (![self.dataSource numberOfViewControllersInViewPager:self]) {
            @throw [NSException exceptionWithName:@"viewControllerException" reason:@"设置要返回的控制器数量" userInfo:nil];
        }
        numberOfViewController = [self.dataSource numberOfViewControllersInViewPager:self];
        NSMutableArray *mutableArrayOfVC = [NSMutableArray array];
        NSMutableArray *mutableArrayOfBtn = [NSMutableArray array];
        ArrayOfBtn = [NSMutableArray array];
        for (int i = 0; i<numberOfViewController; i++) {
            if ([self.dataSource respondsToSelector:@selector(viewPager:indexOfViewControllers:)]) {
                if (![[self.dataSource viewPager:self indexOfViewControllers:i] isKindOfClass:[UIViewController class]]) {
                    @throw [NSException exceptionWithName:@"viewControllerException" reason:[NSString stringWithFormat:@"第%d个分类下的控制器必须是UIViewController类型或者其子类",i+1] userInfo:nil];
                }
                else
                {
                    [mutableArrayOfVC addObject:[self.dataSource viewPager:self indexOfViewControllers:i]];
                }
                
            }
            else{
                @throw [NSException exceptionWithName:@"viewControllerException" reason:@"设置要显示的控制器" userInfo:nil];
            }
            if ([self.dataSource respondsToSelector:@selector(viewPager:titleWithIndexOfViewControllers:)]) {
                NSString *buttonTitle = [self.dataSource viewPager:self titleWithIndexOfViewControllers:i];
                if (arrayOfViewControllerButton.count > i) {
                    [[arrayOfViewControllerButton objectAtIndex:i] removeFromSuperview];
                }
                UIButton *button;
                if ([self.dataSource respondsToSelector:@selector(viewPager:titleButtonStyle:)]) {
                    if (![[self.dataSource viewPager:self titleButtonStyle:i] isKindOfClass:[UIButton class]]) {
                        @throw [NSException exceptionWithName:@"titleException" reason:[NSString stringWithFormat:@"第%d的标题类型必须为UIButton或者其子类",i+1] userInfo:nil];
                    }
                    button = [self.dataSource viewPager:self titleButtonStyle:i];
                }
                else
                {
                    button = [[LSYViewPagerTitleButton alloc] init];
                }
                [button addTarget:self action:@selector(p_titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                
                NSInteger btnWidth = [self p_fontText:buttonTitle withFontHeight:20];
                button.frame = CGRectMake(oldRect.origin.x+oldRect.size.width, 0, btnWidth+10, [self.dataSource respondsToSelector:@selector(heightForTitleOfViewPager:)]?[self.dataSource heightForTitleOfViewPager:self]:0);
                oldRect = button.frame;
                [button setTitle:buttonTitle forState:UIControlStateNormal];
                [mutableArrayOfBtn addObject:button];
                [ArrayOfBtn addObject:button];
                [_titleBackground addSubview:button];
                if (i == numberOfViewController -1) {
                    oldButton = [mutableArrayOfBtn objectAtIndex:numberOfViewController-1];
                    oldButton.selected = YES;
                    oldButton.backgroundColor = [UIColor colorWithRed:234/255.0 green:115/255.0 blue:160/255.0 alpha:1];
                }
                
            }
            else
            {
                @throw [NSException exceptionWithName:@"titleException" reason:@"每个控制器必须设置一个标题" userInfo:nil];
            }
            
            
        }
        if (mutableArrayOfBtn.count && ((UIButton *)mutableArrayOfBtn.lastObject).frame.origin.x + ((UIButton *)mutableArrayOfBtn.lastObject).frame.size.width<[Util screenSize].width) //当所有按钮尺寸小于屏幕宽度的时候要重新布局
        {
            oldRect = CGRectZero;
            CGFloat padding = self.view.frame.size.width-(((UIButton *)mutableArrayOfBtn.lastObject).frame.origin.x + ((UIButton *)mutableArrayOfBtn.lastObject).frame.size.width);
            for (LSYViewPagerTitleButton *button in mutableArrayOfBtn) {
                button.frame = CGRectMake(oldRect.origin.x+oldRect.size.width, 0,button.frame.size.width+padding/mutableArrayOfBtn.count+10, [self.dataSource respondsToSelector:@selector(heightForTitleOfViewPager:)]?[self.dataSource heightForTitleOfViewPager:self]:0);
                oldRect = button.frame;
            }
        }
        arrayOfViewControllerButton = [mutableArrayOfBtn copy];
        arrayOfViewController = [mutableArrayOfVC copy];
    }
    if ([self.dataSource respondsToSelector:@selector(headerViewForInViewPager:)]) {
        [headerView removeFromSuperview];
        headerView = [self.dataSource headerViewForInViewPager:self];
        [self.view addSubview:headerView];
    }
    if (arrayOfViewController.count) {
        [_pageViewController setViewControllers:@[[arrayOfViewController objectAtIndex:_nowIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        
        
    }
    
}
-(void)p_titleButtonClick:(LSYViewPagerTitleButton *)sender
{
    oldButton.selected = NO;
    oldButton.backgroundColor = [UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1];
    sender.selected = YES;
    oldButton = sender;
    oldButton.backgroundColor = [UIColor colorWithRed:234/255.0 green:115/255.0 blue:160/255.0 alpha:1];
    NSInteger index = [arrayOfViewControllerButton indexOfObject:sender];
    [_pageViewController setViewControllers:@[arrayOfViewController[index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    if ([self.delegate respondsToSelector:@selector(viewPagerViewController:selectNowIndex:)]) {
        [self.delegate viewPagerViewController:self  selectNowIndex:index];
    }
    [self scrollViewOffset:sender];
    
}
-(void)p_titleButtonConvert:(LSYViewPagerTitleButton *)sender
{
    oldButton.selected = NO;
    oldButton.backgroundColor = [UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1];
    sender.selected = YES;
    oldButton = sender;
    oldButton.backgroundColor = [UIColor colorWithRed:234/255.0 green:115/255.0 blue:160/255.0 alpha:1];
    [self scrollViewOffset:sender];
    
}
-(void)scrollViewOffset:(UIButton *)button
{
    if (!(_titleBackground.contentSize.width>CGRectGetWidth(self.view.frame))) {
        return;
    }
    if (CGRectGetMidX(button.frame)>CGRectGetMidX(self.view.frame)) {
        if (_titleBackground.contentSize.width<CGRectGetMaxX(self.view.frame)/2+CGRectGetMidX(button.frame)) {
            [_titleBackground setContentOffset:CGPointMake(_titleBackground.contentSize.width-CGRectGetWidth(self.view.frame), 0) animated:YES];
        }
        else{
            [_titleBackground setContentOffset:CGPointMake(CGRectGetMidX(button.frame)-CGRectGetWidth(self.view.frame)/2, 0) animated:YES];
        }
    }
    else{
        [_titleBackground setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}
#pragma mark -UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        if (pendingVCIndex == NSNotFound) {
            return;
        }
        if (pendingVCIndex != [arrayOfViewController indexOfObject:previousViewControllers[0]]) {
            [self p_titleSelectIndex:pendingVCIndex];
            if ([self.delegate respondsToSelector:@selector(viewPagerViewController:didFinishScrollWithCurrentViewController: nowIndex:)]) {
                [self.delegate viewPagerViewController:self didFinishScrollWithCurrentViewController:[arrayOfViewController objectAtIndex:pendingVCIndex] nowIndex:pendingVCIndex];
            }
        }
        
    }
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    pendingVCIndex = [arrayOfViewController indexOfObject:pendingViewControllers[0]];
    if ([self.delegate respondsToSelector:@selector(viewPagerViewController:willScrollerWithCurrentViewController:)]) {
        [self.delegate viewPagerViewController:self willScrollerWithCurrentViewController:pageViewController.viewControllers[0]];
    }
}
#pragma mark -UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [arrayOfViewController indexOfObject:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    else{
        
        return arrayOfViewController[--index];
        
    }
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [arrayOfViewController indexOfObject:viewController];
    if (index == arrayOfViewController.count-1 || index == NSNotFound) {
        return nil;
    }
    else{
        
        return arrayOfViewController[++index];
    }
}
-(void)p_titleSelectIndex:(NSInteger)index
{
    [self p_titleButtonConvert:arrayOfViewControllerButton[index]];
}
-(void)viewDidLayoutSubviews
{
    btnNumber++;
    NSInteger  headerViewy = self.topLayoutGuide.length;
    NSInteger headerViewWidth = [Util screenSize].width;
    NSInteger headerViewHeight=[self.dataSource respondsToSelector:@selector(heightForHeaderOfViewPager:)]?[self.dataSource heightForHeaderOfViewPager:self]:0;
    headerView.frame = CGRectMake(0, headerViewy, headerViewWidth,headerViewHeight);
    _titleBackground.frame = CGRectMake(0, (headerView.frame.size.height)?headerView.frame.origin.y+headerView.frame.size.height:self.topLayoutGuide.length, [Util screenSize].width,[self.dataSource respondsToSelector:@selector(heightForTitleOfViewPager:)]?[self.dataSource heightForTitleOfViewPager:self]:0);
    if (arrayOfViewControllerButton.count) {
        CGFloat width = ((UIButton *)arrayOfViewControllerButton.lastObject).frame.size.width+((UIButton *)arrayOfViewControllerButton.lastObject).frame.origin.x;
        _titleBackground.contentSize = CGSizeMake(width, _titleBackground.frame.size.height);
        if (self.isfirst == 0) {
            [_titleBackground setContentOffset:CGPointMake(width-self.view.frame.size.width, 0)];
            self.isfirst = 1;
        }

    }
    _pageViewController.view.frame = CGRectMake(0, _titleBackground.frame.origin.y+_titleBackground.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-(_titleBackground.frame.origin.y+_titleBackground.frame.size.height));
    if (btnNumber == arrayOfViewControllerButton.count) {
        [self p_titleButtonConvert:arrayOfViewControllerButton[_nowIndex]];
    }

}
#pragma maek 计算字体宽度
-(CGFloat)p_fontText:(NSString *)text withFontHeight:(CGFloat)height
{
    CGFloat padding = 20;
    NSDictionary *fontAttribute = @{NSFontAttributeName : [FontUtil systemFontOfSize:14]};
    CGSize fontSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:fontAttribute context:nil].size;
    return fontSize.width+padding;
}

@end

#pragma -mark View Controller Title Button

@implementation LSYViewPagerTitleButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.titleLabel setFont:[FontUtil systemFontOfSize:14]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    if (self.selected) {
        CGFloat lineWidth = 2.5;
        CGColorRef color = self.titleLabel.textColor.CGColor;
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(ctx, color);
        CGContextSetLineWidth(ctx, 0);
        CGContextMoveToPoint(ctx, 0, self.frame.size.height-lineWidth);
        CGContextAddLineToPoint(ctx, self.frame.size.width, self.frame.size.height-lineWidth);
        CGContextStrokePath(ctx);
    }
}

@end

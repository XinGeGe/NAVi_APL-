
#import "NAPopoverBackgroundView.h"

@interface NAPopoverBackgroundView (){
    AGWindowView *windowView;
}

@property (nonatomic, strong) UIView *backView;

@end

@implementation NAPopoverBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    self.backView.frame = CGRectMake(0, 0, [Util screenSize].width, [Util screenSize].height);
    if ([Util screenSize].width>[Util screenSize].height) {
        //hengping
        if (isPhone) {
            self.backView.frame = CGRectMake(0, 34, [Util screenSize].width, [Util screenSize].height-64-44);
        }else{
            self.backView.frame = CGRectMake(0, 64, [Util screenSize].width, [Util screenSize].height-64-49);
        }
    }else{
        //shuping
        if (isPhone) {
            self.backView.frame = CGRectMake(0, 64+40, [Util screenSize].width, [Util screenSize].height-64-44-40);
        }else{
            self.backView.frame = CGRectMake(0, 64+40, [Util screenSize].width, [Util screenSize].height-64-49-40);
        }
    }
    
    [self updateView];
}


#pragma mark - layout -
#pragma mark

- (NAPaperView *)paperView
{
    if (!_paperView) {
        _paperView = [[NAPaperView alloc] initWithFrame:CGRectZero];
        [_paperView setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:234.0/255.0 blue:248.0/255.0 alpha:1]];
        _paperView.delegate = self;
    }
    return _paperView;
}

- (NAArticleView *)articleView
{
    if (!_articleView) {
        _articleView = [[NAArticleView alloc] initWithFrame:CGRectMake(10, 0, 200, 350)];
    }
    return _articleView;
}

- (NADateView *)dateView
{
    if (!_dateView) {
        _dateView = [[NADateView alloc] initWithFrame:CGRectZero];
    }
    return _dateView;
}

- (NAMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[NAMenuView alloc] initWithFrame:CGRectMake(10, 0, 150, 176)];
        _menuView.delegate = self;
    }
    return _menuView;
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor lightGrayColor];
    }
    return _backView;
}


#pragma mark - utility -
#pragma mark

- (void)addsubviewWithType:(NAPopoverBackgroundType)type withInfo:(NSArray *)infos
{
    switch (type) {
        case NAPopoverDate:
            [self addSubview:self.dateView];
            [self.dateView reloadDateView:infos];
            self.typeView = self.dateView;
            break;
        case NAPopoverArticle:
            [self addSubview:self.articleView];
            [self.articleView reloadArticleData:infos];
            self.typeView = self.articleView;
            break;
        case NAPopoverPaper:
            [self addSubview:self.paperView];
            self.paperView.currentindex=self.currentindex;
            [self.paperView initPagerData:infos];
            self.typeView = self.paperView;
            break;
        case NAPopoverMenu:
            [self addSubview:self.menuView];
            self.typeView = self.menuView;
            break;
        default:
            break;
    }
    self.popType = type;
}

- (void)removeSubView
{
    switch (self.popType) {
        case NAPopoverDate:
            [self.dateView removeFromSuperview];
            self.dateView = nil;
            break;
        case NAPopoverArticle:
            [self.articleView removeFromSuperview];
            self.articleView = nil;
            break;
        case NAPopoverPaper:
            [self.paperView removeFromSuperview];
            self.paperView = nil;
            break;
        case NAPopoverMenu:
            [self.menuView removeFromSuperview];
            self.menuView = nil;
            break;
        default:
            break;
    }
    self.typeView = nil;
}

- (void)showPopoverView:(NAPopoverBackgroundType)type withInfo:(NSArray *)infos
{
    if ([self isShowPopoverView]) {
        [self hidePopoverView];
        return;
    }
    [ProgressHUD show:nil];
    windowView = [[AGWindowView alloc] initAndAddToKeyWindow];
    self.frame =windowView.bounds;
    windowView.supportedInterfaceOrientations = AGInterfaceOrientationMaskAll;
    if (![windowView.subviews containsObject:self]) {
        [windowView addSubview:self];
    }
    
    
    [self addsubviewWithType:type withInfo:infos];
    self.backView.alpha = 0.0f;
    self.hidden = NO;
    self.typeView.alpha = 0.0f;
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.alpha = 0.5f;
        self.typeView.alpha = 0.8f;
    } completion:^(BOOL finished) {
        self.backView.alpha = 0.5f;
        self.typeView.alpha = 0.8f;
        [ProgressHUD dismiss];
    }];
}

- (void)hidePopoverView
{
    [windowView removeFromSuperview];
    self.backView.alpha = 0.5f;
    self.typeView.alpha = 1.0f;
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.alpha = 0.0f;
        self.typeView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.backView.alpha = 0.0f;
        self.hidden = YES;
        self.typeView.alpha = 0.0f;
    }];
    [self removeSubView];
    [_delegate resetToolBar];
}

- (BOOL)isShowPopoverView
{
    if (self.backView.alpha == 0.5f && self.hidden == NO) {
        return YES;
    }
    return NO;
}

- (void)updateView
{
    CGRect frame = self.backView.frame;
    if (!self.typeView) {
        return;
    }
    switch (self.popType) {
        case NAPopoverDate:
            self.dateView.frame = CGRectMake(0, 0, 200, self.frame.size.height);
            break;
        case NAPopoverArticle:
            self.articleView.frame = CGRectMake(10, 0, 200, 350);
            break;
        case NAPopoverPaper:
            self.paperView.frame = CGRectMake(0, frame.size.height - 170, frame.size.width, 170);
            if ([Util screenSize].width>[Util screenSize].height) {
                //hengping
                if (isPhone) {
                    self.paperView.frame = CGRectMake(0, frame.size.height - 170+62, frame.size.width, 170);
                    
                }else{
                    self.paperView.frame = CGRectMake(0, frame.size.height - 170+60, frame.size.width, 170);
                    
                }
            }else{
                //shuping
                if (isPhone) {
                    self.paperView.frame = CGRectMake(0, frame.size.height - 170+64+40, frame.size.width, 170);
                    
                }else{
                    self.paperView.frame = CGRectMake(0, frame.size.height - 170+64+30, frame.size.width, 170);
                    
                }
            }
            
            
            break;
        case NAPopoverMenu:
            self.menuView.frame = CGRectMake(10, 0, 150, 176);
            break;
        default:
            break;
    }
    
}


#pragma mark - touch action -
#pragma mark

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hidePopoverView];
}


#pragma mark - NAMenuViewDelegate -
#pragma mark

- (void)menuSelectIndex:(NSInteger)index
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:index], @"NAPopoverTypeMenuIndex", nil];
    [self.delegate popoverDelegateWithType:NAPopoverMenu withDataSource:dic];
}

#pragma mark - NAPaperViewDelegate -
#pragma mark

- (void)paperViewSelected:(id)object
{
    [self.delegate popoverDelegateWithType:NAPopoverPaper withDataSource:object];
}

- (void)closePopover
{
    [self hidePopoverView];
}

@end

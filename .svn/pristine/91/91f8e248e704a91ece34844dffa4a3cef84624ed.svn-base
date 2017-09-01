
#import "NAPaperView.h"

@interface NAPaperView ()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *leftButton;
@end

@implementation NAPaperView

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
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scrollView];
    [self addSubview:self.rightButton];
    [self addSubview:self.leftButton];
}

- (void)updateViews
{
    CGRect frame = self.bounds;
//    frame.origin.y = 30;
//    frame.size.height = frame.size.height - 30;
    self.scrollView.frame = frame;
    [self reloadPagerData:self.dataSource];
    self.leftButton.frame = CGRectMake(2, 2, 16, 16);
    self.rightButton.frame = CGRectMake(self.frame.size.width-20, 2, 16, 16);
}

- (void)initPagerData:(NSArray *)data
{
    self.dataSource = data;
    NSInteger count = data.count;
    self.scrollView.contentSize = CGSizeMake(110 * count + 10, self.scrollView.contentSize.height);
    if (self.scrollView.subviews.count > 0) {
        for (UIView *obj in self.scrollView.subviews) {
            if ([obj isKindOfClass:[NASubPagerView class]]) {
                [obj removeFromSuperview];
            }
        }
    }

    for (NSInteger i = 0; i < count; i++) {
        NASubPagerView *sub = [[NASubPagerView alloc] initWithFrame:CGRectMake(10 + 110 * (count - 1 -i), 0, 100, 170)];
        NADoc *doc = data[i];
        [sub imageViewWthInfo:doc];
        [sub updateTitleWithName:doc.pageInfoName];
        sub.delegate = self;
        sub.tag = i + 1;
        sub.backgroundColor = [UIColor clearColor];
        if (i==count-1-self.currentindex) {
            sub.imageView.layer.masksToBounds=YES;
            sub.imageView.layer.borderColor=[UIColor colorWithRed:232/255.0 green:106/255.0 blue:151/255.0 alpha:1].CGColor;
            sub.imageView.layer.borderWidth=1;
           
        }
        [self.scrollView addSubview:sub];
    }
    [self reloadPagerData:self.dataSource];
    if (self.scrollView.contentSize.width > self.frame.size.width) {
        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - 110*(count-self.currentindex)-[Util screenSize].width/2, 0);
        ;
         NSLog(@"self.scrollView.contentOffset==%f",self.scrollView.contentOffset.x);
    }
    
}

- (void)reloadPagerData:(NSArray *)data
{
    self.dataSource = data;
    NSInteger count = data.count;
    self.scrollView.contentSize = CGSizeMake(110 * self.dataSource.count + 10, self.scrollView.contentSize.height);
    for (id obj in self.scrollView.subviews) {
        if ([obj isKindOfClass:[NASubPagerView class]]) {
            NASubPagerView *sub = (NASubPagerView *)obj;
            if (self.scrollView.contentSize.width > self.frame.size.width) {
                sub.frame = CGRectMake(10 + 110 * (count - sub.tag), 20, 100, 150);
            }else{
                sub.frame = CGRectMake(self.frame.size.width - 110 * sub.tag, 20, 100, 150);
            }
        }
    }

}

#pragma mark - layout -
#pragma mark

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"14_blue"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"15_blue"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}
- (void)closeButtonAction:(id)sender
{
    [self.delegate closePopover];
}

#pragma mark - NASubPagerViewDelegate -
#pragma mark

- (void)subPagerViewselected:(id)object
{
    UIView *view = (UIView *)object;
    [self.delegate paperViewSelected:[NSNumber numberWithInteger:view.tag]];
}

@end


#import "NAImageScrollView.h"
#import "NASubImageScrollView.h"

#define SCROLLVIEW_SIZE_COUNT 3

@interface NAImageScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) NSInteger currIndex;


@end

@implementation NAImageScrollView

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageArray = images;
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
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    [self addSubview:self.scrollView];
    self.currIndex = 0;
    self.scrollView.contentSize = CGSizeMake(width * SCROLLVIEW_SIZE_COUNT, height);
    for (NSInteger i = 0; i < SCROLLVIEW_SIZE_COUNT; i++) {
        NASubImageScrollView *sub = [[NASubImageScrollView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        sub.minimumZoomScale = 1.0f;
        sub.maximumZoomScale = 6.0f;
        sub.backgroundColor = [UIColor whiteColor];
        sub.delegate = self;
        sub.tag = i + 1;
        [self.scrollView addSubview:sub];
    }
}

- (void)updateViews
{
    self.scrollView.frame = self.bounds;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    self.scrollView.contentSize = CGSizeMake(width * SCROLLVIEW_SIZE_COUNT, height);
    for (id object in self.scrollView.subviews) {
        if ([object isKindOfClass:[NASubImageScrollView class]]) {
            NASubImageScrollView *sub = (NASubImageScrollView *)object;
            [sub updateFrame:CGRectMake(width * (sub.tag - 1), 0, width, height)];
        }
    }
}

- (void)updateScrollViewData
{
    for (NSInteger i = 0; i < SCROLLVIEW_SIZE_COUNT; i++) {
        UIView *view = (UIView *)[self.scrollView viewWithTag:i + 1];
        if ([view isKindOfClass:[NASubImageScrollView class]]) {
//            NASubImageScrollView *sub = (NASubImageScrollView *)view;
//            NADoc *doc = self.imageArray[self.currIndex + i];
//            [self imageView:sub withInfo:doc];
        }
    }
}

- (void)readImagesData:(NSArray *)array
{
    self.imageArray = array;
    self.currIndex = 0;
    [self updateScrollViewData];
}

#pragma mark - layout -
#pragma mark

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

#pragma mark - UIScrollViewDelegate -
#pragma mark

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[NASubImageScrollView class]]) {
        NSInteger index = (NSInteger)(scrollView.contentOffset.x / scrollView.bounds.size.width);
        CGFloat width = self.bounds.size.width;
        NSLog(@"%@",@(index));
        
        if (index == 0) {
            if (self.currIndex > 0) {
                [scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
                self.currIndex = self.currIndex - 1;
                [self updateScrollViewData];
            }
        }else if (index == 2) {
            if (self.currIndex < self.imageArray.count - 3 ) {
                [scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
                self.currIndex = self.currIndex + 1;
                [self updateScrollViewData];
            }
        }

    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}



@end

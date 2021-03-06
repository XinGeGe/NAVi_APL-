//
//  NADetailSwipeImageViewController.m
//  NAVi
//
//  Created by y fs on 15/6/16.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NADetailSwipeImageViewController.h"
#import "NASubImageScrollView.h"
#import "FontUtil.h"
@interface NADetailSwipeImageViewController ()<SwipeViewDataSource, SwipeViewDelegate>
@property (nonatomic, strong) SwipeView *mainScrollView;
@property (nonatomic,strong)UITextView *imageTextView;
//@property (nonatomic,strong)UILabel *imageNoTitle;
@property (nonatomic,strong)UIView *bgTitleView;
@property (nonatomic, strong) NSMutableArray *myswipeimageArray;
@property (nonatomic, assign) NSInteger currentPageIndex;

@end

@implementation NADetailSwipeImageViewController

@synthesize imagearray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancel.frame = CGRectMake(10, 15, 20, 20);
    [btnCancel setImage:[UIImage imageNamed:@"20_white"] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(backBarItemAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCancel];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ImageDetailClick:) name:NOTYImageDetailClick object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singleClickNoty) name:@"singleClickNoty" object:nil];;
    self.view.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1];
    
    
}

- (void)backBarItemAction{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
    
    switch (result){
            
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled");
            
            break;
            
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved…");
            
            break;
            
        case MFMailComposeResultSent:
            NSLog(@"Mail sent…");
            
            break;
            
        case MFMailComposeResultFailed:
            NSLog(@"Mail send errored: %@…", [error localizedDescription]);
            
            break;
            
        default:
            break;
    }
    
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"";
    if (!error) {
        message = NSLocalizedString(@"image Save Success", nil);
    }else
    {
        //message = [error description];
        message = NSLocalizedString(@"image Save Fail", nil);
    }
    MAIN(^{
        ITOAST_BOTTOM(message);
    });
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSMutableArray *captionArray=[NSMutableArray arrayWithArray:[self.imageBaseClass.Caption componentsSeparatedByString:@","]];
    NSString *caption=@"";
    caption=[captionArray firstObject];
    self.imageTextView.text=caption;
    
    if (caption==nil||self.imageTextView.text.length==0) {
        self.bgTitleView.hidden=YES;
    }
    NSString *imageNo=@"";
    NSString *myPublishingHistoryInfoContentIdPicture=self.myclipDoc.publishingHistoryInfoContentIdPicture;
    myPublishingHistoryInfoContentIdPicture = [myPublishingHistoryInfoContentIdPicture stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"A%@",self.myclipDoc.publisherGroupInfoId] withString:@""];
    NSMutableArray *imageNoArray=[NSMutableArray arrayWithArray:[myPublishingHistoryInfoContentIdPicture componentsSeparatedByString:@"^3$"]];
    imageNo=[imageNoArray firstObject];
    

    
}
-(void)ImageDetailClick:(NSNotification *)notify{
    NSDictionary *dic=[notify userInfo];
    NAMoviePlayerController *playerViewController =[[NAMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:[dic objectForKey:@"trueUrl"]]];
    
    [self presentMoviePlayerViewControllerAnimated:playerViewController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 画面回転の前処理
 *
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.presentingViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.mainScrollView reloadData];
}

/**
 * 画面回転の後処理
 *
 */
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.presentingViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    self.navigationController.navigationBar.translucent=NO;
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    if ([self isLandscape]) {
        self.mainScrollView.frame = CGRectMake(35, 10, screenWidth-35*2, screenHeight-10);
    }else{
        self.mainScrollView.frame = CGRectMake(0, 45, screenWidth, screenHeight-45);
    }

    [self.mainScrollView scrollToItemAtIndex: self.currentPageIndex duration:0.3];
}

#pragma mark - layout -
#pragma mark
/**
 * mainScrollView初期化（紙面表示用view）
 *
 */
- (SwipeView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[SwipeView alloc] initWithFrame:CGRectZero];
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.alignment = SwipeViewAlignmentCenter;
        _mainScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.wrapEnabled = NO;
        _mainScrollView.itemsPerPage = 1;
        _mainScrollView.truncateFinalPage = YES;
        _mainScrollView.dataSource = self;
        _mainScrollView.delegate = self;
        _mainScrollView.opaque = YES;
        
        
    }
    return _mainScrollView;
}

 #pragma mark - utility -
 #pragma mark
 /**
 * view初期化
 *
 */
- (void)initViews
{
    [super initViews];
    self.navigationItem.leftBarButtonItem = self.backBtnItem;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.mainScrollView];
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    
    if ([self isLandscape]) {
        self.mainScrollView.frame = CGRectMake(35, 10, screenWidth-35*2, screenHeight-10);
    }else{
        self.mainScrollView.frame = CGRectMake(0, 45, screenWidth, screenHeight-45);
    }
    
    
    self.bgTitleView=[[UIView alloc]init];
    self.bgTitleView.backgroundColor=[UIColor lightGrayColor];
    self.bgTitleView.alpha=0.4;
    [self.view addSubview:self.bgTitleView];
    self.bgTitleView.frame=CGRectMake(0, screenHeight-70, screenWidth,70);
    self.bgTitleView.hidden = YES;
    self.imageTextView=[[UITextView alloc]init];
    self.imageTextView.font=[FontUtil systemFontOfSize:isPad?20:15];
    self.imageTextView.textAlignment=NSTextAlignmentLeft;
    self.imageTextView.backgroundColor=[UIColor clearColor];
    self.imageTextView.textColor=[UIColor whiteColor];
    [self.view addSubview:self.imageTextView];
    
    self.imageTextView.frame=CGRectMake(0, screenHeight-60, screenWidth,60);
}
+ (CGFloat)heightWithText:(NSString *)text{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil];
    CGSize size = CGSizeMake(375, 1000);
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;    
}
/**
 * view更新
 *
 */
- (void)updateViews
{
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;

    if ([self isLandscape]) {
        self.mainScrollView.frame = CGRectMake(35, 10, screenWidth-35*2, screenHeight-10);
    }else{
        self.mainScrollView.frame = CGRectMake(0,45, screenWidth, screenHeight-45);
    }
    self.imageTextView.frame=CGRectMake(0, screenHeight-60, screenWidth,60);
    self.bgTitleView.frame=CGRectMake(0, screenHeight-70, screenWidth,70);
}
- (BOOL)isLandscape
{
    return ([Util screenSize].width>[Util screenSize].height);
}
#pragma mark - SwipeView Delegate -
#pragma mark
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    NSInteger count = self.imagearray.count;
    return count;
}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //    NSLog(@"swipeView index %d currentItemIndex %d",index, self.mainScrollView.currentItemIndex);
    
    NASubImageScrollView *imageScroll = (NASubImageScrollView *)view;
    if (!imageScroll) {
        imageScroll = [[NASubImageScrollView alloc] initWithFrame:self.mainScrollView.bounds];
        view = imageScroll;
    }
    
   
    imageScroll.imageBaseClass=self.imageBaseClass;
    imageScroll.frame = self.mainScrollView.bounds;
    if ([self isLandscape]) {
        NSString *myratestr=[NASaveData getExpansion_rate];
        NSArray *ratearray=[myratestr componentsSeparatedByString:@","];
        imageScroll.minimumZoomScale = [[ratearray objectAtIndex:0]floatValue];
        imageScroll.maximumZoomScale = [[ratearray objectAtIndex:3]floatValue]*[NASaveData getLandscapekei];
    }else{
        NSString *myratestr=[NASaveData getExpansion_rate];
        NSArray *ratearray=[myratestr componentsSeparatedByString:@","];
        imageScroll.minimumZoomScale = [[ratearray objectAtIndex:0]floatValue];
        imageScroll.maximumZoomScale = [[ratearray objectAtIndex:3]floatValue];
    }
    
    //imageScroll.imageView.isPadLandscape = NO;
    //    imageScroll.backgroundColor = [UIColor whiteColor];
    imageScroll.opaque = YES;
    imageScroll.delegate = self;
    imageScroll.tag = index + 1;
    [imageScroll setZoomScale:1];
    imageScroll.bounces = NO;
    imageScroll.largeModel = NAImageModelNone;
    imageScroll.noteDetailBlock = ^(NSArray *array, NSInteger index) {
        //[self toNoteDetailViewController:array index:index];
    };
    
    __weak __typeof(&*imageScroll)weakimageScroll = imageScroll;

    [imageScroll setImageViewWithurlstr:[CharUtil getRightUrl:[imagearray objectAtIndex:index]]completionBlock:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (self.noteDoc) {
            weakimageScroll.pageDocs=[NSArray arrayWithObjects:self.noteDoc, nil];
            NSString *noteIndexNo=self.noteDoc.indexNo;
            curNoteIndexNo=noteIndexNo;
            CGRect noteRect = [weakimageScroll showNoteViewByIndexNo:noteIndexNo];
            [weakimageScroll moveWithNote:noteRect];
            
        }
        
    }];
    
   
    //[imageScroll.imageView.imageView sd_setImageWithURL:[NSURL URLWithString:[imagearray objectAtIndex:index]] placeholderImage:nil];
   
//    NSInteger count = self.myswipeimageArray.count;
//    NADoc *doc = self.myswipeimageArray[count - 1 - index];
//    [imageScroll LoadingThumbImageView:doc ];

    return view;
}
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    NSMutableArray *captionArray=[NSMutableArray arrayWithArray:[self.imageBaseClass.Caption componentsSeparatedByString:@","]];
    NSString *caption=@"";
    if (swipeView.currentItemIndex<captionArray.count&&captionArray!=nil) {
        caption=[captionArray objectAtIndex:swipeView.currentItemIndex];
    }
    self.imageTextView.text=caption;
    if (caption==nil||self.imageTextView.text.length==0) {
        self.bgTitleView.hidden=YES;
    }else{
        self.bgTitleView.hidden=NO;
    }
    
    NSString *imageNo=@"";
    NSString *myPublishingHistoryInfoContentIdPicture=self.myclipDoc.publishingHistoryInfoContentIdPicture;
    myPublishingHistoryInfoContentIdPicture = [myPublishingHistoryInfoContentIdPicture stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"A%@",self.myclipDoc.publisherGroupInfoId] withString:@""];
    NSMutableArray *imageNoArray=[NSMutableArray arrayWithArray:[myPublishingHistoryInfoContentIdPicture componentsSeparatedByString:@"^3$"]];
    imageNo=[imageNoArray objectAtIndex:swipeView.currentItemIndex];
    
        
}
-(void)singleClickNoty{
//    if (self.imageTextView.text.length&&self.imageTextView.text.length>0) {
//        [self.imageTextView setHidden:!self.imageTextView.isHidden];
//        [self.bgTitleView setHidden:!self.bgTitleView.isHidden];
//    }
    
   
    
}
- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    //    NALog(@"Selected item at index %@", @(index));
}

- (void)swipeViewWillBeginDragging:(SwipeView *)swipeView
{
    
    NASubImageScrollView *view = (NASubImageScrollView *)[swipeView itemViewAtIndex:swipeView.currentItemIndex];
    if (view.zoomScale<1) {
        [view setZoomScale:1];
        return;
    }
}

- (void)swipeViewDidEndDecelerating:(SwipeView *)swipeView
{
    //    NSLog(@"swipeViewDidEndDecelerating %d",swipeView.currentItemIndex);
    //[self.homeToolBar noteItemEnable:YES];
    
    NASubImageScrollView *view = (NASubImageScrollView *)[swipeView itemViewAtIndex:swipeView.currentItemIndex];
    if (view) {
        view=(NASubImageScrollView *)self.mainScrollView.currentItemView;
    }
    NSInteger count = self.myswipeimageArray.count;
    
    if (self.currentPageIndex != count - 1 - swipeView.currentItemIndex) {
        [view setZoomScale:1];
    }
    
    NADoc *doc=self.myswipeimageArray[count - 1 - swipeView.currentItemIndex];
    self.currentPageIndex=swipeView.currentItemIndex;
        if ([NASaveData isHaveNote]) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [view getNoteLayerWithDoc:doc other:nil];
                
                if (curNoteIndexNo) {
                    [view showNoteViewByIndexNo:curNoteIndexNo];
                    curNoteIndexNo = nil;
                    curPaperIndexNo = nil;
                }
            });
        }
        //[view LoadingImageView:doc];
        
        if ([doc.whichimage isEqualToString:NALargeimage]) {
            view.largeModel= NAImageModelDone;
        }else{
            view.largeModel = NAImageModelNone;
        }
   
}
- (void)swipeViewDidEndScrollingAnimation:(SwipeView *)swipeView{
    self.mainScrollView.hidden=NO;
}
#pragma mark - UIScrollView Delegate -
#pragma mark


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}

/**
 * zoom後処理
 *
 */
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NASubImageScrollView *view = (NASubImageScrollView *)[self.mainScrollView itemViewAtIndex:self.mainScrollView.currentItemIndex];
    if (scrollView.zoomScale<1) {
        [scrollView setZoomScale:1];
        return;
    }
    if (scrollView.zoomScale > 1 && view.largeModel == NAImageModelNone) {
            view.largeModel=NAImageModelLoading;
        
      
    }
    
    // imageViewのframeを修正
    for (UIView *v in scrollView.subviews){
        if ([v isKindOfClass:NSClassFromString(@"NASubImageView")]) {
            CGRect rect = v.frame;
            rect.origin = CGPointZero;
            
            if (CGRectGetWidth(scrollView.frame) > CGRectGetWidth(v.frame)) {
                // imageviewの幅がscrollviewの幅より小さくなった == 1.0倍未満のズームが行われた
                rect.origin.x = (CGRectGetWidth(scrollView.frame) - CGRectGetWidth(v.frame))/2;
                rect.size.width=scrollView.frame.size.width;
            }
            
            if (CGRectGetHeight(scrollView.frame) > CGRectGetHeight(v.frame)) {
                // imageviewの高さがスクロールビューより小さくなった
                rect.origin.y = (CGRectGetHeight(scrollView.frame) - CGRectGetHeight(v.frame))/2;
                rect.size.height=scrollView.frame.size.height;
                
            }
            [view.imageView updateFrame4Zoom:rect isFromDetail:YES zoomScale:scrollView.zoomScale];
        }
    }
}

@end

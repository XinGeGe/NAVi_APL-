
#import "NABaseViewController.h"
#import "NAHomeToobar.h"
#import "NAPopoverBackgroundView.h"
#import "SwipeView.h"
#import "NADownloadHelper.h"
#import "DHSlideMenuController.h"
#import "NAGifuMainViewController.h"
#import "NavParentController.h"
#import "NALeftMenuViewController.h"
#import "KxMenu.h"
#import "NAHomeProgressView.h"
#import "TOWebViewController.h"
#import "NALoginAlertView.h"
#import "NALoginReminAlertView.h"
@interface NABaseHomeViewController : NABaseViewController < UIScrollViewDelegate,UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate,NALoginAlertViewDelegate,NALoginReminAlertViewDelegate>{
    NSInteger firstDownloadNum;
    
    NSString *curPaperIndexNo;
    NSString *curNoteIndexNo;
    NSInteger pageIndex;
    NSInteger istwo;
    
    NSInteger verticalCurrentPageIndex;
    NSInteger iphoneCurrentPageIndex;
    
    NSMutableArray *myNormalimageaarray;
    NSTimer *mytimer;
    BOOL isHavenet;
    NSDate *currentdate;
    NSTimer *myhidebartimer;
    BOOL isAllDownload;
    BOOL isDoneImageTask;
    
    CGPoint currentPoint;
    CGFloat currentZoom;
    
    BOOL beforeIsTwoImage;
    BOOL isChangeScreen;
    
   BOOL isNotelistChange;
    
}
@property (nonatomic, strong) SwipeView *mainScrollView;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, assign)BOOL isHavesokuho;
@property (nonatomic, strong) NAHomeToobar *homeToolBar;
@property (nonatomic, strong) UIView *rightCustomView;
@property (nonatomic, strong) NAPopoverBackgroundView *popoverBackground;
@property (nonatomic, strong) UIBarButtonItem *searchBarItem;
@property (nonatomic, strong) UIBarButtonItem *webBarItem;
@property (nonatomic,strong) NAHomeProgressView *progressViewBar;
@property (nonatomic, strong) NSMutableArray *searchPublicationArray;
@property (nonatomic, strong) NSArray *searchArticleArray;
@property (nonatomic, strong) NSMutableArray *publisherInfoArray;

@property (nonatomic, strong) UIImageView *mylogoview;
@property (nonatomic, assign) BOOL swipDownloading;

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, assign) NSInteger orientationPageIndex;
@property (nonatomic, assign) UIInterfaceOrientation oldFromInterfaceOrientation;
@property (nonatomic, assign) UIInterfaceOrientation oldToInterfaceOrientation;
@property (nonatomic, assign) BOOL isHaveNote;

@property (nonatomic, assign) NSString *forwardPage;
@property (nonatomic, assign) NADoc *topPageDoc;

@property (nonatomic,strong) UIView *riliView;
@property (nonatomic,strong) UILabel *labYear;
@property (nonatomic,strong) UILabel *labMonthDay;
@property (nonatomic,strong) UILabel *labMian;
@property (nonatomic,strong) UIButton *btnChooseDay;
@property (nonatomic, strong) NSMutableArray *clipDataSource;
@property (nonatomic, strong)   NSMutableDictionary *regionDic;
@property (nonatomic, strong) NSMutableArray *homePageArray;
@property (nonatomic, assign) NSInteger dayNumber;
@property (nonatomic, strong) NADoc *dayDoc;
@property (nonatomic, assign) NSInteger toolBarStyle;
@property (nonatomic,strong) NSString *labYearDetail;
@property (nonatomic,strong) NSMutableAttributedString *labMonthDayDetail;
@property (nonatomic,strong) NSString *labMianDetail;
@property (nonatomic,strong)UIView *viewTwo;
@property (nonatomic,strong)UIView *viewOne;
@property (nonatomic,strong)UIView *viewThree;
@property (nonatomic,strong)UIView *viewFour;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong) UILabel *labYearHore;
@property (nonatomic,strong) UILabel *labMonthDayHore;
@property (nonatomic,strong) UILabel *labMianHore;
@property (nonatomic, assign) NSInteger regionFlg;
@property (nonatomic, assign) NSInteger haveChangeIndex;
//@property (nonatomic, strong) NSMutableDictionary *NotePageArray;
//@property (nonatomic, assign)NSInteger noteNumber;
//@property (nonatomic, strong) NSMutableDictionary *NoteArray;
- (BOOL)isLandscape;
- (NSMutableArray *)padLandscapeCount;
- (void)toSettingViewContreller;
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView;
- (void)swipeViewDidEndDecelerating:(SwipeView *)swipeView;
-(void)controlTheBlockWithdoc:(NADoc *)doc;
- (void)resetHomeToolBar;
- (void)setHorToolBar;
- (void)resetRiliview;
- (void)setRiliview;
-(BOOL)isLogin;
@end

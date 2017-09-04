
#import "NABaseViewController.h"
#import "NAGripToolbar.h"
#import "NAHomeViewController.h"
#import "DateUtil.h"
#import "NoteViewPagerViewController.h"


typedef void(^selecteddic)(NADoc *doc);

@interface NANoteListViewController : NoteViewPagerViewController <UITextViewDelegate>

@property (nonatomic, strong) selecteddic selectmynoteCompletionBlock;
@property (nonatomic, strong) NSMutableArray *NotePageArray;
//@property (nonatomic, strong) NSMutableDictionary *NotePageArray;
@property (nonatomic, readwrite)NSInteger myselectIndex;
//@property (nonatomic, assign)NSInteger noteNumber;
@property (nonatomic, strong) NADoc *doc;
@property (nonatomic, strong) NADoc *other;
@property (nonatomic, strong) UIBarButtonItem *searchBarItem;
@property (nonatomic, strong) UIBarButtonItem *webBarItem;
@property (nonatomic, assign) NADoc *topPageDoc;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) NSMutableArray *clipDataSource;
@property (nonatomic, strong) NSMutableDictionary *regionDic;
@property (nonatomic,strong) NSString *labYearDetail;
@property (nonatomic,strong) NSMutableAttributedString *labMonthDayDetail;
@property (nonatomic,strong) NSString *labMianDetail;
@property (nonatomic,strong) UILabel *labYearHore;
@property (nonatomic,strong) UILabel *labMonthDayHore;
@property (nonatomic,strong) UILabel *labMianHore;
@property (nonatomic,strong) UIView *riliView;
@property (nonatomic,strong) UILabel *labYear;
@property (nonatomic,strong) UILabel *labMonthDay;
@property (nonatomic,strong) UILabel *labMian;
@property (nonatomic,strong) UIButton *btnChooseDay;
@property (nonatomic,strong)UIView *viewTwo;
@property (nonatomic,strong)UIView *viewOne;
@property (nonatomic,strong)UIView *viewThree;
@property (nonatomic,strong)UIView *viewFour;
@property (nonatomic,strong)UIView *lineView;
-(void)controlTheBlockWithdocNote:(NADoc *)doc;
@property (nonatomic, assign) NSInteger haveChangeIndex;
@end

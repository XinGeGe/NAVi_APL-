
#import "NABaseViewController.h"
#import "NAGripToolbar.h"
#import "NANoteCell.h"


@interface NASearchResultViewController : NABaseViewController <UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *dataSouce;
@property (nonatomic, strong) NSString *myserachtext;
@property (nonatomic, strong) NADoc *mycurrDoc;
@property (nonatomic, strong) NSMutableArray *myseracharray;
@property (nonatomic, strong) NSString *serachDate;
@property (nonatomic, strong) UIBarButtonItem *searchBarItem;
@property (nonatomic, strong) UIBarButtonItem *webBarItem;
@property (nonatomic, assign) NADoc *topPageDoc;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) NSMutableArray *clipDataSource;
@property (nonatomic,strong) NSString *labYearDetail;
@property (nonatomic,strong) NSMutableAttributedString *labMonthDayDetail;
@property (nonatomic,strong) NSString *labMianDetail;
@property (nonatomic,strong) UILabel *labYearHore;
@property (nonatomic,strong) UILabel *labMonthDayHore;
@property (nonatomic,strong) UILabel *labMianHore;
@property (nonatomic, strong) NSMutableDictionary *regionDic;
//@property (nonatomic, assign)NSInteger noteNumber;
//@property (nonatomic, strong) NSMutableDictionary *NoteArray;
@end


#import "NABaseViewController.h"
#import "NAGripToolbar.h"
#import "NAMyClipTableViewCell.h"

@interface NAClipViewController : NABaseViewController <UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *dataSouce;
//@property (nonatomic, assign)NSInteger noteNumber;
//@property (nonatomic, strong) NSMutableDictionary *NoteArray;
@property (nonatomic, strong) UIBarButtonItem *searchBarItem;
@property (nonatomic, strong) UIBarButtonItem *webBarItem;
@property (nonatomic, assign) NADoc *topPageDoc;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) NSMutableDictionary *regionDic;
@property (nonatomic, strong) NSMutableArray *clipDataSource;
@property (nonatomic, assign) NSInteger clipNumber;
@property (nonatomic,strong) NSString *labYearDetail;
@property (nonatomic,strong) NSMutableAttributedString *labMonthDayDetail;
@property (nonatomic,strong) NSString *labMianDetail;
@property (nonatomic,strong) UILabel *labYearHore;
@property (nonatomic,strong) UILabel *labMonthDayHore;
@property (nonatomic,strong) UILabel *labMianHore;
@property (nonatomic, assign) NSInteger haveChangeIndex;
@property (nonatomic, strong) NSString *isfromWhere;
@end

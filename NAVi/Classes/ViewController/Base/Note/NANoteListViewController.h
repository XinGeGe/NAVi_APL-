
#import "NABaseViewController.h"
#import "NAGripToolbar.h"
#import "NAHomeViewController.h"
#import "DateUtil.h"
#import "NoteViewPagerViewController.h"
typedef void(^selecteddic)(NADoc *doc);
@interface NANoteListViewController : NoteViewPagerViewController <UITextViewDelegate>

@property (nonatomic, strong) selecteddic selectmynoteCompletionBlock;
@property (nonatomic, strong) NSMutableArray *NotePageArray;
@property (nonatomic, readwrite)NSInteger myselectIndex;
@property (nonatomic, strong) NADoc *doc;
@property (nonatomic, strong) NADoc *other;
@property (nonatomic, strong) UIBarButtonItem *searchBarItem;
@property (nonatomic, strong) UIBarButtonItem *webBarItem;
@property (nonatomic, assign) NADoc *topPageDoc;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) NSMutableArray *clipDataSource;

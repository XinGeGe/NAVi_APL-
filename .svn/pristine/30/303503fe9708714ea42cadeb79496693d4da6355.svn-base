
#import <UIKit/UIKit.h>
#import "NACustomButtonItem.h"
#import "NASaveData.h"

typedef enum {
    NAHomeToobarModeNone        = 0,
    NAHomeToobarModeDayJournal  = 1,
    NAHomeToobarModeGrip        = 2,
    NAHomeToobarModeArticle     = 3,
    NAHomeToobarModePaper       = 4,
    NAHomeToobarModeDigest      = 5,
    NAHomeToobarModeSetting     = 6,
    NAHomeToobarModeNewsList    = 7,
    NAHomeToobarModePublication = 8,
    NAHomeToobarModeSokuho      = 9,
    NAHomeToobarModeSearchLastNews      = 10,
} NAHomeToobarMode;

@protocol NAHomeToobarDelegate <NSObject>

- (void)toolbarActionWithType:(NAHomeToobarMode)mode;

@end

@interface NAHomeToobar : UIToolbar <NACustomButtonItemDelegate>

@property (nonatomic, assign) id homeBarDelegate;
@property (nonatomic, assign) BOOL ishavesokuho;

@property (nonatomic, strong) UIBarButtonItem *dayJournalButtonItem;
@property (nonatomic, strong) UIBarButtonItem *newsButtonItem;
@property (nonatomic, strong) UIBarButtonItem *searchLastNewsButtonItem;
@property (nonatomic, strong) UIBarButtonItem *paperButtonItem;
@property (nonatomic, strong) UIBarButtonItem *settingButtonItem;
@property (nonatomic, strong) UIBarButtonItem *clipButtonItem;
@property (nonatomic, strong) UIBarButtonItem *noteButtonItem;
@property (nonatomic, strong) UIBarButtonItem *publicationButtonItem;
@property (nonatomic, strong) UIBarButtonItem *sokuhoButtonItem;
@property (nonatomic, strong) UIBarButtonItem *spaceButtonItem;
@property (nonatomic, strong) NACustomButtonItem *dayJournalItem;
@property (nonatomic, strong) NACustomButtonItem *newsItem;
@property (nonatomic, strong) NACustomButtonItem *paperItem;
@property (nonatomic, strong) NACustomButtonItem *settingItem;
@property (nonatomic, strong) NACustomButtonItem *clipItem;
@property (nonatomic, strong) NACustomButtonItem *noteItem;
@property (nonatomic, strong) NACustomButtonItem *publicationItem;
@property (nonatomic, strong) NACustomButtonItem *sokuhoItem;
@property (nonatomic, strong) NACustomButtonItem *searchLastNewsItem;

@property (nonatomic, strong) UILabel *line;

- (void)noteItemEnable:(BOOL)enable;

@end


#import <UIKit/UIKit.h>
#import "NAPaperView.h"
#import "NADateView.h"
#import "NAArticleView.h"
#import "NAMenuView.h"

typedef enum {
    NAPopoverNone      = 0,
    NAPopoverDate      = 1,
    NAPopoverArticle   = 2,
    NAPopoverPaper     = 3,
    NAPopoverMenu      = 4,
} NAPopoverBackgroundType;

@protocol NAPopoverBackgroundViewDelegate <NSObject>

- (void)popoverDelegateWithType:(NAPopoverBackgroundType)aType withDataSource:(id)object;
- (void)resetToolBar;
@end


@interface NAPopoverBackgroundView : UIView <NAMenuViewDelegate, NAPaperViewDelegate>

@property (nonatomic, assign) id delegate;
@property (nonatomic, strong) NAPaperView *paperView;
@property (nonatomic, strong) NAArticleView *articleView;
@property (nonatomic, strong) NADateView *dateView;
@property (nonatomic, strong) NAMenuView *menuView;
@property (nonatomic, assign) NAPopoverBackgroundType popType;
@property (nonatomic, strong) UIView *typeView;
@property (nonatomic, readwrite) NSInteger currentindex;

- (void)showPopoverView:(NAPopoverBackgroundType)type withInfo:(NSArray *)infos;
- (void)hidePopoverView;
- (BOOL)isShowPopoverView;


@end

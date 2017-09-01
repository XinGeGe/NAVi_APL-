
#import <UIKit/UIKit.h>
#import "NADefine.h"
#import "NABaseNavigationController.h"
#import "UIAlertView+Additions.h"
#import "ProgressHUD.h"
#import "NASaveData.h"
#import "NSString+NAAPI.h"
#import "NAFileManager.h"
#import "DataModels.h"
#import "AGWindowView.h"


@interface NABaseViewController : UIViewController

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIBarButtonItem *backBtnItem;
@property (nonatomic, strong) UIBarButtonItem *homeBtnItem;

- (void)initViews;
- (void)updateViews;
- (void)setNavMainTitle:(NSString *)mtitle
               subTitle:(NSString *)sTitle;

@end

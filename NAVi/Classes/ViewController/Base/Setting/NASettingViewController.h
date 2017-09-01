
#import "NABaseViewController.h"
#import "NASetSwithTableViewCell.h"
#import "NAExpansionView.h"
#import "NARadioButtonTableViewCell.h"
#import "NALoginClient.h"





typedef void(^logoutBlock)(BOOL finish);

@interface NASettingViewController : NABaseViewController<UITextFieldDelegate,UIAlertViewDelegate,UIWebViewDelegate>{
    NAExpansionView *naexview;
    BOOL isSelectpage;
}

@property (nonatomic, strong) logoutBlock logoutCompletionBlock;
@property (nonatomic, strong) NSString *isfromWhere;
@end

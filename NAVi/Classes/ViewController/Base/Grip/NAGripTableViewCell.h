
#import <UIKit/UIKit.h>


typedef enum {
    NADeviceNone      = 0,
    NAiPhonePortrait  = 1,
    NAiPhoneLandscape = 2,
    NAiPadPortrait    = 3,
    NAiPadLandscape   = 4,
} NAGripTableViewCellDeviceType;

#define NAiPhonePortraitCellHeight    139
#define NAiPhoneLandscapeCellHeight   139
#define NAiPadPortraitCellHeight      100
#define NAiPadLandscapeCellHeight     100

@interface NAGripTableViewCell : UITableViewCell<UIWebViewDelegate>

@property (nonatomic, strong) UITextView *titleLbl;
@property (nonatomic, strong) UIWebView *detailLbl;
@property (nonatomic, strong) UITextView *dateLbl;
@property (nonatomic, assign) NAGripTableViewCellDeviceType cellType;
@property (nonatomic, assign) BOOL clipType;
@property (nonatomic, strong) NSString *detailtext;
@property (nonatomic, strong) NSString *isSelected;
- (void)cellClickStatus:(BOOL)aClick;
- (void)searchMatchInDirection:(NSString *)mysearchstr;
@end

//
//  NAMyClipTableViewCell.h
//  NAVi
//
//  Created by y fs on 15/10/29.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SlideDeleteCell.h"

typedef enum {
    NAMyDeviceNone      = 0,
    NAMyiPhonePortrait  = 1,
    NAMyiPhoneLandscape = 2,
    NAMyiPadPortrait    = 3,
    NAMyiPadLandscape   = 4,
} NAMyGripTableViewCellDeviceType;

#define NAiPhonePortraitCellHeight    129
#define NAiPhoneLandscapeCellHeight   129
#define NAiPadPortraitCellHeight      129
#define NAiPadLandscapeCellHeight     129

@interface NAMyClipTableViewCell : UITableViewCell<UIWebViewDelegate>

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *detailLbl;
@property (nonatomic, strong) UITextView *dateLbl;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIWebView *detailWeb;
@property (nonatomic, assign) NAMyGripTableViewCellDeviceType cellType;
@property (nonatomic, assign) BOOL clipType;
@property (nonatomic, assign) BOOL isHaveRuby;
@property (nonatomic, strong) NSString *detailtext;
@property (nonatomic, strong) NSString *isSelected;
@property (nonatomic, strong) UIImageView *clipImg;
@property (nonatomic, strong) UILabel *clipLbl;

- (void)cellClickStatus:(BOOL)aClick;
- (void)searchMatchInDirection:(NSString *)mysearchstr;
- (void)loadDetailWithisHaveRuby:(BOOL)isRuby;

@end

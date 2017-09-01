//
//  NANoteCell.h
//  naviKomei
//
//  Created by y fs on 15/11/17.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAGripTableViewCell.h"

#define NANoteiPhonePortraitCellHeight    109
#define NANoteiPhoneLandscapeCellHeight   81
#define NANoteiPadPortraitCellHeight      109
#define NANoteiPadLandscapeCellHeight     81

@interface NANoteCell : UITableViewCell<UIWebViewDelegate>
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *detailLbl;
@property (nonatomic, strong) UIWebView *detailWeb;
@property (nonatomic, strong) UILabel *dateLbl;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) NAGripTableViewCellDeviceType cellType;
@property (nonatomic, assign) BOOL clipType;
@property (nonatomic, assign) BOOL isHaveRuby;
@property (nonatomic, strong) NSString *detailtext;
@property (nonatomic, strong) NSString *isSelected;
- (void)cellClickStatus:(BOOL)aClick;
- (void)searchMatchInDirection:(NSString *)mysearchstr;
- (void)loadDetailWithisHaveRuby:(BOOL)isRuby;
@end

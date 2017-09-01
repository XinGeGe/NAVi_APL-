//
//  NASearchResultTableViewCell.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/8/1.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAGripTableViewCell.h"

#define NANoteiPhonePortraitCellHeight    139
#define NANoteiPhoneLandscapeCellHeight   111
#define NANoteiPadPortraitCellHeight      110
#define NANoteiPadLandscapeCellHeight     110
@interface NASearchResultTableViewCell : UITableViewCell<UIWebViewDelegate>
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

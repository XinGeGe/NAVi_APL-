//
//  NAGifuSWView.h
//  NAVi
//
//  Created by y fs on 15/7/20.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface NAGifuSWView : UIView<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *mywebview;

@property (nonatomic, strong) NSMutableArray *displayNotes;
@property (nonatomic, strong)NSString *viewPattern;
@property (nonatomic, readwrite) BOOL isTateShow;
@property (nonatomic, assign) NSInteger myFontSize;
@property (nonatomic, strong)NSString *keyword;
@property (nonatomic, assign)BOOL isThefirst;

- (void)setShowStyle:(BOOL)isTateShow;
- (void)updateLayout;
- (void)loadHtml;
- (NSString *)getSelectedNote;
- (void)changeFontSize;
@end

//
//  NADetailSwipeImageViewController.h
//  NAVi
//
//  Created by y fs on 15/6/16.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>
#import "SwipeView.h"
#import "NABaseViewController.h"
#import "UIImageView+WebCache.h"
#import "NAImageDetailClass.h"
#import "NAMoviePlayerController.h"
#import "KxMenu.h"
#import "WQPDFManager.h"


@interface NADetailSwipeImageViewController : NABaseViewController < UIScrollViewDelegate,MFMailComposeViewControllerDelegate>{
    NSString *curPaperIndexNo;
    NSString *curNoteIndexNo;
}
@property (nonatomic, strong) UIBarButtonItem *backBarItem;
@property (nonatomic, strong) NSString *noteTitle;
@property (nonatomic, strong) NAClipDoc *mailDoc;
@property (nonatomic, strong) NAClipDoc *myclipDoc;
@property (nonatomic,strong) NSArray *imagearray;
@property (nonatomic, strong) NAClipDoc *noteDoc;
@property (nonatomic, strong) NAImageDetailClass *imageBaseClass;
@property (nonatomic, readwrite) BOOL isRelevantPhoto;
@property (nonatomic, strong) NSString *isfromWhere;
+ (CGFloat)heightWithText:(NSString *)text;
@end

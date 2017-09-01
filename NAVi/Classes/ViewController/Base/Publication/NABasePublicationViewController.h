//
//  NABasePublicationViewController.h
//  NAVi
//
//  Created by y fs on 15/12/9.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NADocCell.h"
#import "NADocPadCell.h"
#import "TOWebViewController.h"


typedef void(^selectedDoc)(NADoc *obj);
@interface NABasePublicationViewController : NABaseViewController<UIWebViewDelegate>
@property (nonatomic, strong) NADoc *currDoc;
@property (nonatomic, strong) selectedDoc selectedDocCompletionBlock;

@property (nonatomic, strong) UITableView *tView;
@property (nonatomic, strong) NSMutableArray *dateSelectedArray;
@property (nonatomic,strong)NSMutableArray *publisherInfoArray;
@property (nonatomic, strong) UIWebView *mywebview;


-(NSString *) getMainTitleText:(NADoc *)doc;
-(NSString *) getSubTitleText:(NADoc *)doc;
@end

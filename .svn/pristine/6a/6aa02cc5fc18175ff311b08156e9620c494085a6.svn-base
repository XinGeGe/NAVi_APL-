//
//  NAHYCDownloadHelper.h
//  NAVi
//
//  Created by y fs on 15/5/13.
//  Copyright (c) 2015年 dxc. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NAFileManager.h"
#import "NADownLoadImageClient.h"


@interface NADownloadHelper : NSObject

@property (nonatomic, strong) NSMutableArray *docs;

@property (nonatomic, strong) NSMutableArray *sokuhoDocs;

@property (nonatomic, strong) NSMutableArray *doneThumbarray;

@property (nonatomic, strong) NSMutableArray *doneNormalarray;

@property (nonatomic, strong) NSMutableArray *doneLargearray;

@property (nonatomic, strong) NSMutableArray *doneSokuhoarray;

@property (nonatomic, readwrite)NSInteger changenum;

+ (NADownloadHelper *)sharedInstance;

- (void)initTask;
- (void)initImageTask;
- (void)initSokuhoTask:(NAMasterBaseClass *)masterBaseClass;

- (void)downloadThumb:(NSArray *)list index:(NSInteger)index;

- (void)downloadNote:(NSArray *)list start:(NSInteger)start end:(NSInteger)end isSetInDoc:(BOOL)isSetInDoc;

- (void)downloadCurrentImage:(NADoc *)doc
                downloadtype:(NSString *)downloadtype
             completionBlock:(void(^)(id image, bool isDownloaded, NSError *error))completion;

- (void)downloadCurrentSokuho:(NASDoc *)doc
                completionBlock:(void(^)(id search, NSError *error))completion;

- (void)cancel;
- (void)stopNoty;
- (void)startNoty;
@end

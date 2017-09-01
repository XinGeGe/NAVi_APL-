/*!
 @header NAHYCDownloadHelper.m
 @abstract ダワンロード task
 @author eland
 @version 1.00 2015/05/20 Creation
 */

#import "NADownloadHelper.h"

@implementation NADownloadHelper{
    NSInteger isdownloading;
    BOOL isLoadedNotification;
    NSInteger curDownloadIndex;
    
    NSInteger nextDownloadIndex;
    NSInteger nextOtherDownloadIndex;
    NSString *nextGenreId;
    NSString *nextDownloadType;
    
    NSInteger downloadcountnum;
    NSMutableDictionary *postdic;
    BOOL isStopnotyFlag;
    
    
}

@synthesize doneThumbarray;
@synthesize doneNormalarray;
@synthesize doneLargearray;
@synthesize doneSokuhoarray;
@synthesize changenum;

+ (NADownloadHelper *)sharedInstance
{
    static NADownloadHelper *_sharedInstance = nil;
    static dispatch_once_t managerPredicate;
    dispatch_once(&managerPredicate, ^{
        _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}

/**
 * download task初期化
 *
 */
-(void)initTask{
    // 初期化
    isdownloading=0;

    if (!isLoadedNotification) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startDownloadImageTask:) name:@"startDownloadImageTask" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startDownloadSokuhoTask:) name:@"startDownloadSokuhoTask" object:nil];

        isLoadedNotification = YES;
    }

    [self initImageTask];
    self.sokuhoDocs=[[NSMutableArray alloc]init];
    doneSokuhoarray=[[NSMutableArray alloc]init];
    nextGenreId = @"";
}

/**
 * download task初期化
 *
 */
-(void)initImageTask{
    curDownloadIndex = 0;
    nextDownloadIndex = -1;
    nextOtherDownloadIndex = -1;
    isStopnotyFlag=NO;
    
    doneThumbarray=[[NSMutableArray alloc]init];
    doneNormalarray=[[NSMutableArray alloc]init];
    doneLargearray=[[NSMutableArray alloc]init];
}

/**
 * 速報 task初期化
 *
 */
-(void)initSokuhoTask:(NAMasterBaseClass *)masterBaseClass
{
    self.sokuhoDocs=[[NSMutableArray alloc]init];
    doneSokuhoarray=[[NSMutableArray alloc]init];
    nextGenreId = @"";
    
    NSArray *groupinfos = masterBaseClass.masterData.publishers.publisherGroupInfo;
    for (NAPublisherGroupInfo *groupinfo in groupinfos) {
        for (NAPublisherInfo *publisherInfo in groupinfo.publisherInfo) {
            for (NAPublicationInfo *publication in publisherInfo.publicationInfo) {
                NAContent *mycontent= publication.content;
                if (mycontent && [mycontent.contentid isEqualToString:@"S"]) {
                    for (NAGenre *genre in mycontent.genrearray) {
                        NASDoc *sdoc=[[NASDoc alloc]init];
                        
                        sdoc.publisherGroupInfoId=groupinfo.publisherGroupInfoIdentifier;
                        sdoc.publisherInfoId=publisherInfo.publisherInfoIdentifier;
                        sdoc.publicationInfoId=publication.publicationInfoIdentifier;
                        sdoc.editionInfoId=@"S";
                        sdoc.genreid=genre.genreid;
                        sdoc.gname=genre.name;
                        
                        [self.sokuhoDocs addObject:sdoc];
                    }
                }
            }
        }
    }
}

/**
 * download image task始め
 *
 */
-(void)startDownloadImageTask:(NSNotification *)notify{
    // postdic初期化
    postdic=[[NSMutableDictionary alloc]init];
    
    NSDictionary *dic=[notify userInfo];
    // 次download Image indexを設定
    if ([dic objectForKey:@"imageindex"]) {
        nextDownloadIndex = ((NSNumber *)[dic objectForKey:@"imageindex"]).integerValue;
        nextDownloadType = [dic objectForKey:@"downloadtype"];
        
        if ([self isDownloadedimage:nextDownloadIndex Downtype:nextDownloadType] ) {
            [self UpdateModelNotify:nextDownloadType secindex:nextDownloadIndex];
            nextDownloadIndex = -1;
        } else {
            if (nextDownloadIndex<self.docs.count) {
                NADoc *doc = self.docs[nextDownloadIndex];
                NSString *path = [self getFilePathFromLocal:doc downloadType:nextDownloadType];
                
                // file exist
                if (path) {
                    [self UpdateModelNotify:nextDownloadType secindex:nextDownloadIndex];
                    nextDownloadIndex = -1;
                }
            }
           
        }
        
        // 2紙面の場合
        if ([dic objectForKey:@"otherImageIndex"]) {
            nextOtherDownloadIndex = ((NSNumber *)[dic objectForKey:@"otherImageIndex"]).integerValue;
            
            if ([self isDownloadedimage:nextOtherDownloadIndex Downtype:nextDownloadType] ) {
                [self UpdateModelNotify:nextDownloadType secindex:nextOtherDownloadIndex];
                nextOtherDownloadIndex = -1;
            } else {
                if (nextOtherDownloadIndex<self.docs.count) {
                    NADoc *doc = self.docs[nextOtherDownloadIndex];
                    NSString *path = [self getFilePathFromLocal:doc downloadType:nextDownloadType];
                    
                    // file exist
                    if (path) {
                        [self UpdateModelNotify:nextDownloadType secindex:nextOtherDownloadIndex];
                        nextOtherDownloadIndex = -1;
                    }
                }
                
            }
        } else {
            nextOtherDownloadIndex = -1;
        }
    }
    
    // 今、ダワンロード中場合、待て
    if (isdownloading == 2) {
        return;
    }
   
    // downloadTypeを設定
    NSString *downloadType=[dic objectForKey:@"downloadtype"];
    
    if (doneThumbarray.count >= self.docs.count) {
        downloadType = NANormalimage;
    }
    if (doneNormalarray.count >= self.docs.count) {
        downloadType = NALargeimage;
    }
    if ([downloadType isEqualToString: NALargeimage] && doneLargearray.count >= self.docs.count) {
        [self UpdateModelNotify:downloadType secindex:curDownloadIndex];
        
        if (doneSokuhoarray.count < self.sokuhoDocs.count) {
            [postdic setObject:nextGenreId forKey:@"genreId"];
            [postdic setObject:NASOKUHO forKey:@"downloadtype"];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadSokuhoTask" object:nil userInfo:postdic];
        }
        return;
    }
//    NSLog(@"startDownloadImageTask downloadType==%@  nextDownloadIndex==%d curDownloadIndex==%d",downloadType,nextDownloadIndex,curDownloadIndex);

    if (nextDownloadIndex != -1) {
        curDownloadIndex = nextDownloadIndex;
        downloadType = nextDownloadType;
        nextDownloadIndex = -1;
    } else if (nextOtherDownloadIndex != -1) {
        curDownloadIndex = nextOtherDownloadIndex;
        downloadType = nextDownloadType;
        nextOtherDownloadIndex = -1;
    }
    
    if (curDownloadIndex >= self.docs.count) {
        curDownloadIndex = 0;
        
        if ([downloadType isEqualToString:NAThumbimage]) {
            if (doneThumbarray.count >= self.docs.count) {
                [postdic setObject:NANormalimage forKey:@"downloadtype"];
            }else{
                [postdic setObject:NAThumbimage forKey:@"downloadtype"];
            }
            
        }else if ([downloadType isEqualToString:NANormalimage]){
            if (doneNormalarray.count >= self.docs.count) {
                [postdic setObject:NALargeimage forKey:@"downloadtype"];
            }else{
                [postdic setObject:NANormalimage forKey:@"downloadtype"];
            }
            
        }else if ([downloadType isEqualToString:NALargeimage]){
            if (doneLargearray.count >= self.docs.count) {
                return;
            }else{
                [postdic setObject:NALargeimage forKey:@"downloadtype"];
            }
        }

        [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadImageTask" object:nil userInfo:postdic];
        return;
    }
    
    
    
    // ダワンロード
    if (isdownloading < 2) {
        
//        NSLog(@"download %ld %@", (long)curDownloadIndex, downloadType);
        isdownloading++;
        NADoc *doc = self.docs[curDownloadIndex];
        
        if ([self isDownloadedimage:curDownloadIndex Downtype:downloadType] ) {
            [self downloadNextImage:curDownloadIndex Downtype:downloadType Withmydoc:doc delayMillis:0];
        }else{
            
            [self downloadCurrentImage:doc downloadtype:downloadType completionBlock:^(id image, bool isDownloaded, NSError *error) {
                if (isDownloaded && !error) {
                        CGFloat delayMillis = 0;
                        if (![downloadType isEqualToString:NAThumbimage]) {
                            delayMillis=0.1;
                        }
                        [self downloadNextImage:curDownloadIndex Downtype:downloadType Withmydoc:doc delayMillis:delayMillis];
                        //[self downloadNextImage:curDownloadIndex Downtype:downloadType Withmydoc:doc];
                } else {
                    [self downloadNextImage:curDownloadIndex Downtype:downloadType Withmydoc:doc delayMillis:0];
                }
            }];
        }
    }
}

/**
 * download 速報 task始め
 *
 */
-(void)startDownloadSokuhoTask:(NSNotification *)notify{
    // postdic初期化
    postdic=[[NSMutableDictionary alloc]init];
    
    NSDictionary *dic=[notify userInfo];
    NSString *genreId = (NSString *)[dic objectForKey:@"genreId"];
    nextGenreId = genreId;
    nextDownloadType = [dic objectForKey:@"downloadtype"];

    if ([genreId isEqualToString:@""]) {
        [self downloadNextSokuho:@""];
        return;
    }

    if ([self isDownloadedSokuho:genreId] ) {
        [self downloadNextSokuho:genreId];
        return;
    }
    
    // 今、ダワンロード中場合、待て
    if (isdownloading == 2) {
        return;
    }
    
    // ダワンロード
    if (isdownloading < 2) {
        isdownloading++;
        
        NASDoc *doc;
        for (NASDoc *genre in self.sokuhoDocs) {
            if ([genreId isEqualToString:genre.genreid]) {
                doc = genre;
                break;
            }
        }
        
        if (doc) {
            [self downloadCurrentSokuho:doc completionBlock:^(id data, NSError *error) {
                isdownloading--;
                if (!error) {
                    [self downloadNextSokuho:genreId];
                } else {
                    [self downloadNextSokuho:genreId];;
                }
            }];
            
        } else {
            isdownloading--;
            [self downloadNextSokuho:@""];
        }
    }
}

/**
 * 次紙面をdownload
 *
 */
-(void)downloadNextImage:(NSInteger)mynum Downtype:(NSString *)downloadtype Withmydoc:(NADoc *)mydoc delayMillis:(CGFloat)delayMillis{
    // downloaded listを追加
    if (![self isDownloadedimage:mynum Downtype:downloadtype]) {
        if ([downloadtype isEqualToString:NAThumbimage]) {
            [doneThumbarray addObject:[NSNumber numberWithInteger:mynum]];
        }else if ([downloadtype isEqualToString:NANormalimage]){
            [doneNormalarray addObject:[NSNumber numberWithInteger:mynum]];
        }else if ([downloadtype isEqualToString:NALargeimage]){
            [doneLargearray addObject:[NSNumber numberWithInteger:mynum]];
        }
    }
    
    // 次紙面をdownload
    isdownloading--;
    if ([self.docs containsObject:mydoc]) {
        [self UpdateModelNotify:downloadtype secindex:mynum];
        
        if ([NASOKUHO isEqualToString: nextDownloadType]) {
            [postdic setObject:nextGenreId forKey:@"genreId"];
            [postdic setObject:nextDownloadType forKey:@"downloadtype"];
        
            [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadSokuhoTask" object:nil userInfo:postdic];
        }
            
        // downloadtypeを設定
        if (doneThumbarray.count<self.docs.count) {
            downloadtype = NAThumbimage;
        }else if (doneNormalarray.count<self.docs.count) {
            downloadtype = NANormalimage;
        }else if (doneLargearray.count<self.docs.count) {
            downloadtype = NALargeimage;
        }
        
        for (NSInteger index = 1; index < self.docs.count; index++) {
            NSInteger downloadNextIndex = curDownloadIndex + index;
            if (downloadNextIndex > self.docs.count - 1) {
                downloadNextIndex = downloadNextIndex - self.docs.count;
            }
            
            if (![self isDownloadedimage:downloadNextIndex Downtype:downloadtype]) {
                if ([NAThumbimage isEqualToString:downloadtype]) {
                    NADoc *doc = self.docs[downloadNextIndex];
                    NSString *path = [[NAFileManager sharedInstance] searchPathWithFileName:doc
                                                                              withImageName:NAPageMiniPhoto];
                    
                    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:FALSE]) {
                        doc.whichimage = NAThumbimage;
                        if (![self isDownloadedimage:downloadNextIndex Downtype:downloadtype]) {
                            [doneThumbarray addObject:[NSNumber numberWithInteger:downloadNextIndex]];
                        }

                    } else {
                        curDownloadIndex = downloadNextIndex;
//                        NSLog(@"file not download %ld %@", (long)curDownloadIndex, downloadtype);
                        break;
                    }
                } else {
                    curDownloadIndex = downloadNextIndex;
//                    NSLog(@"is not Downloaded image %ld %@", (long)curDownloadIndex, downloadtype);
                    break;
                }
            }
        }
        
        if ([NASaveData isAlldownload] || [downloadtype isEqualToString:NAThumbimage] || nextDownloadIndex != -1 || nextOtherDownloadIndex != -1) {
            if (delayMillis != 0) {
                AFTER(delayMillis, ^{
                    NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
                    [tmpdic setObject:NAThumbimage forKey:@"downloadtype"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadImageTask" object:nil userInfo:tmpdic];
                });
            }else{
                NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
                [tmpdic setObject:NAThumbimage forKey:@"downloadtype"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadImageTask" object:nil userInfo:tmpdic];
            }

        } else {
            if (doneSokuhoarray.count < self.sokuhoDocs.count) {
                [postdic setObject:nextGenreId forKey:@"genreId"];
                [postdic setObject:NASOKUHO forKey:@"downloadtype"];
                
                if (delayMillis != 0) {
                    AFTER(delayMillis, ^{
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadSokuhoTask" object:nil userInfo:postdic];
                    });
                }else{
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadSokuhoTask" object:nil userInfo:postdic];
                }

            }
        }
    }
}

/**
 * 次速報をdownload
 *
 */
-(void)downloadNextSokuho:(NSString *)genreId{
    if ([NAThumbimage isEqualToString: nextDownloadType] ||
        [NANormalimage isEqualToString: nextDownloadType] ||
        [NALargeimage isEqualToString: nextDownloadType]) {
        
        [postdic setObject:nextDownloadType forKey:@"downloadtype"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadImageTask" object:nil userInfo:postdic];
        return;
    }
    
    // 紙面をdownload
    if (doneSokuhoarray.count >= self.sokuhoDocs.count) {
        if (doneThumbarray.count < self.docs.count
         || doneNormalarray.count < self.docs.count
         || doneLargearray.count < self.docs.count) {
            
            if (doneThumbarray.count < self.docs.count) {
                [postdic setObject:NAThumbimage forKey:@"downloadtype"];
                nextDownloadType = NAThumbimage;
            } else if (doneNormalarray.count < self.docs.count) {
                [postdic setObject:NANormalimage forKey:@"downloadtype"];
                nextDownloadType = NANormalimage;
            } else if (doneLargearray.count < self.docs.count) {
                [postdic setObject:NALargeimage forKey:@"downloadtype"];
                nextDownloadType = NALargeimage;
            }

            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadImageTask" object:nil userInfo:postdic];
            return;
        } else {
            return;
        }
    }
    
    // 次速報をdownload
    NSInteger index = 0;
    for (NSInteger i=0; i<self.sokuhoDocs.count; i++) {
        NASDoc *genre = [self.sokuhoDocs objectAtIndex:i];
        if ([genreId isEqualToString:genre.genreid]) {
            if (i == self.sokuhoDocs.count - 1) {
                index = 0;
            } else {
                index = i + 1;
            }

            break;
        }
    }
    
    nextGenreId = ((NASDoc *)[self.sokuhoDocs objectAtIndex:index]).genreid;
    
    [postdic setObject:nextGenreId forKey:@"genreId"];
    [postdic setObject:NASOKUHO forKey:@"downloadtype"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"startDownloadSokuhoTask" object:nil userInfo:postdic];
}

/**
 * miniImage download
 *
 */
- (void)downloadThumb:(NSArray *)list index:(NSInteger)index
{
    if (index >= list.count) {
        return;
    }
    
    //　Thumbs image
    NADoc *doc = list[index];
    NSString *path = [[NAFileManager sharedInstance] searchPathWithFileName:doc
                                                              withImageName:NAPageMiniPhoto];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:FALSE]) {
        if ([NACheckNetwork sharedInstance].isHavenetwork){
            NSString *updatetime=[self formatUpdatetime:doc.lastUpdateDateAndTime];
            NSString *parmPageUrl = [[doc.miniPagePath stringByAppendingString:@"?"] stringByAppendingString:updatetime];
            
            [[NADownLoadImageClient sharedClient] postDownLoadImage:parmPageUrl completionBlock:^(id image, NSError *error) {
                if (!error) {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        [[NAFileManager sharedInstance] writeMinImageToSearchManager:UIImageJPEGRepresentation(image, 1) info:doc];
                    });
                    
                    if (![self isDownloadedimage:index Downtype:NAThumbimage]) {
                        [doneThumbarray addObject:[NSNumber numberWithInteger:index]];
                    }
                }
            }];
        }
    } else {
        if (![self isDownloadedimage:index Downtype:NAThumbimage]) {
            [doneThumbarray addObject:[NSNumber numberWithInteger:index]];
        }
    }
    
    [self downloadThumb:list index:index + 1];
}

/**
 * 記事xml download
 *
 */
- (void)downloadNote:(NSArray *)list start:(NSInteger)start end:(NSInteger)end isSetInDoc:(BOOL)isSetInDoc
{
    if (start >= end) {
        return;
    }
    
    if (start >= list.count) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NADoc *doc = list[start];
        
        NSString *path = [[NAFileManager sharedInstance] searchNoteName:doc withNoteName:NoteFileName];
        NSFileManager *fileManage = [NSFileManager defaultManager];
        if ([fileManage fileExistsAtPath:path isDirectory:FALSE]) {
            
            if (isSetInDoc) {
                NSData *data = [NSData dataWithContentsOfFile:path];
                SHXMLParser *parser = [[SHXMLParser alloc] init];
                NSDictionary *dic = [parser parseData:data];
                NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                NSArray *array = searchBaseClass.response.doc;
                
                for (NSInteger index=0; index<array.count; index++) {
                    NADoc *temdoc=[array objectAtIndex:index];
                    temdoc.miniPagePath=doc.miniPagePath;
                    temdoc.lastUpdateDateAndTime=doc.lastUpdateDateAndTime;
                }
                doc.notearray=array;
            }
        } else {
            
            NSDictionary *param = @{  @"Userid"       :  [NASaveData getDefaultUserID],
                                      @"UseDevice"    :  NAUserDevice,
                                      @"Rows"         :  @"99",
                                      @"K002"         :  @"4",
                                      @"K001"         :  doc.indexNo,
                                      @"Mode"         :  @"1",
                                      @"Fl"           :  [NSString clipListFl],
                                      };
            [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
                if (error) {
                    return;
                }
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    if (isSetInDoc) {
                        SHXMLParser *parser = [[SHXMLParser alloc] init];
                        NSDictionary *dic = [parser parseData:search];
                        NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                        NSArray *array = searchBaseClass.response.doc;
                        
                        for (NSInteger index=0; index<array.count; index++) {
                            NADoc *temdoc=[array objectAtIndex:index];
                            temdoc.miniPagePath=doc.miniPagePath;
                            temdoc.lastUpdateDateAndTime=doc.lastUpdateDateAndTime;
                        }
                        doc.notearray=array;
                    }
                    
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        [[NAFileManager sharedInstance] writeNoteToSearchManager:search info:doc];
                        if (start==0) {
                            AFTER(0.5, ^{
                                [[NSNotificationCenter defaultCenter]postNotificationName:NOTYDrawFirstnote object:nil];
                            });
                            
                        }
                    });
                    
                });
            }];
        }
        
    });
    [self downloadNote:list start:start + 1 end:end isSetInDoc:isSetInDoc];
}

/**
 * 紙面download
 *
 */
- (void)downloadCurrentImage:(NADoc *)doc
                downloadtype:(NSString *)downloadtype
             completionBlock:(void(^)(id image, bool isDownloaded, NSError *error))completion
{
    NSString *path = [self getFilePathFromLocal:doc downloadType:downloadtype];
    
    // file exist
    if (path) {
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        completion (image, YES, nil);
    } else {
        NSString *imageUri = [self getImageUri:doc downloadType:downloadtype];
        
        //NSLog(@"startDownloadImageTask %ld %@ %ld", (long)isdownloading, downloadtype, [self.docs indexOfObject: doc]);
        
        [[NADownLoadImageClient sharedClient] postDownLoadImage:imageUri completionBlock:^(id image, NSError *error) {
            if (!error) {
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                    if ([downloadtype isEqualToString:NAThumbimage]) {
                        [[NAFileManager sharedInstance] writeMinImageToSearchManager:UIImageJPEGRepresentation(image, 1) info:doc];
                    }else if ([downloadtype isEqualToString:NANormalimage]){
                        [[NAFileManager sharedInstance] writeMiddleImageToSearchManager:UIImageJPEGRepresentation(image, 1) info:doc];
                    }else if ([downloadtype isEqualToString:NALargeimage]){
                        [[NAFileManager sharedInstance] writeLargeImageToSearchManager:UIImageJPEGRepresentation(image, 1) info:doc];
                    }
                    completion (image, NO, error);
                });
                
                
            }else{
                completion (image, NO, error);
            }
        }];
    }
}

/**
 * 速報download
 *
 */
- (void)downloadCurrentSokuho:(NASDoc *)doc
             completionBlock:(void(^)(id search, NSError *error))completion
{
//    NSLog(@"startDownloadSokuhoTask %ld %@ %@", (long)isdownloading, nextDownloadType, doc.genreid);

    NSDictionary *param = @{
                            @"Userid":[NASaveData getLoginUserId],
                            @"Rows":[NSString stringWithFormat:@"%ld",(long)[NASaveData getFastNewsRows]],
                            @"K002":@"4",
                            @"Mode":@"1",
                            @"K004":doc.publisherGroupInfoId,
                            @"K005":doc.publisherInfoId,
                            @"K006":doc.publicationInfoId,
                            @"K008":doc.editionInfoId,
                            @"K009":doc.genreid,
                            @"UseDevice":NAUserDevice,
                            @"Keyword":@"",
                            @"Fl":[NSString searchCurrentAtricleFl],
                            @"Sort":@"K053:desc,K032:desc",
                            @"Start":[NSString stringWithFormat:@"%d",0],
                            
                            };
    
    [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [[NAFileManager sharedInstance] writeSokuhoToSearchManager:search info:doc];
            });
            // 速報downloaded listを追加
            if (![self isDownloadedSokuho:doc.genreid] ) {
                [doneSokuhoarray addObject:doc.genreid];
            }
        }
        
        completion (search, error);
    }];
}

/**
 * App cacheにファイルがあるの確認
 *
 *
 */
-(NSString *)getFilePathFromLocal:(NADoc *)doc
                     downloadType:(NSString *)downloadType {
    NSString *filename;
    if ([downloadType isEqualToString:NAThumbimage]) {
        filename=NAPageMiniPhoto;
    }else if ([downloadType isEqualToString:NANormalimage]){
        filename=NAPageNormalPhoto;
    }else if ([downloadType isEqualToString:NALargeimage]){
        filename=NAPageLargePhoto;
    }
    NSString *path = [[NAFileManager sharedInstance] searchPathWithFileName:doc withImageName:filename];
    
    // file exist
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:FALSE]) {
        return path;
    }
    
    return nil;
}

/**
 * download image Uriを取得
 *
 *
 */
-(NSString *)getImageUri:(NADoc *)doc
            downloadType:(NSString *)downloadType {
    NSString *pagePath;
    if ([downloadType isEqualToString:NAThumbimage]) {
        pagePath=doc.miniPagePath;
    }else if ([downloadType isEqualToString:NANormalimage]){
        pagePath=doc.pagePath4;
    }else if ([downloadType isEqualToString:NALargeimage]){
        pagePath=doc.pagePath3;
    }
    if ([pagePath isKindOfClass:[NSString class]]) {
        NSString *updatetime=[self formatUpdatetime:doc.lastUpdateDateAndTime];
        NSString *imageUri = [[pagePath stringByAppendingString:@"?"] stringByAppendingString:updatetime];
        
        return imageUri;
    }else{
        return @"";
    }
   
}

/**
 * format date
 *
 */
-(NSString *)formatUpdatetime:(NSString *)updatetime{
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@" " withString:@""];
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    return updatetime;
}

/**
 * image is downloaded
 *
 */
-(BOOL)isDownloadedimage:(NSInteger )imageindex Downtype:(NSString *)dtype{
    NSArray *array;
    if ([dtype isEqualToString:@"Thumbimage"]) {
        array=doneThumbarray;
    }else if ([dtype isEqualToString:@"Normalimage"]){
        array=doneNormalarray;
    }else if ([dtype isEqualToString:@"Largeimage"]){
        array=doneLargearray;
    }else{
        array=doneThumbarray;
    }
    for (NSInteger i=0; i<array.count; i++) {
        NSNumber *num=[array objectAtIndex:i];
        if (num.integerValue==imageindex) {
            return YES;
        }
    }
    return NO;
}

/**
 * 速報 is downloaded
 *
 */
-(BOOL)isDownloadedSokuho:(NSString *)genreId {
    for (NSString *doneGenreId in doneSokuhoarray) {
        if ([genreId isEqualToString:doneGenreId]) {
            return YES;
        }
    }
    
    return NO;
}

/**
 * download task閉め
 *
 */
- (void)cancel
{
    // task stop
//    [[[NADownLoadImageClient sharedClient] operationQueue] cancelAllOperations];
    NSArray *operarray=[[NADownLoadImageClient sharedClient] operationQueue].operations;
    for (NSInteger index=0; index<operarray.count; index++) {
        NSOperation *operiation=[operarray objectAtIndex:index];
        [operiation cancel];
    }
    isdownloading = 0;
    // download情報をクリア
    doneThumbarray=[[NSMutableArray alloc]init];
    doneNormalarray=[[NSMutableArray alloc]init];
    doneLargearray=[[NSMutableArray alloc]init];

}

/**
 * stopNoty
 *
 */
- (void)stopNoty{
    // stopNoty
    isStopnotyFlag=YES;
}
- (void)startNoty{
    // startNoty
    isStopnotyFlag=NO;
}

/**
 * 画面更新のNotify
 *
 */
-(void)UpdateModelNotify:(NSString *)whichimage secindex:(NSInteger)imageindex {
    if (imageindex >= self.docs.count) {
        return;
    }
    NADoc *doc = self.docs[imageindex];
    doc.whichimage = whichimage;
    
    if (doc.thumbimage==nil) {
        BACK(^{ NSString *path = [[NAFileManager sharedInstance] searchPathWithFileName:doc withImageName:NAPageMiniPhoto];
            doc.thumbimage=[UIImage imageWithContentsOfFile:path];});
    }
    if ([whichimage isEqualToString:NAThumbimage]) {
        return;
    }
    
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc]init];
//    NSLog(@"UpdateModelNotify imageindex==%d  whichimage==%@",imageindex,whichimage);
    [mudic setObject:whichimage forKey:@"whichimage"];
    [mudic setObject:[NSNumber numberWithInteger:imageindex] forKey:@"imageindex"];
    [mudic setObject:[NSNumber numberWithInteger:doneThumbarray.count] forKey:@"thumbcount"];
    [mudic setObject:[NSNumber numberWithInteger:doneNormalarray.count] forKey:@"normalcount"];
    [mudic setObject:[NSNumber numberWithInteger:doneLargearray.count] forKey:@"largecount"];
    
    if (!isStopnotyFlag) {
         [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateMymodel" object:nil userInfo:mudic];
    }
   
}
@end

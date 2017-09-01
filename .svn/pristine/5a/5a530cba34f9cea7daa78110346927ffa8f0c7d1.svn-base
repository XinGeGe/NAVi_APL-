
#import "NAFileManager.h"
#import "SHXMLParser.h"
#import "NASaveData.h"
#import "NSString+NAAPI.h"

#define FILE_NAME  @"NaviFile"
#define SOKUHO_PATH  @"Sokuho"
#define MASTER_XML_PATH @"master.xml"
#define PAPER_XML_PATH @"paper.xml"
#define SEARCH_PAGE_IMAGE_FILE @"NaviFile/SearchPage/"
#define SEARCH_RESULT @"result.txt"
#define ALL_NOTE @"AllNote.xml"

NSString *const SokuhoFileName = @"Sokuho.xml";
NSString *const NoteFileName = @"Note.xml";
NSString *const NAPageMiniPhoto = @"NAPageMiniPhoto";
NSString *const NAPageNormalPhoto = @"NAPageNormalPhoto";
NSString *const NAPageLargePhoto = @"NAPageLargePhoto";
NSString *const NAImageExtendedName =@".jpg";

@implementation NAFileManager{
    NSString *baseCachesPath;
}

+ (NAFileManager *)sharedInstance
{
    static NAFileManager *_sharedInstance = nil;
    static dispatch_once_t managerPredicate;
    dispatch_once(&managerPredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        baseCachesPath = [[[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject] relativePath];
    }
    return self;
}

#pragma mark - utility -
#pragma mark

- (NSString *)cachesPath
{
    return baseCachesPath.copy;
}
//获得document

+(NSString *)documentsPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [paths objectAtIndex:0];
    
}
// 删除沙盒里的文件
+(void)deleteinitplistFile{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"init.plist"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        return ;
    }else {
        [fileManager removeItemAtPath:uniquePath error:nil];
    }
}
+(int)CopyFileToDocument:(NSString*)FileName{
    
    
    [self deleteinitplistFile];
    
    NSString *appFileName =[NSString stringWithFormat:@"%@//init.plist",[self documentsPath]];

    NSFileManager *fm = [NSFileManager defaultManager];
    
    //getfile
    NSString *backupDbPath = [[NSBundle mainBundle]
                              pathForResource:@"init"
                              ofType:@".plist"];
   
 
    // by the NSFileManager copy
    BOOL cp = [fm copyItemAtPath:backupDbPath toPath:appFileName error:nil];

    return cp;
}

/**
 * check file Exists
 *
 */
+(BOOL) FileIsExists:(NSString*) checkFile{
    
    
    
    if([[NSFileManager defaultManager]fileExistsAtPath:checkFile])
        
    {
        
        return true;
        
    }
    
    return  false;
}

/**
 * plistからdicを設定
 *
 */
+(NSDictionary *)ChangePlistTodic{
    
    NSString *docPath = [self documentsPath];
    NSString *filepath = [docPath stringByAppendingPathComponent:NAplist];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filepath];

    return dic;
}

/**
 * fileを作成
 *
 */
- (NSString *)creatFilePath:(NSString *)path withFileName:(NSString *)fileName
{
    NSString *userId = [NASaveData getLoginUserId];
    if (userId==nil) {
        userId = [NASaveData getDefaultUserID];
    }
    path = [[userId uppercaseString]stringByAppendingPathComponent:path];
    NSString *cachesPath = [self cachesPath];
    cachesPath = [cachesPath stringByAppendingPathComponent:path];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachesPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachesPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
        
    }
    cachesPath = [cachesPath stringByAppendingPathComponent:[fileName lastPathComponent]];
    return cachesPath;
    
}

/**
 * loginIdで、filepathを取得
 *
 */
- (NSString *)getFilePathwithUserid:(NSString *)userid
{
    NSString *cachesPath = [self cachesPath];
    cachesPath = [cachesPath stringByAppendingPathComponent:userid];
    return cachesPath;
    
}

/**
 * 全部fileを取得
 *
 */
- (NSArray *)getAllFileNameswithPath:(NSString *)dirName
{
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirName error:nil];
    return files;
}
- (NSArray *)getCurrentFileNameswithPath:(NSString *)dirName
{
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirName error:nil];
    return files;
}
#pragma mark - User Info -
#pragma mark
/**
 * ユザー別削除
 *
 */
- (void)deleteUserInfo
{
    NSString *cachesPath = [self cachesPath];
    NSString *path = [cachesPath stringByAppendingPathComponent:[NASaveData getLoginUserId]];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    
}

/**
 * ユザー別削除
 *
 */
- (void)deleteDetailInfo
{
    NSString *cachesPath = [self cachesPath];
    //NSString *path = [cachesPath stringByAppendingPathComponent:[NASaveData getLoginUserId]];
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachesPath error:nil];
    for (NSString *sub in array) {
        if (![sub isEqualToString:FILE_NAME] && ![sub isEqualToString:[NSString dateForSearch:[NSDate date]]]) {
            [[NSFileManager defaultManager] removeItemAtPath:[cachesPath stringByAppendingPathComponent:sub] error:nil];
        }
    }
    
    
}

/**
 * 検索結果を削除
 *
 */
- (void)deleteSearchResult
{
    NSString *path = [self creatFilePath:FILE_NAME withFileName:SEARCH_RESULT];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    
}
- (void)clearTheoldfileWithuserid:(NSString *)userid Thelastdate:(NSString *)lastdate{
    NSArray *dirnamearray=[self getAllFileNameswithPath:[self getFilePathwithUserid:userid]];
    
    for (NSInteger index=0; index<dirnamearray.count; index++) {
        NSString *pathname=[dirnamearray objectAtIndex:index];
        if (![pathname isEqualToString:FILE_NAME]
            && ![pathname isEqualToString:SOKUHO_PATH]
            && ![pathname isEqualToString:lastdate]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:[[self getFilePathwithUserid:userid] stringByAppendingPathComponent:pathname] error:nil];
            [[NASQLHelper sharedInstance]deletePaperInfoByUserIdAndolddate:userid Theolddate:pathname];
        }
    }
    
}
-(NSArray *)getNotClearFileDateArray:(NSString *)userid{
    NSArray *dirnamearray=[self getCurrentFileNameswithPath:[self getFilePathwithUserid:userid]];
    NSMutableArray *notClearDateArray=[[NSMutableArray alloc]init];
    for (NSInteger index=0; index<dirnamearray.count; index++) {
        NSString *pathname=[NSString stringWithFormat:@"%@/%@",[self getFilePathwithUserid:userid],[dirnamearray objectAtIndex:index]];
        if ([self isContainNotClearFile:pathname]&&![[dirnamearray objectAtIndex:index]isEqualToString:FILE_NAME]) {
            [notClearDateArray addObject:[dirnamearray objectAtIndex:index]];
        }
    }
    return notClearDateArray;
}
- (BOOL)isContainNotClearFile:(NSString *)filePath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:filePath error:&error];
    NSDate *fileModDate = [fileAttributes objectForKey:NSFileModificationDate];
    return [[NSDate date] timeIntervalSince1970]*1000-[fileModDate timeIntervalSince1970]*1000>[NASaveData getNotClearDays]*24*60*60*1000 ? NO:YES;
}
-(void)clearOldFileWithNotClearArray:(NSArray *)notClearArray WithUserid:(NSString *)userid{
    NSArray *dirnamearray=[self getCurrentFileNameswithPath:[self getFilePathwithUserid:userid]];
    for (NSInteger index=0; index<dirnamearray.count; index++) {
        if (![notClearArray containsObject:[dirnamearray objectAtIndex:index]]&&![[dirnamearray objectAtIndex:index]isEqualToString:FILE_NAME]) {
            [[NSFileManager defaultManager] removeItemAtPath:[[self getFilePathwithUserid:userid] stringByAppendingPathComponent:[dirnamearray objectAtIndex:index]] error:nil];
            [[NASQLHelper sharedInstance]deletePaperInfoByUserIdAndolddate:userid Theolddate:[dirnamearray objectAtIndex:index]];
        }
    }
}
#pragma mark - Master -
#pragma mark

- (NSString *)masterFilePath
{
    return [self creatFilePath:FILE_NAME withFileName:MASTER_XML_PATH];
}

- (void)saveMasterFileWithData:(NSData *)fileData
{
    NSString *path = [self masterFilePath];
    [fileData writeToFile:path atomically:YES];
}

- (NSData *)readMasterFile
{
    NSString *path = [self masterFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [NSData dataWithContentsOfFile:path];
    }
    return nil;
}

- (NSArray *)masterPublicationInfo
{
    NSData *data = [self readMasterFile];
    NSDictionary *masterdic = [[[SHXMLParser alloc] init] parseData:data];
    NAMasterBaseClass *master = [NAMasterBaseClass modelObjectWithDictionary:masterdic];
    
    NSArray *publisherGroupInfos = master.masterData.publishers.publisherGroupInfo;
    
    NSMutableArray *publications = [NSMutableArray array];
    for (NAPublisherGroupInfo *publisherGroupInfo in publisherGroupInfos) {
        for (NAPublisherInfo *publisherInfo in publisherGroupInfo.publisherInfo) {
            for (NAPublicationInfo *publication in publisherInfo.publicationInfo) {
                [publications addObject:publication];
            }
        }
    }
    return publications;
}
- (NSArray *)masterpublisherInfo
{
    NSData *data = [self readMasterFile];
    NSDictionary *masterdic = [[[SHXMLParser alloc] init] parseData:data];
    NAMasterBaseClass *master = [NAMasterBaseClass modelObjectWithDictionary:masterdic];
    NSMutableArray *publisherInfos = [NSMutableArray array];
    NSArray *publisherGroupInfos = master.masterData.publishers.publisherGroupInfo;
    for (NAPublisherGroupInfo *publisherGroupInfo in publisherGroupInfos) {
        for (NAPublisherInfo *publisherInfo in publisherGroupInfo.publisherInfo) {
            [publisherInfos addObject:publisherInfo];
        }
    }
    return publisherInfos;
}
- (NSArray *)masterPublisherGroupInfo
{
    NSData *data = [self readMasterFile];
    NSDictionary *masterdic = [[[SHXMLParser alloc] init] parseData:data];
    NAMasterBaseClass *master = [NAMasterBaseClass modelObjectWithDictionary:masterdic];
    
    return master.masterData.publishers.publisherGroupInfo;
}

#pragma mark - Search -
#pragma mark


- (void)saveSearchFileWithData:(NSData *)fileData Mydoc:(NADoc *)doc
{
    NSString *dirName=[NSString stringWithFormat:@"%@_%@_%@_%@_%@",doc.publishDate,doc.publisherGroupInfoId,doc.publisherInfoId,doc.publicationInfoId,doc.editionInfoId];
    [fileData writeToFile:[self creatFilePath:dirName withFileName:PAPER_XML_PATH] atomically:YES];
}
- (NSData *)readSearchFileWithdoc:(NADoc *)doc
{
     NSString *dirName=[NSString stringWithFormat:@"%@_%@_%@_%@_%@",doc.publishDate,doc.publisherGroupInfoId,doc.publisherInfoId,doc.publicationInfoId,doc.editionInfoId];
    NSString *path = [self creatFilePath:dirName withFileName:PAPER_XML_PATH];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [NSData dataWithContentsOfFile:path];
    }
    return nil;
}
#pragma mark - Search Page -
#pragma mark

/**
 * 紙面Imageファイルを作成
 *
 */
- (NSString *)getPathWithFileName:(NADoc *)doc withImageName:(NSString *)imageName
{
    NSString *updatetime=doc.lastUpdateDateAndTime;
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@" " withString:@""];
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@%@",imageName,updatetime,NAImageExtendedName];
    return fileName;
}

/**
 * 紙面Imageファイルを作成
 *
 */
- (NSString *)searchPathWithFileName:(NADoc *)doc withImageName:(NSString *)imageName
{
    NSString *filePath = [doc.publishDate stringByAppendingPathComponent:doc.indexNo];
    NSString *updatetime=doc.lastUpdateDateAndTime;
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@" " withString:@""];
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@%@",imageName,updatetime,NAImageExtendedName];
    return [self creatFilePath:filePath
                  withFileName:fileName];
}

/**
 * 記事xmlファイルを作成
 *
 */
- (NSString *)searchNoteName:(NADoc *)doc withNoteName:(NSString *)fileName
{
    NSString *filePath = [doc.publishDate stringByAppendingPathComponent:doc.indexNo];
    return [self creatFilePath:filePath
                  withFileName:fileName];
}

/**
 * 速報xmlファイルを作成
 *
 */
- (NSString *)searchSokuhoName:(NASDoc *)doc withSokuhoName:(NSString *)fileName
{
    NSString *filePath = [SOKUHO_PATH stringByAppendingPathComponent:doc.genreid];
    return [self creatFilePath:filePath
                  withFileName:fileName];
}

/**
 * 記事Imageファイルを作成
 *
 */
- (NSString *)searchNotePathWithFileName:(id)doc withImageName:(NSString *)imageName
{
    NSString *filePath;
    NSString *updatetime;
    if ([doc isKindOfClass:[NADoc class]]) {
        NADoc *tmpdoc=doc;
        updatetime=tmpdoc.lastUpdateDateAndTime;
        filePath = [tmpdoc.publishDate stringByAppendingPathComponent:tmpdoc.publishingHistoryInfoContentIdPaperInfo];
    }else{
        NAClipDoc *tmpdoc=doc;
        updatetime=tmpdoc.lastUpdateDateAndTime;
        filePath = [tmpdoc.publishDate stringByAppendingPathComponent:tmpdoc.publishingHistoryInfoContentIdPaperInfo];
    }
    
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@" " withString:@""];
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    updatetime = [updatetime stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@%@",imageName,updatetime,NAImageExtendedName];
    return [self creatFilePath:filePath
                  withFileName:fileName];
}

/**
 * 大紙面を書き込み
 *
 */
- (void)writeLargeImageToSearchManager:(NSData *)image info:(NADoc *)docInfo
{
    NSString *path = [self searchPathWithFileName:docInfo
                                    withImageName:NAPageLargePhoto];
    [image writeToFile:path atomically:YES];
}

/**
 * 中紙面を書き込み
 *
 */
- (void)writeMiddleImageToSearchManager:(NSData *)image info:(NADoc *)docInfo
{
    NSString *path = [self searchPathWithFileName:docInfo
                                    withImageName:NAPageNormalPhoto];
    [image writeToFile:path atomically:YES];
}

/**
 * 小紙面を書き込み
 *
 */
- (void)writeMinImageToSearchManager:(NSData *)image info:(NADoc *)docInfo
{
    NSString *path = [self searchPathWithFileName:docInfo
                                    withImageName:NAPageMiniPhoto];
    [image writeToFile:path atomically:YES];
}

/**
 * 記事を書き込み
 *
 */
- (void)writeNoteToSearchManager:(NSData *)note info:(NADoc *)docInfo
{
    NSString *path = [self searchNoteName:docInfo withNoteName:NoteFileName];
    [note writeToFile:path atomically:YES];
}

/**
 * 速報を書き込み
 *
 */
- (void)writeSokuhoToSearchManager:(NSData *)note info:(NASDoc *)docInfo
{
    NSString *path = [self searchSokuhoName:docInfo withSokuhoName:SokuhoFileName];
    [note writeToFile:path atomically:YES];
}

- (NSString *)AllNotePath
{
    return [self creatFilePath:FILE_NAME withFileName:ALL_NOTE];
}

#pragma mark - Search -
#pragma mark

/**
 * 検索キーを書き込み
 *
 */
- (void)saveSearchResult:(NSData *)search;
{
    NSString *path = [self creatFilePath:FILE_NAME withFileName:SEARCH_RESULT];
    [search writeToFile:path atomically:YES];
}

- (NSString *)getSearchResult
{
    NSString *path = [self creatFilePath:FILE_NAME withFileName:SEARCH_RESULT];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

- (NSData *)dataWitharray:(NSArray *)array
{
    return [NSKeyedArchiver archivedDataWithRootObject:array];
}

- (NSArray *)arrayWithData:(NSData *)data
{
    SHXMLParser *parser = [[SHXMLParser alloc] init];
    NSDictionary *dic = [parser parseData:data];
    NAClipBaseClass *searchBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
    NSArray *array = searchBaseClass.response.doc;
    return array;
}

-(void)saveLoginhtml:(NSData *)myHtmlData{
    NSString *cachesPath = [self cachesPath];
    NSString *fileName=NALoginHtmlFileName;
    cachesPath = [cachesPath stringByAppendingPathComponent:[fileName lastPathComponent]];
    [myHtmlData writeToFile:cachesPath atomically:YES];
}
-(NSString *)getLoginHtml{
    NSString *cachesPath = [self cachesPath];
    NSString *fileName=NALoginHtmlFileName;
    cachesPath = [cachesPath stringByAppendingPathComponent:[fileName lastPathComponent]];
    NSString *viewFormatHtml = [NSString stringWithContentsOfFile:cachesPath encoding:NSUTF8StringEncoding error:nil];
    return viewFormatHtml;
}
-(void)saveTophtml:(NSData *)myHtmlData{
    NSString *cachesPath = [self cachesPath];
    NSString *fileName=NATopHtmlFileName;
    cachesPath = [cachesPath stringByAppendingPathComponent:[fileName lastPathComponent]];
    [myHtmlData writeToFile:cachesPath atomically:YES];
}
-(NSString *)getTopHtml{
    NSString *cachesPath = [self cachesPath];
    NSString *fileName=NATopHtmlFileName;
    cachesPath = [cachesPath stringByAppendingPathComponent:[fileName lastPathComponent]];
    NSString *viewFormatHtml = [NSString stringWithContentsOfFile:cachesPath encoding:NSUTF8StringEncoding error:nil];
    return viewFormatHtml;
}
+ (NSString *)getPDFPath:(NSString *)filename

{
    NSString *baseCachesPath = [[[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject] relativePath];
    return [baseCachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/ImageToPDF/%@",filename]];
}


@end


#import "NADownloadManager.h"
#import "NASearchClient.h"

NSString *const NADownloadImageUpdateProgress = @"NADownloadImageUpdateProgress";

@interface NADownloadManager ()

@property (nonatomic, strong) NSArray *docs;

@end

@implementation NADownloadManager

+ (NADownloadManager *)sharedInstance
{
    static NADownloadManager *_sharedInstance = nil;
    static dispatch_once_t managerPredicate;
    dispatch_once(&managerPredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}




- (void)cancel
{
    [[[NADownLoadImageClient sharedClient] operationQueue] cancelAllOperations];
}



- (void)notificationWithIndex:(NSInteger)index imageModel:(NADownLoadImageModel)model
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:index] forKey:@"Index"];
    [dic setObject:[NSNumber numberWithInteger:model] forKey:@"ImageModle"];
    [[NSNotificationCenter defaultCenter] postNotificationName:NADownloadImageUpdateProgress object:dic];
}

- (BOOL)checkAllDownLoad
{
    BOOL check = YES;
    for (NADoc *doc in self.docs) {
        NSString *filePath = [[NAFileManager sharedInstance] searchPathWithFileName:doc
                                                                      withImageName:NAPageMiniPhoto];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            check = NO;
            break;
        }
        filePath = [[NAFileManager sharedInstance] searchPathWithFileName:doc
                                                            withImageName:NAPageLargePhoto];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            check = NO;
            break;
        }
        filePath = [[NAFileManager sharedInstance] searchPathWithFileName:doc
                                                            withImageName:NAPageNormalPhoto];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            check = NO;
            break;
        }
    }
    return check;
}

- (void)downloadThumbs:(NSArray *)list completionBlock:(void(^)(BOOL done))completion
{
    [self downloadThumb:list index:0 completionBlock:completion];
}

- (void)downloadThumb:(NSArray *)list index:(NSInteger)index completionBlock:(void(^)(BOOL done))completion
{
    if (index >= list.count) {
        if (completion) {
            completion (YES);
        }
        return;
    }
    NADoc *doc = list[index];
    NSString *path = [[NAFileManager sharedInstance] searchPathWithFileName:doc
                                                              withImageName:NAPageMiniPhoto];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    if (image) {
        [self downloadNote:list index:index completionBlock:completion];
    }else{
        [self cancel];
        NSString * parmPageUrl = [[doc.miniPagePath stringByAppendingString:@"?"] stringByAppendingString:doc.lastUpdateDateAndTime];
        parmPageUrl = [parmPageUrl stringByReplacingOccurrencesOfString:@" " withString:@"%"];
        [[NADownLoadImageClient sharedClient] postDownLoadImage:parmPageUrl completionBlock:^(id image, NSError *error) {
            if (!error) {
                if ([image isKindOfClass:[UIImage class]]) {
                    [[NAFileManager sharedInstance] writeMinImageToSearchManager:UIImageJPEGRepresentation(image, 1) info:doc];
                }
            }
            [self downloadNote:list index:index completionBlock:completion];
        }];
    }
}

- (void)downloadNote:(NSArray *)list index:(NSInteger)index completionBlock:(void(^)(BOOL done))completion
{
    
    
    
    NADoc *doc = list[index];
    
    NSString *path = [[NAFileManager sharedInstance] searchPathWithFileName:doc
                                                              withImageName:NoteFileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [self downloadThumb:list index:index + 1 completionBlock:completion];
    }else{
        NSDictionary *param = @{  @"Userid"       :  [NASaveData getLoginUserId],
                                  @"UseDevice"    :  NAUserDevice,
                                  @"Rows"         :  @"999",
                                  @"K002"         :  @"4",
                                  @"K001"         :  doc.indexNo,
                                  @"Mode"         :  @"1",
                                  @"Fl"           :  [NSString clipListFl],
                                  };
        [[NASearchClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
            SHXMLParser *parser = [[SHXMLParser alloc] init];
            NSDictionary *dic = [parser parseData:search];
            NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
            NSArray *array = searchBaseClass.response.doc;
            if (array.count > 0) {
                [[NAFileManager sharedInstance] writeNoteToSearchManager:search info:doc];
            }
            [self downloadThumb:list index:index + 1 completionBlock:completion];
        }];
    }
    
}


@end

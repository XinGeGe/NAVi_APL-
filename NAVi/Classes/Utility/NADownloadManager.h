
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NADownLoadImageClient.h"
#import "NAFileManager.h"


NSString *const NADownloadImageUpdateProgress;

typedef enum {
    NADownLoadImageModelThumb      = 0,
    NADownLoadImageModelNormal     = 1,
    NADownLoadImageModelLarge      = 2,
    NADownLoadImageModelDone       = 4,
} NADownLoadImageModel;

@interface NADownloadManager : NSObject

+ (NADownloadManager *)sharedInstance;
- (void)cancel;

- (void)downloadThumbs:(NSArray *)list completionBlock:(void(^)(BOOL done))completion;

@end

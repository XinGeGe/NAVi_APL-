
#import <UIKit/UIKit.h>
#import "NAFileManager.h"
#import "NASubImageView.h"
#import "NASubNoteView.h"
#import "NADownloadHelper.h"
#import "UIImageView+WebCache.h"
#import "NAImageDetailClass.h"
typedef enum {
    NAImageModelNone         = 0,
    NAImageModelLoading      = 1,
    NAImageModelLeftDone     = 2,
    NAImageModelDone         = 3,
} NAImageModel;

@class NoteDb;

typedef void(^DownloadImageBlock)(BOOL finish);
typedef void(^NoteDetailBlock)(NSArray *docs, NSInteger index);
typedef void(^MyImageCompletionBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL);
@interface NASubImageScrollView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic, strong) MyImageCompletionBlock MyImageCompletionBlock;
@property (nonatomic, strong) DownloadImageBlock downloadCompletion;
@property (nonatomic, strong) NoteDetailBlock noteDetailBlock;
@property (nonatomic, assign) NAImageModel largeModel;
@property (nonatomic, strong) NASubImageView *imageView;
@property (nonatomic, readwrite)NSInteger shownoteviewtag;
@property (nonatomic, strong) NSArray *pageDocs;
@property (nonatomic, strong) NSArray *otherPageDocs;
@property (nonatomic, readwrite)NSInteger landscapekei;
@property (nonatomic, strong) NAImageDetailClass *imageBaseClass;
@property (nonatomic, assign) NSInteger indexHaveOrNo;
- (void)updateFrame:(CGRect)frame;
- (void)LoadingImageView:(NADoc *)doc;
- (void)LoadingTwoImageView:(NADoc *)doc other:(NADoc *)otherDoc;
- (void)getNoteLayerWithDoc:(NADoc *)doc other:(NADoc *)other;
- (CGRect)showNoteViewByIndexNo:(NSString *)noteIndexNo;
- (void)moveWithNote:(CGRect) noteRect;

- (void)LoadingThumbImageView:(NADoc *)doc other:(NADoc *)otherDoc;
- (void)LoadingNormalImageView:(NADoc *)doc other:(NADoc *)otherDoc;
- (void)setImageViewWithurlstr:(NSString *)imagestr completionBlock:(MyImageCompletionBlock)completion;

@end

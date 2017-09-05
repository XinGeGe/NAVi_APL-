
#import "NASubImageScrollView.h"
#import "UIImageView+AFNetworking.h"
#import "ProgressHUD.h"

@interface NASubImageScrollView ()

@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;


@end

@implementation NASubImageScrollView {
    
}


@synthesize shownoteviewtag;

/**
 * Frame初期化
 *
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
/**
 * Subview初期化
 *
 */
- (void)initViews
{
    [self addSubview:self.imageView];
    [self addGestureRecognizer:self.doubleTap];
    [self addGestureRecognizer:self.singleTap];
}

/**
 * Frame更新
 *
 */
- (void)updateFrame:(CGRect)frame
{
    self.frame = frame;
    //[self.imageView updateFrame:self.bounds];
    if (isPad) {
       [self.imageView updateFrame:self.bounds];
    }
}

/**
 * imageView 初期化
 *
 */
- (NASubImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[NASubImageView alloc] initWithFrame:self.frame];
        
    }
    return _imageView;
}
/**
 * imageView set with url
 *
 */
-(void)setImageViewWithurlstr:(NSString *)imagestr completionBlock:(MyImageCompletionBlock)completion{
    [self.imageView.noteView clearNote];
    [self.imageView.imageView sd_setImageWithURL:[NSURL URLWithString:imagestr] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        [self.imageView updateFrame4Image:self.bounds];
        if (completion) {
            completion(image,error,cacheType,imageURL);
        }
      
        
        
    }];
}

/**
 * 紙面表示（mini紙面）
 *
 */
- (void)LoadingThumbImageView:(NADoc *)doc other:(NADoc *)otherDoc
{
    [self.imageView.noteView clearNote];
    [self SetMyThumbImageWithMydoc:doc Myimageview:self.imageView.imageView];
    if (otherDoc) {
        [self SetMyThumbImageWithMydoc:otherDoc Myimageview:self.imageView.otherImageView];
    }
}

/**
 * 紙面表示（mini紙面）
 *
 */
-(void)SetMyThumbImageWithMydoc:(NADoc *)doc Myimageview:(UIImageView *)myimageview{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image =doc.thumbimage;
        if (image == nil) {
            NSString *path = [[NAFileManager sharedInstance] searchPathWithFileName:doc withImageName:NAPageMiniPhoto];
            image = [UIImage imageWithContentsOfFile:path];
            doc.thumbimage = image;
        }
        
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!doc.whichimage) {
                    doc.whichimage = NAThumbimage;
                }
                [myimageview setImage:image];
                [self.imageView updateFrame4Image:self.bounds];
            });
                           
        }else {
             NSLog(@"NO image");
            dispatch_async(dispatch_get_main_queue(), ^{
                [myimageview setImage:[UIImage imageNamed:@"nextep_image_loading.png"]];
            });

        }
    });
}

/**
 * 紙面表示（中紙面）
 *
 */
- (void)LoadingNormalImageView:(NADoc *)doc other:(NADoc *)otherDoc
{
    [self SetMyNormalImageWithMydoc:doc Myimageview:self.imageView.imageView];
    if (otherDoc) {
        [self SetMyNormalImageWithMydoc:otherDoc Myimageview:self.imageView.otherImageView];
    }
}

/**
 * 紙面表示（中紙面）
 *
 */
-(void)SetMyNormalImageWithMydoc:(NADoc *)doc Myimageview:(UIImageView *)myimageview{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            NSString *path = [[NAFileManager sharedInstance] searchPathWithFileName:doc withImageName:NAPageNormalPhoto];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [myimageview setImage:image];
                    [self.imageView updateFrame4Image:self.bounds];
                });
            }else {
                 NSLog(@"NO image");
                [self SetMyThumbImageWithMydoc:doc Myimageview:myimageview];
            }
    });
}

/**
 * 1紙面表示（中、大紙面）
 *
 */
- (void)LoadingImageView:(NADoc *)doc
{
    [self SetMyimageWithMydoc:doc Myimageview:self.imageView.imageView];
}

/**
 * 2紙面表示（中、大紙面）
 *
 */
- (void)LoadingTwoImageView:(NADoc *)doc other:(NADoc *)otherDoc
{
    [self SetMyimageWithMydoc:doc Myimageview:self.imageView.imageView];
    [self SetMyimageWithMydoc:otherDoc Myimageview:self.imageView.otherImageView];
    
}

/**
 * 紙面表示（中、大紙面）
 *
 */
-(void)SetMyimageWithMydoc:(NADoc *)doc Myimageview:(UIImageView *)myimageview{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if([doc.whichimage isEqualToString:@"Normalimage"]){
            NSString *path = [[NAFileManager sharedInstance] searchPathWithFileName:doc withImageName:NAPageNormalPhoto];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [myimageview setImage:image];
                });
            }else {
                NSLog(@"NO image");
            }
        }else if ([doc.whichimage isEqualToString:@"Largeimage"]){
            
            NSString *path = [[NAFileManager sharedInstance] searchPathWithFileName:doc withImageName:NAPageLargePhoto];
            
            //NSData *data=[NSData dataWithContentsOfFile:path];
            //UIImage *image=[UIImage imageWithData:data];
            UIImage *image=[UIImage imageWithContentsOfFile:path];

            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [myimageview setImage:image ];
                });
            }else {
                 NSLog(@"NO image");
            }
        }
    });
}

/**
 * singleTap event
 *
 */
-(UITapGestureRecognizer *)singleTap
{
    if (!_singleTap) {
        _singleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [_singleTap setNumberOfTapsRequired:1];
        [_singleTap requireGestureRecognizerToFail:_doubleTap];
    }
    return _singleTap;
}
- (void)handleSingleTap:(UITapGestureRecognizer *)gesture{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"singleClickNoty" object:nil];
    
    NSString *oldNoteIndexNo = self.imageView.noteView.curNoteIndexNo;
    NSString *noteIndexNo = [self getNoteIndexNoByPoint:gesture];
    
    if (![self.imageView.noteView isHidden]) {
        if (oldNoteIndexNo && ![oldNoteIndexNo isEqualToString:noteIndexNo]) {
            // 記事情報をクリア
            [self.imageView.noteView clearNote];
        }
        
        if (oldNoteIndexNo && [oldNoteIndexNo isEqualToString:noteIndexNo]) {
            // 記事詳細画面へ遷移
            NSMutableArray *array = [NSMutableArray array];
            NSInteger index = 0;
            if (self.otherPageDocs) {
                [array addObjectsFromArray:self.pageDocs];
                [array addObjectsFromArray:self.otherPageDocs];
            }else{
                [array addObjectsFromArray:self.pageDocs];
            }
            
            for (NADoc *d in array) {
                if ([d.indexNo isEqualToString:noteIndexNo]) {
                    break;
                }
                
                index++;
            }
            if (self.noteDetailBlock) {
                self.noteDetailBlock(array, index);
            }
        }
    }else{
        NSString *myPicType=[[self.imageBaseClass.PictureType componentsSeparatedByString:@","]objectAtIndex:self.tag-1];
        if ([myPicType isEqualToString:@"M"]) {
            NSString *trueUrl=[Util getMP4Url:[[self.imageBaseClass.RelatedInfo3  componentsSeparatedByString:@","]objectAtIndex:self.tag-1]Prams:[Util getYYMMDateString:[[self.imageBaseClass.Image_L_LastModified componentsSeparatedByString:@","]objectAtIndex:self.tag-1]]];
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:trueUrl,@"trueUrl", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTYImageDetailClick object:nil userInfo:dic];
            
        }
    }
}

/**
 * doubleTap event
 *
 */
-(UITapGestureRecognizer *)doubleTap
{
    if (!_doubleTap) {
        _doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [_doubleTap setNumberOfTapsRequired:2];
    }
    return _doubleTap;
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)gesture
{
    CGFloat kei = 1;
    
    // 双击到新闻
    BOOL firstTapNote = NO;
    CGPoint touchPoint = [gesture locationInView:self.imageView];
    CGPoint centerPoint = touchPoint;
    CGRect noteRect;
    
    // property.fileから、kei情報を取得
    NSString *myratestr=[NASaveData getExpansion_rate];
    NSArray *ratearray=[myratestr componentsSeparatedByString:@","];
    CGFloat dfrate=[[ratearray objectAtIndex:0]floatValue];
    CGFloat small = [[ratearray objectAtIndex:1]floatValue];//2.5
    CGFloat middle = [[ratearray objectAtIndex:2]floatValue];//5
    if(self.imageView.isPadLandscape){
        small = [[ratearray objectAtIndex:1]floatValue]*[NASaveData getLandscapekei];//2.5
        middle = [[ratearray objectAtIndex:2]floatValue]*[NASaveData getLandscapekei];//5
    }
    // 記事IndexNo取得
    NSString *oldNoteIndexNo = [self.imageView.noteView.curNoteIndexNo copy];
    NSString *noteIndexNo = [self getNoteIndexNoByPoint:gesture];
    
    if (noteIndexNo) {
        _indexHaveOrNo = 0;
        // 記事がある場合
        noteRect = [self showNoteViewByIndexNo:noteIndexNo];
    } else {
        _indexHaveOrNo = 1;
        // 記事情報をクリア
        [self.imageView.noteView clearNote];
    }
    
    // zoom　scale
    if (noteIndexNo && (![noteIndexNo isEqualToString:oldNoteIndexNo] || !oldNoteIndexNo)) {
        [self moveWithNote:noteRect];
        firstTapNote = YES;
    } else {
        if (self.zoomScale >= middle) {
            centerPoint.x = 0;
            centerPoint.y = 0;
            kei = dfrate;
        } else if (self.zoomScale >= dfrate && self.zoomScale < small) {
            kei = small;
            centerPoint = [self getCenterPoint:small touchPoint:touchPoint];
        } else if (self.zoomScale >= small && self.zoomScale < middle) {
            kei = middle;
            centerPoint = [self getCenterPoint:middle touchPoint:touchPoint];
        }
        
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:1.0
              initialSpringVelocity:1
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [self setZoomScale:kei animated:NO];
                             [self setContentOffset:centerPoint animated:NO];
                             
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    }
    
    
    NSString *strScale = [NSString stringWithFormat:@"%f", kei];
    NSNumber *tapNote = [NSNumber numberWithBool:firstTapNote];
    NSDictionary *dic = @{@"scale" : strScale, @"tapNote" : tapNote};
    

    AFTER(0.3, ^(void){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"doubleClickNoty" object:nil userInfo:dic];
    });
}

/**
 * 記事が選択時、紙面を移動
 *
 */
- (void)moveWithNote:(CGRect) noteRect
{
    CGFloat kei;
    CGPoint touchPoint;
    CGPoint centerPoint;
    CGFloat offSize = 40;
    
    // property.fileから、kei情報を取得
    NSString *myratestr=[NASaveData getExpansion_rate];
    NSArray *ratearray=[myratestr componentsSeparatedByString:@","];
    CGFloat minKei=[[ratearray objectAtIndex:0]floatValue];
    CGFloat maxKei = [[ratearray objectAtIndex:3]floatValue];
    if(self.imageView.isPadLandscape){
        maxKei = [[ratearray objectAtIndex:3]floatValue]*[NASaveData getLandscapekei];
    }
    
    // zoom keiを設定
    kei =  (self.bounds.size.width - offSize) / noteRect.size.width;
    if (kei > (self.bounds.size.height - offSize) / noteRect.size.height) {
        kei = (self.bounds.size.height - offSize) / noteRect.size.height;
    }
    if (kei < minKei) {
        kei = minKei;
    }
    if (kei > maxKei) {
        kei = maxKei;
    }
    
    // center pointを設定
    touchPoint.x = (noteRect.origin.x + noteRect.size.width / 2);
    touchPoint.y = (noteRect.origin.y + noteRect.size.height / 2);
    centerPoint = [self getCenterPoint:kei touchPoint:touchPoint];
    
    // setZoomScale
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self setZoomScale:kei animated:NO];
                         [self setContentOffset:centerPoint animated:NO];
                         
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

/**
 * center pointを取得
 *
 */
- (CGPoint)getCenterPoint:(CGFloat) kei touchPoint:(CGPoint) touchPoint
{
    CGPoint point;

    // Offsetを設定
    point.x = touchPoint.x * kei - self.bounds.size.width / 2;
    point.y = touchPoint.y * kei - self.bounds.size.height / 2;

    // 紙面サイズ
    CGFloat imageW = self.contentSize.width / self.zoomScale;
    CGFloat imageH = self.contentSize.height / self.zoomScale;
    if (self.zoomScale == 1) {
        imageW = self.bounds.size.width - self.imageView.offx * 2;
        imageH = self.bounds.size.height - self.imageView.offy * 2;
    }
    
    // 右側超える
    if (point.x > imageW * kei - self.bounds.size.width) {
        point.x = imageW * kei - self.bounds.size.width;
    }
    if (point.y > imageH * kei - self.bounds.size.height) {
        point.y = imageH * kei - self.bounds.size.height;
    }

    // 左側超える
    if (point.x < 0) {
        point.x = 0;
    }
    
    if (point.y < 0) {
        point.y = 0;
    }
    
    return point;
}

/**
 * 記事情報を設定
 *
 */
- (void)getNoteLayerWithDoc:(NADoc *)doc other:(NADoc *)other
{
    self.pageDocs = nil;
    self.otherPageDocs = nil;
    
    if (doc.notearray && doc.notearray.count > 0) {
        self.pageDocs = doc.notearray;
    } else {
        NSString *path = [[NAFileManager sharedInstance] searchNoteName:doc withNoteName:NoteFileName];
        NSFileManager *fileManage = [NSFileManager defaultManager];
        if ([fileManage fileExistsAtPath:path isDirectory:FALSE]) {
            NSData *data = [NSData dataWithContentsOfFile:path];
            doc.notearray = [[NAFileManager sharedInstance] arrayWithData:data];
            
            for (NSInteger index=0; index<doc.notearray.count; index++) {
                NADoc *temdoc=[doc.notearray objectAtIndex:index];
                temdoc.miniPagePath=doc.miniPagePath;
                temdoc.lastUpdateDateAndTime=doc.lastUpdateDateAndTime;
            }
        }
    }
    
    if (other) {
        if (other.notearray && other.notearray.count > 0) {
            self.otherPageDocs = other.notearray;
        } else {
            NSString *path = [[NAFileManager sharedInstance] searchNoteName:other withNoteName:NoteFileName];
            NSFileManager *fileManage = [NSFileManager defaultManager];
            if ([fileManage fileExistsAtPath:path isDirectory:FALSE]) {
                NSData *data = [NSData dataWithContentsOfFile:path];
                other.notearray = [[NAFileManager sharedInstance] arrayWithData:data];

                for (NSInteger index=0; index<other.notearray.count; index++) {
                    NADoc *temdoc=[other.notearray objectAtIndex:index];
                    temdoc.miniPagePath=other.miniPagePath;
                    temdoc.lastUpdateDateAndTime=other.lastUpdateDateAndTime;
                }
            }
        }
    }
    
    self.pageDocs = doc.notearray;
    if (other) {
        self.otherPageDocs = other.notearray;
    }
}

/**
 * pointで記事indexNoを取得
 *
 */
- (NSString *)getNoteIndexNoByPoint:(UITapGestureRecognizer *)sender
{
    NSString *noteIndexNo;
    
    CGPoint point = [sender locationInView:self.imageView];
    
    if (self.otherPageDocs) {
        for (NADoc *d in self.pageDocs) {
            noteIndexNo = [self getNoteIndexNoByDoc:d point:point left:NO];
            if (noteIndexNo) {
                return noteIndexNo;
            }
        }
        
        for (NADoc *d in self.otherPageDocs) {
            noteIndexNo = [self getNoteIndexNoByDoc:d point:point left:YES];
            if (noteIndexNo) {
                return noteIndexNo;
            }
        }
    } else {
        for (NADoc *d in self.pageDocs) {
            noteIndexNo = [self getNoteIndexNoByDoc:d point:point left:YES];
            if (noteIndexNo) {
                return noteIndexNo;
            }
        }
    }
    
    return noteIndexNo;
}

/**
 * 紙面情報Docから、pointで記事indexNoを取得
 *
 */
- (NSString *)getNoteIndexNoByDoc:(NADoc *)doc point:(CGPoint) point left:(BOOL)isleft
{
    NSMutableArray *array = [self getCGRectByDoc:doc left:isleft];
    for (NSValue *value in array) {
        CGRect frame = CGRectZero;
        [value getValue:&frame];
        
        if (point.x >= frame.origin.x && point.y >= frame.origin.y && point.x <= frame.origin.x + frame.size.width && point.y <= frame.origin.y + frame.size.height) {
            return doc.indexNo;
        }
    }
    
    return nil;
}

/**
 * 紙面画面に、記事indexNoで記事情報を表示
 *
 */
- (CGRect)showNoteViewByIndexNo:(NSString *)noteIndexNo
{
    NSMutableArray *array;
    CGRect noteRect = CGRectZero;
    NSString *curPaperIndexNo;
    
    if (self.otherPageDocs) {
        for (NADoc *d in self.pageDocs) {
            if ([d.indexNo isEqualToString:noteIndexNo]) {
                array = [self getCGRectByDoc:d left:NO];
                curPaperIndexNo = d.publishingHistoryInfoContentIdPaperInfo;
            }
        }
        
        for (NADoc *d in self.otherPageDocs) {
            if ([d.indexNo isEqualToString:noteIndexNo]) {
                array = [self getCGRectByDoc:d left:YES];
                curPaperIndexNo = d.publishingHistoryInfoContentIdPaperInfo;
            }
        }
    } else {
        for (NADoc *d in self.pageDocs) {
            if ([d.indexNo isEqualToString:noteIndexNo]) {
                array = [self getCGRectByDoc:d left:YES];
                curPaperIndexNo = d.publishingHistoryInfoContentIdPaperInfo;
            }
        }
    }
    
    [self.imageView.noteView drawNote:array curItemIndex:curPaperIndexNo noteIndexNo:noteIndexNo];
    
    for (NSValue *value in array) {
        CGRect make = CGRectZero;
        [value getValue:&make];
        
        if (noteRect.size.width == 0) {
            noteRect = make;
        } else {
            if (noteRect.origin.x > make.origin.x) {
                noteRect.size.width = noteRect.size.width + noteRect.origin.x - make.origin.x;
                noteRect.origin.x = make.origin.x;
            }
            
            if (noteRect.origin.y > make.origin.y) {
                noteRect.size.height = noteRect.size.height + noteRect.origin.y - make.origin.y;
                noteRect.origin.y = make.origin.y;
            }
            
            if (noteRect.origin.x + noteRect.size.width < make.origin.x + make.size.width) {
                noteRect.size.width = make.origin.x + make.size.width - noteRect.origin.x;
            }
            
            if (noteRect.origin.y + noteRect.size.height < make.origin.y + make.size.height) {
                noteRect.size.height = make.origin.y + make.size.height - noteRect.origin.y;
            }
        }
    }
    
    return noteRect;
}

/**
 * 記事Docから、記事CGRectを取得
 *
 */
- (NSMutableArray *)getCGRectByDoc:(NADoc *)doc left:(BOOL)isleft
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *Xs = [doc.locationInfoPosX componentsSeparatedByString:@";"];
    NSArray *Ys = [doc.locationInfoPosY componentsSeparatedByString:@";"];
    
    CGFloat imageWidth = self.imageView.noteView.viewWidth;
    if (self.otherPageDocs) {
        imageWidth = imageWidth / 2;
    }
    CGFloat imageHeight = self.imageView.noteView.viewHeight;
    
    CGFloat pW = [doc.compositionWidth floatValue];
    CGFloat pH = [doc.compositionHeight floatValue];
    
    for (int i = 0; i < Xs.count; i++) {
        NSString *strX = Xs[i];
        NSString *strY = Ys[i];
        NSArray *x = [strX componentsSeparatedByString:@","];
        NSArray *y = [strY componentsSeparatedByString:@","];
        
        NSInteger pSX = [x[0] integerValue];
        NSInteger pSY = [y[0] integerValue];
        NSInteger pEX = [x[1] integerValue];
        NSInteger pEY = [y[1] integerValue];
        
        CGRect frame = CGRectZero;
        frame.origin.x = ((CGFloat)pSX * imageWidth /(CGFloat)pW) -0.5 + (isleft ? 0 : imageWidth);
        frame.origin.y = (CGFloat)pSY * imageHeight /(CGFloat)pH -0.5;
        frame.size.width = ((CGFloat)pEX - (CGFloat)pSX) * imageWidth /(CGFloat)pW + 0.5;
        frame.size.height = ((CGFloat)pEY - (CGFloat)pSY) * imageHeight /(CGFloat)pH + 0.5;
        
        NSValue *value;
        value = [NSValue valueWithBytes:&frame objCType:@encode(CGRect)];
        [array addObject:value];
    }
    
    return array;
}

@end

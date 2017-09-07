
#import "NASubImageView.h"

@interface NASubImageView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) NSInteger currIndex;

@end

@implementation NASubImageView

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
    [self addSubview:self.otherImageView];
    [self addSubview:self.noteView];
}

/**
 * Frame更新
 *
 */
- (void)updateFrame:(CGRect)frame
{
    self.frame = frame;
    if (!self.isTwoPage) {
        self.imageView.frame = self.bounds;
        self.otherImageView.hidden = YES;
    }else{
        self.otherImageView.hidden = NO;
        CGRect frame = self.bounds;
        frame.size.width = frame.size.width / 2;
        self.otherImageView.frame = frame;
        frame.origin.x = frame.size.width;
        self.imageView.frame = frame;
    }
    
    self.noteView.frame = self.bounds;
    self.noteView.viewWidth = self.bounds.size.width;
    self.noteView.viewHeight = self.bounds.size.height;
}
- (void)updateFrameForiPhone:(CGRect)frame
{
   
    if (frame.size.height<frame.size.width) {
        CGFloat imageheight=0;
        if (self.imageView.frame.size.width>0) {
            imageheight=frame.size.width*self.imageView.frame.size.height/self.imageView.frame.size.width;
        }
        //NSLog(@"imageheight==%f",imageheight);
        self.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, frame.size.width,imageheight);
        self.imageView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, frame.size.width, imageheight);
        self.noteView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, imageheight);
        self.noteView.viewWidth = frame.size.width;
        self.noteView.viewHeight = imageheight;
        self.noteView.imageFrame=self.imageView.frame;
    }else{
        self.frame = frame;
        self.imageView.frame=self.bounds;
        self.noteView.frame = self.bounds;
        self.noteView.viewWidth = self.bounds.size.width;
        self.noteView.viewHeight = self.bounds.size.height;
    }
   
    //self.imageView.frame=self.bounds;
    
    
    //NSLog(@"self.center.x=%f,self.center.y=%f",self.center.x,self.center.y);
    
}

/**
 * Frame更新(forZoom)
 *
 */
- (void)updateFrame4Zoom:(CGRect)superRect
{
    NSInteger count = self.isTwoPage ? 2 : 1;
    
    if (self.imageView.image) {
        CGSize size = self.imageView.image.size;
        CGFloat width = superRect.size.width / count;
        CGFloat height = superRect.size.height;
        CGRect frame = superRect;
        if ((size.width / size.height) > (width / height)) {
            frame.size.height = size.height * width / size.width;
            frame.origin.y = (height - frame.size.height) / 2;
            
        }else {
            frame.size.width = size.width * height / size.height * count;
            frame.origin.x = (width * count - frame.size.width) / 2;
            
        }
        [self updateFrame:frame];
//        if (isPad) {
//            [self updateFrame:frame];
//        }else{
//            [self updateFrameForiPhone:frame];
//        }
        
    }
}

/**
 * Frame更新(forImage)
 *
 */
- (void)updateFrame4Image:(CGRect)superRect isFromHome:(BOOL)formHome
{
    NSInteger count = self.isTwoPage ? 2 : 1;
    
    if (formHome) {
        if (self.imageView.image) {
            CGSize size = self.imageView.image.size;
            CGFloat width = superRect.size.width / count;
            CGFloat height = superRect.size.height;
            CGRect frame = superRect;
            if ((size.width / size.height) > (width / height)) {
                frame.size.height = size.height * width / size.width;
                frame.origin.y = (height - frame.size.height) / 2;
                _offx = 0;
                _offy = frame.origin.y;
            }else {
                frame.size.width = size.width * height / size.height * count;
                frame.origin.x = (width * count - frame.size.width) / 2;
                _offx=frame.origin.x;
                _offy = 0;
            }
            [self updateFrame:frame];
        }
    } else {
        if (self.imageView.image) {
            CGSize imageSize = self.imageView.image.size;
            CGFloat widthBgView = superRect.size.width / count;
            CGFloat heightBgView = superRect.size.height;
            CGRect newBgFrame = superRect;
            
            if (imageSize.width > imageSize.height) {
                if (imageSize.width >= widthBgView) {
                    newBgFrame.size.width = 0.9 * newBgFrame.size.width;
                    newBgFrame.size.height = imageSize.height * widthBgView / imageSize.width;
                    newBgFrame.origin.y = (heightBgView - newBgFrame.size.height) / 2;
                    newBgFrame.origin.x = 0.05 * newBgFrame.size.width;
                    _offx = newBgFrame.origin.x;
                    _offy = newBgFrame.origin.y;
                } else {
                    newBgFrame.size.width = imageSize.width;
                    newBgFrame.size.height = imageSize.height * widthBgView / imageSize.width;
                    newBgFrame.origin.y = (heightBgView - imageSize.height) / 2;
                    newBgFrame.origin.x = (widthBgView - newBgFrame.size.width) / 2;
                    _offx=newBgFrame.origin.x;
                    _offy = newBgFrame.origin.y;
                }
            } else {
                if (imageSize.height >= heightBgView) {
                    newBgFrame.size.height = 0.9 * newBgFrame.size.height;
                    newBgFrame.size.width = imageSize.width * heightBgView / imageSize.height;
                    newBgFrame.origin.x = (widthBgView - newBgFrame.size.width) / 2;
                    newBgFrame.origin.y = 0.05 * newBgFrame.size.height;
                    _offx=newBgFrame.origin.x;
                    _offy = newBgFrame.origin.y;
                } else {
                    newBgFrame.size.height = imageSize.height;
                    newBgFrame.size.width = imageSize.width * heightBgView / imageSize.height;
                    newBgFrame.origin.y = (heightBgView - imageSize.height) / 2;
                    newBgFrame.origin.x = (widthBgView - newBgFrame.size.width) / 2;
                }
            }
        
        
//            if ((imageSize.width / imageSize.height) > (widthBgView / heightBgView)) {
//                
//                newBgFrame.size.height = imageSize.height * widthBgView / imageSize.width;
//                newBgFrame.origin.y = (heightBgView - newBgFrame.size.height) / 2;
//                _offx = 0;
//                _offy = newBgFrame.origin.y;
//                newBgFrame.origin.x = 0.05 * newBgFrame.size.width;
//                newBgFrame.size.width = 0.9 * newBgFrame.size.width;
//            }else {
//                newBgFrame.size.width = imageSize.width * heightBgView / imageSize.height * count;
//                newBgFrame.size.height = 0.9 * newBgFrame.size.height;
//                newBgFrame.origin.y = 0.05 * newBgFrame.size.height;
//                newBgFrame.origin.x = (widthBgView * count - newBgFrame.size.width) / 2;
//                _offx=newBgFrame.origin.x;
//                _offy = 0;
//            }
             [self updateFrame:newBgFrame];
    }
    
    
       
//        if (isPad) {
//            [self updateFrame:frame];
//        }else{
//            [self updateFrameForiPhone:frame];
//        }
    }
}

/**
 * imageView 初期化
 *
 */
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.opaque = YES;
        //_imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

/**
 * otherImageView 初期化
 *
 */
- (UIImageView *)otherImageView
{
    if (!_otherImageView) {
        _otherImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _otherImageView.opaque = YES;
        _otherImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _otherImageView;
}

/**
 * noteView 初期化
 *
 */
- (NASubNoteView *)noteView
{
    if (!_noteView) {
        _noteView = [[NASubNoteView alloc] initWithFrame:self.bounds];
        _noteView.opaque=NO;
        _noteView.hidden=YES;
    }
    return _noteView;
}

@end

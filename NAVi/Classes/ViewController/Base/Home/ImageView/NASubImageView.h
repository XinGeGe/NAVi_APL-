
#import <UIKit/UIKit.h>
#import "NASubNoteView.h"


@interface NASubImageView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *otherImageView;
@property (nonatomic, strong) NASubNoteView *noteView;
@property (nonatomic, assign) BOOL isPadLandscape;
@property (nonatomic, assign) BOOL isTwoPage;

@property (nonatomic, readwrite) CGFloat offx;
@property (nonatomic, readwrite) CGFloat offy;

- (id)initWithFrame:(CGRect)frame;
- (void)updateFrame:(CGRect)frame;
- (void)updateFrameForiPhone:(CGRect)frame;
- (void)updateFrame4Image:(CGRect)superRect isFromDetail:(BOOL)formDetail;
- (void)updateFrame4Zoom:(CGRect)superRect isFromDetail:(BOOL)fromDetail zoomScale:(CGFloat)scale;
@end

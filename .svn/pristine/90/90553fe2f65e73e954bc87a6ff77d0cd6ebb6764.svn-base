
#import <UIKit/UIKit.h>
#import "DataModels.h"
#import "NANotePageView.h"

#import "UIImageView+WebCache.h"
#define SDPhotoGroupImageMargin 15



@interface NADetailView : UIScrollView <UIWebViewDelegate>{
   
}

@property (nonatomic, strong) UIWebView *textView;
@property (nonatomic, strong) NAClipDoc *detailDoc;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NANotePageView *pageView;
@property (nonatomic, assign) NSInteger myfont;
@property (nonatomic, strong) NSString *indexNo;
@property (nonatomic, strong) NSArray *imageurlarray;
@property (nonatomic, strong) NSString *myserachtext;
@property (nonatomic, readwrite) BOOL isTateShow;
@property (nonatomic, strong) NSString *isfromWhere;
@property (nonatomic, strong) NADoc *paperDoc;
@property (nonatomic, readwrite) BOOL isNewDetailview;
@property (nonatomic, readwrite) CGFloat navBarHeight;
@property (nonatomic, strong) NSString *btnType;
@property (nonatomic, strong) NSString *tagDetail;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSString *photoPathD;
- (void)updateViews;
- (void)updateLayout;
-(void)loadmyhtml;
- (void)textFontValue:(CGFloat)fontValue;
- (void)setShowStyle:(BOOL)isTateShow;
- (void)changeView:(NSString *)type;
@end

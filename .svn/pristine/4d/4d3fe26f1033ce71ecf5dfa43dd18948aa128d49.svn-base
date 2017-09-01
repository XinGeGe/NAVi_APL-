
#import <UIKit/UIKit.h>
#import "NADefine.h"
#import "NASubPagerView.h"


@protocol NAPaperViewDelegate <NSObject>

- (void)paperViewSelected:(id)object;
- (void)closePopover;

@end

@interface NAPaperView : UIView <UIScrollViewDelegate, NASubPagerViewDelegate>

@property (nonatomic, assign) id delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, readwrite) NSInteger currentindex;

- (void)initPagerData:(NSArray *)data;

@end

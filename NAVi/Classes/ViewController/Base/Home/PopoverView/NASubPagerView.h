
#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "NAFileManager.h"

@protocol NASubPagerViewDelegate <NSObject>

- (void)subPagerViewselected:(id)object;

@end

@interface NASubPagerView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *imageIdentfier;
@property (nonatomic, assign) id delegate;
- (void)imageViewWthInfo:(NADoc *)doc;
- (void)updateTitleWithName:(NSString *)name;
- (void)updateMainTitleWithName:(NSString *)name;
-(void)setFreeIdentfierView:(BOOL)isFree;
-(void)setIsShowImageIdentfier:(BOOL)isShow;

@end

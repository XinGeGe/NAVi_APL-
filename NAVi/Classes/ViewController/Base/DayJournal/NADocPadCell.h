
#import <UIKit/UIKit.h>
#import "NASubPagerView.h"

typedef void(^selectedObject)(id obj);

@interface NADocPadCell : UITableViewCell <NASubPagerViewDelegate>
{
    CGFloat subWidth;
}

@property (nonatomic, strong) NASubPagerView *docView1;
@property (nonatomic, strong) NASubPagerView *docView2;
@property (nonatomic, strong) NASubPagerView *docView3;
@property (nonatomic, strong) NASubPagerView *docView4;

@property (nonatomic, strong) selectedObject selectedObjectCompletionBlock;

@end


#import <UIKit/UIKit.h>

@protocol NAMenuViewDelegate <NSObject>

- (void)menuSelectIndex:(NSInteger)index;

@end

@interface NAMenuView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id delegate;
@property (nonatomic, strong) UITableView *tView;

@end

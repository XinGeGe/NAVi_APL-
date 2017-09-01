
#import <UIKit/UIKit.h>

typedef void(^DoneDate)(NSDate *date);

@interface NAPickerView : UIView

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) DoneDate doneDateBlock;

- (void)showPickerView:(NSDate *)date;
- (void)hidePickerView;

@end

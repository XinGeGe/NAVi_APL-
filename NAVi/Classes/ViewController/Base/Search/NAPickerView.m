
#import "NAPickerView.h"

#define PICKER_HEIGHT 200

@interface NAPickerView ()

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIBarButtonItem *cancelBtn;
@property (nonatomic, strong) UIBarButtonItem *doneBtn;
@property (nonatomic, strong) UIView *backView;

@end

@implementation NAPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateViews];
}

#pragma mark - layout -
#pragma mark

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.backgroundColor = [UIColor whiteColor];
        [_datePicker addTarget:self action:@selector(datePickerValueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

- (UIToolbar *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        _toolBar.backgroundColor = [UIColor whiteColor];
    }
    return _toolBar;
}

- (UIBarButtonItem *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnAction:)];
    }
    return _cancelBtn;
}

- (UIBarButtonItem *)doneBtn
{
    if (!_doneBtn) {
        _doneBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStylePlain target:self action:@selector(doneBtnAction:)];
    }
    return _doneBtn;
}

- (UIBarButtonItem *)spaceButtonItem
{
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    return spaceButtonItem;
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.backgroundColor = [UIColor lightGrayColor];
    }
    return _backView;
}


#pragma mark - utility -
#pragma mark

- (void)initViews
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backView];
    [self addSubview:self.datePicker];
    [self addSubview:self.toolBar];
    [self.toolBar setItems:[NSArray arrayWithObjects:self.cancelBtn, [self spaceButtonItem], self.doneBtn, nil]];
    self.hidden = YES;
    self.datePicker.hidden = YES;
    self.datePicker.alpha = 0.0f;
    self.backView.hidden = YES;
    self.backView.alpha = 0.0f;
}

- (void)updateViews
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.backView.frame = self.bounds;
    self.datePicker.frame = CGRectMake(0, height - PICKER_HEIGHT, width, PICKER_HEIGHT+ 20);
    self.toolBar.frame = CGRectMake(0, height - PICKER_HEIGHT - 40, width, 40);
}

- (void)showPickerView:(NSDate *)date
{
    self.hidden = YES;
    self.backView.hidden = YES;
    self.backView.alpha = 0.0f;
    [UIView animateWithDuration:0.5f animations:^{
        self.hidden = NO;
        self.backView.hidden = NO;
        self.backView.alpha = 0.7f;
        self.datePicker.hidden = NO;
        self.datePicker.alpha = 1.0f;
        self.toolBar.hidden = NO;
        self.toolBar.alpha = 1.0f;

    } completion:^(BOOL finished) {
        self.hidden = NO;
        [self.datePicker setDate:date ? date : [NSDate date] animated:YES];
    }];
}

- (void)hidePickerView
{
    self.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^{
        self.datePicker.hidden = YES;
        self.datePicker.alpha = 0.0f;
        self.toolBar.hidden = YES;
        self.toolBar.alpha = 0.0f;
        self.backView.hidden = YES;
        self.backView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma mark - button action -
#pragma mark

- (void)cancelBtnAction:(id)sender
{
    [self hidePickerView];
}
- (void)doneBtnAction:(id)sender
{
    [self hidePickerView];
    if (self.doneDateBlock) {
        self.doneDateBlock (self.datePicker.date);
    }

}

- (void)datePickerValueChange:(id)sender
{
}


@end

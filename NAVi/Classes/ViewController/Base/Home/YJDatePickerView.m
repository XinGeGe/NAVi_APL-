//
//  YJDatePickerView.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/21.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "YJDatePickerView.h"
#import "AppDelegate.h"
#import "FontUtil.h"
#define kRootWindow  ((AppDelegate*)([UIApplication sharedApplication].delegate)).window

static CGFloat mainViewHeight, screenHeight;
static CGFloat mainViewWidth, screenWidth;
@interface YJDatePickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *picker;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSString *selectedData;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) BOOL isCustomData;
@end

@implementation YJDatePickerView

#pragma mark - 初始化视图

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        screenHeight = [UIScreen mainScreen].bounds.size.height;
        screenWidth = [UIScreen mainScreen].bounds.size.width;
        mainViewHeight = screenHeight * 0.4;
        mainViewWidth = screenWidth;
        self.backgroundColor = [UIColor clearColor];
        self.selectedIndex = 0;
    }
    return self;
}

+ (YJDatePickerView * _Nonnull)pickDateWithCompletionHandle:(CompleteSelection _Nonnull)handler {
    
    YJDatePickerView *view = [[YJDatePickerView alloc] initWithFrame:kRootWindow.bounds];
    view.isCustomData = NO;
    view.completeSelection = handler;
    [kRootWindow addSubview:view];
    [view displayView];
    return view;
}

+ (YJDatePickerView * _Nonnull)pickCustomDataWithArray:(NSArray *_Nonnull)data completionHandle:(CompleteSelection _Nonnull)handler {
    YJDatePickerView *view = [[YJDatePickerView alloc] initWithFrame:kRootWindow.bounds];
    view.isCustomData = YES;
    view.completeSelection = handler;
    view.dataSource = [data copy];
    [view.picker reloadAllComponents];
    [kRootWindow addSubview:view];
    [view displayView];
    return view;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    if (isPhone) {
        return 40;
    }
    return 80.0;
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        if (isPhone) {
            [pickerLabel setFont:[FontUtil boldSystemFontOfSize:15]];
        }else{
            [pickerLabel setFont:[FontUtil boldSystemFontOfSize:40]];
        }
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - 控制数据

- (void)confirmData {
    if (self.completeSelection) {
        NADoc *doc = self.dataSource[self.selectedIndex];
        NSString *pagInfo = doc.pageInfoName;
        NSString *pageNo = doc.pageno;
        self.completeSelection(self.selectedIndex, pagInfo);
        [self.delegate selectedData:pageNo doc:doc];
    }
    [self dissmissView];
}

#pragma mark - 控制视图的展示

- (void)displayView {
    self.bgView.alpha = 0;
    self.mainView.alpha = 1;
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.alpha = 0.6;
        self.mainView.frame = CGRectMake(mainViewWidth/4, screenHeight/2-mainViewHeight/2, mainViewWidth/2, screenHeight/2);
    }];
}

- (void)dissmissView {
    [UIView animateWithDuration:0.3 animations:^{
        self.mainView.frame = CGRectMake(0, screenHeight, mainViewWidth, mainViewHeight);
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NADoc *doc = self.dataSource[row];
    NSString *pagInfo = doc.pageInfoName;
    if ([pagInfo isKindOfClass:[NSString class]]) {
        return pagInfo;
    }
     return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NADoc *doc = self.dataSource[row];
    NSString *pagInfo = doc.pageInfoName;
    self.selectedData = pagInfo;
    self.selectedIndex = row;
}

#pragma mark - 构建视图

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , screenWidth, screenHeight)];
        _bgView.backgroundColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:0.6];
        [self addSubview:_bgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissView)];
        [_bgView addGestureRecognizer:tap];
        
    }
    return _bgView;
}


- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight, mainViewWidth, mainViewHeight)];
        _mainView.backgroundColor = [UIColor whiteColor];
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [cancelBtn setTitle:@"キャンセル" forState:UIControlStateNormal];
        if (isPhone) {
            [cancelBtn setFrame:CGRectMake(15, 5, 60, 20)];
            [cancelBtn.titleLabel setFont:[FontUtil systemFontOfSize:12]];
        }else{
            [cancelBtn setFrame:CGRectMake(15, 5, 60*2, 40)];
            [cancelBtn.titleLabel setFont:[FontUtil systemFontOfSize:20]];
        }
        [cancelBtn setTintColor:[UIColor lightGrayColor]];
        [cancelBtn addTarget:self action:@selector(dissmissView) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:cancelBtn];
        
        [confirmBtn setTitle:@"確認" forState:UIControlStateNormal];
        if (isPhone) {
            [confirmBtn setFrame:CGRectMake(mainViewWidth/2-40, 5, 30, 20)];
            [confirmBtn.titleLabel setFont:[FontUtil systemFontOfSize:12]];
        }else{
            [confirmBtn setFrame:CGRectMake(mainViewWidth/2-70, 5, 60, 40)];
            [confirmBtn.titleLabel setFont:[FontUtil systemFontOfSize:20]];
        }
        [confirmBtn setTintColor:[UIColor colorWithRed:118 / 255.0 green:172 / 255.0 blue:248 / 255.0 alpha:1]];
        [confirmBtn addTarget:self action:@selector(confirmData) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:confirmBtn];
        
        UIView *line;
        if (isPhone) {
            line = [[UIView alloc] initWithFrame:CGRectMake(0, 30, screenWidth/2, 0.5)];
        }else{
            line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, screenWidth/2, 0.5)];
        }
        line.backgroundColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1];
        [_mainView addSubview:line];
        

        if (self.isCustomData) {
            [_mainView addSubview:self.picker];
        } else {
            [_mainView addSubview:self.datePicker];
        }
        [self addSubview:_mainView];
    }
    return _mainView;
}

- (UIPickerView *)picker {
    if (!_picker) {
        if (isPhone) {
            _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, mainViewWidth/2, screenHeight/2-40)];
        }else{
            _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, mainViewWidth/2, screenHeight/2-40)];
        }
        
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 47, mainViewWidth, mainViewHeight - 47)];
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
        [_datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
        [_datePicker setTimeZone:[NSTimeZone localTimeZone]];
        [_datePicker setDate:[NSDate date] animated:YES];
        //        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}


@end

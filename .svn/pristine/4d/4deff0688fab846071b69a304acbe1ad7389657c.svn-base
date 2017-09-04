//
//  DAYCalendarView.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/12.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "DAYCalendarView.h"
#import "DAYNavigationBar.h"
#import "DAYComponentView.h"
#import "DAYIndicatorView.h"
#import "DAYUtils.h"
#import "FontUtil.h"

@interface DAYCalendarView () {
    NSUInteger _visibleYear;
    NSUInteger _visibleMonth;
    NSUInteger _currentVisibleRow;
    NSArray *_eventsInVisibleMonth;
    NSMutableArray *arrView;
    NSMutableArray *imageArrView;
    NSMutableArray *selectArrView;
}

@property (strong, nonatomic) DAYNavigationBar *navigationBarView;
@property (strong, nonatomic) UIStackView *weekHeaderView;
@property (strong, nonatomic) UIView *contentWrapperView;
@property (strong, nonatomic) UIStackView *contentView;
@property (strong, nonatomic) DAYIndicatorView *selectedIndicatorView;
@property (readonly, copy) NSString *nowMonth;
@property (strong, nonatomic) NSMutableArray<DAYComponentView *> *componentViews;
@property (readonly, copy) NSString *navigationBarTitle;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end

@implementation DAYCalendarView


- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.clipsToBounds = YES;
    // Set visible viewport to one contains today by default.
    NSDate *todayDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateComponents *comps = [DAYUtils dateComponentsFromDate:todayDate];
    self->_visibleYear = comps.year;
    self->_visibleMonth = comps.month;
    // Initialize default appearance settings.
    self.componentTextColor = [UIColor darkGrayColor];
    self.highlightedComponentTextColor = [UIColor whiteColor];
    self.selectedIndicatorColor = [UIColor colorWithRed:234/255.0 green:115/255.0 blue:160/255.0 alpha:1];
    //blue
    self.beforeIndicatorColor = [UIColor colorWithRed:103.0/255.0 green:165.0/255.0 blue:224.0/255.0 alpha:1];
    self.indicatorRadius = 15;
    self.navigationBarView = [[DAYNavigationBar alloc] init];
    self.navigationBarView.translatesAutoresizingMaskIntoConstraints = NO;
    self.navigationBarView.textLabel.text = self.navigationBarTitle;
    self.navigationBarView.prevTitle.text = [NSString stringWithFormat:@"%ld 月",self.navigationBarTitle.integerValue - 1];
    self.navigationBarView.nextTitle.text = self.navigationBarTitle;
    self.navigationBarView.nextButton.hidden = YES;
    self.navigationBarView.nextTitle.hidden = YES;
    self.navigationBarView.prevButton.hidden = NO;
    self.navigationBarView.prevTitle.hidden = NO;
    
    
    
    [self.navigationBarView addTarget:self action:@selector(navigationBarButtonDidTap:) forControlEvents:UIControlEventValueChanged];
    
    [self.navigationBarView.prevButton addTarget:self action:@selector(prevButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationBarView.nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationBarView.prevTitle.userInteractionEnabled = YES;
    UITapGestureRecognizer *prevTitleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(prevTitleTouchUpInside:)];
    [self.navigationBarView.prevTitle addGestureRecognizer:prevTitleTapGestureRecognizer];
    
    self.navigationBarView.nextTitle.userInteractionEnabled = YES;
    UITapGestureRecognizer *nextTitleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextTitleTouchUpInside:)];
    [self.navigationBarView.nextTitle addGestureRecognizer:nextTitleTapGestureRecognizer];
    
    
    [self addSubview:self.navigationBarView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationBarView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationBarView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationBarView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    [self.navigationBarView addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationBarView
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0
                                                                    constant:50]];
    
    self.weekHeaderView = [[UIStackView alloc] init];
    self.weekHeaderView.translatesAutoresizingMaskIntoConstraints = NO;
    self.weekHeaderView.axis = UILayoutConstraintAxisHorizontal;
    self.weekHeaderView.distribution = UIStackViewDistributionFillEqually;
    self.weekHeaderView.alignment = UIStackViewAlignmentCenter;
    
    [self addSubview:self.weekHeaderView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.weekHeaderView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.navigationBarView
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.weekHeaderView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-self.indicatorRadius / 2]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.weekHeaderView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    [self.weekHeaderView addConstraint:[NSLayoutConstraint constraintWithItem:self.weekHeaderView
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0
                                                                     constant:30]];
    
    self.contentWrapperView = [[UIView alloc] init];
    self.contentWrapperView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self addSubview:self.contentWrapperView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentWrapperView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.weekHeaderView
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentWrapperView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:-self.indicatorRadius / 2]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentWrapperView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-self.indicatorRadius / 2]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentWrapperView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    
    self.contentView = [[UIStackView alloc] init];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.axis = UILayoutConstraintAxisVertical;
    self.contentView.distribution = UIStackViewDistributionFillEqually;
    self.contentView.alignment = UIStackViewAlignmentFill;
    
    [self.contentWrapperView addSubview:self.contentView];
    [self.contentWrapperView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentWrapperView
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:1.0
                                                                         constant:0]];
    [self.contentWrapperView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentWrapperView
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1.0
                                                                         constant:0]];
    [self.contentWrapperView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentWrapperView
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1.0
                                                                         constant:0]];
    [self.contentWrapperView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentWrapperView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1.0
                                                                         constant:0]];
    
    self.componentViews = [NSMutableArray array];
    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.contentWrapperView addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.contentWrapperView addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    [self makeUIElements];
    arrView = [[NSMutableArray alloc] init];
    imageArrView = [[NSMutableArray alloc] init];
    selectArrView = [[NSMutableArray alloc] init];

}
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (self->_visibleMonth == _toDayMonth.integerValue -1) {
            [self jumpToNextMonth];
            self.navigationBarView.nextButton.hidden = YES;
            self.navigationBarView.nextTitle.hidden = YES;
            self.navigationBarView.prevTitle.hidden = NO;
            self.navigationBarView.prevButton.hidden = NO;
        }
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self->_visibleMonth == _toDayMonth.integerValue) {
            [self jumpToPreviousMonth];
            self.navigationBarView.prevTitle.hidden = YES;
            self.navigationBarView.prevButton.hidden = YES;
            self.navigationBarView.nextButton.hidden = NO;
            self.navigationBarView.nextTitle.hidden = NO;
        }
    }
}

- (void)makeUIElements {
    // Make indicator views;
    self.selectedIndicatorView = [[DAYIndicatorView alloc] init];
    self.selectedIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    self.selectedIndicatorView.hidden = YES;
    [self.contentWrapperView insertSubview:self.selectedIndicatorView belowSubview:self.contentView];
    
    // Make weekday header view.
    for (int i = 1; i <= 7; i++) {
        UILabel *weekdayLabel = [[UILabel alloc] init];
        [self.weekHeaderView addArrangedSubview:weekdayLabel];
    }
    
    // Make content view.
    __block int currentColumn = 0;
    __block UIStackView *currentRowView;
    
    void (^makeRow)() = ^{
        currentRowView = [[UIStackView alloc] init];
        currentRowView.axis = UILayoutConstraintAxisHorizontal;
        currentRowView.distribution = UIStackViewDistributionFillEqually;
        currentRowView.alignment = UIStackViewAlignmentFill;
    };
    
    void (^submitRowIfNecessary)() = ^{
        if (currentColumn >= 7) {
            [self.contentView addArrangedSubview:currentRowView];
            currentColumn = 0;
            makeRow();
        }
    };
    
    void (^submitCell)(UIView *) = ^(UIView *cellView) {
        [currentRowView addArrangedSubview:cellView];
        [self.componentViews addObject:(id) cellView];
        currentColumn++;
        submitRowIfNecessary();
    };
    
    makeRow();
    
    for (int i = 0; i < 42; i++) {
        DAYComponentView *componentView = [[DAYComponentView alloc] init];
        componentView.textLabel.textAlignment = NSTextAlignmentCenter;
        [componentView addTarget:self action:@selector(componentDidTap:) forControlEvents:UIControlEventTouchUpInside];
        submitCell(componentView);
    }
    
    _nowMonth = _publishDate;
}

- (void)configureIndicatorViews {
    self.selectedIndicatorView.color = self.selectedIndicatorColor;
}

- (void)configureWeekdayHeaderView {
    BOOL canUseLocalizedStrings = self.localizedStringsOfWeekday && self.localizedStringsOfWeekday.count == 7;
    
    [self.weekHeaderView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *weekdayLabel = (id) obj;
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        weekdayLabel.font = [FontUtil systemFontOfSize:15];
        weekdayLabel.textColor = [UIColor blackColor];
        if (canUseLocalizedStrings) {
            weekdayLabel.text = self.localizedStringsOfWeekday[idx];
        }
        else {
            weekdayLabel.text = [DAYUtils stringOfWeekdayInEnglish:idx + 1];
        }
    }];
}

- (void)configureComponentView:(DAYComponentView *)view withDay:(NSUInteger)day month:(NSUInteger)month year:(NSUInteger)year {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = day;
    comps.month = month;
    comps.year = year;
    view.representedObject = comps;
    if ((self.selectedIndicatorView && self.selectedIndicatorView.attachingView == view)) {
        [view setSelected:YES];
    }else {
        [view setSelected:NO];
    }
    [view setSelectedData:NO];
    view.textColor = self.componentTextColor;
    view.highlightTextColor = self.highlightedComponentTextColor;
    view.textLabel.alpha = self->_visibleMonth == month ? 1.0 : 0.5;
    view.textLabel.font = [FontUtil systemFontOfSize:16];
    view.textLabel.text = [NSString stringWithFormat:@"%d", (int) day];
    
    
    
    
    for (NSDictionary *nowSelectedDate in _nowMonthArray) {
        NSString *month2 = nil;
        NSString *publishDate = [nowSelectedDate objectForKey:@"publishDate"];
        NSString *regionViewFlg = [nowSelectedDate objectForKey:@"regionViewFlg"];
        if ([[publishDate substringWithRange:NSMakeRange(4, 2)] hasPrefix:@"0"]) {
            month2 = [publishDate substringWithRange:NSMakeRange(5, 1)];
        }else{
            month2 = [publishDate substringWithRange:NSMakeRange(4, 2)];
        }
        NSString *day2= nil;
        if ([[publishDate substringWithRange:NSMakeRange(6, 2)] hasPrefix:@"0"]) {
            day2 = [publishDate substringWithRange:NSMakeRange(7, 1)];
        }else{
            day2 = [publishDate substringWithRange:NSMakeRange(6, 2)];
        }
        if ([month2 integerValue] == month && [day2 integerValue] == day) {
            DAYIndicatorView *_nowMonthView = [[DAYIndicatorView alloc] init];
            _nowMonthView.selectDay = day2;
            _nowMonthView.selectMonth = month2;
            _nowMonthView.translatesAutoresizingMaskIntoConstraints = NO;
            
            if (_nowMonth == nil) {
                if (month == _publishDate.integerValue) {
                    if (_selectChange == 0) {
                        if (month == _monthNew.integerValue && day == _dayNew.integerValue) {
                            _nowMonthView.color = self.selectedIndicatorColor;
                            self->_selectedDate = [DAYUtils dateFromDateComponents:comps];
                            _selectChange =1;
                            [view setSelected:YES];
                            [selectArrView addObject:self.selectedIndicatorView];
                        }else{
                            view.textColor = [UIColor whiteColor];
                            _nowMonthView.color = self.beforeIndicatorColor;
                            [view setSelectedData:YES];
                        }
                    }else{
                        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                        NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
                        [dateformatter setLocale:locale];
                        [dateformatter setDateFormat:@"yyyyMMdd"];
                        NSString * date = [dateformatter stringFromDate:self.selectedDate];
                        
                        NSString *monthdate = nil;
                        if ([[date substringWithRange:NSMakeRange(4, 2)] hasPrefix:@"0"]) {
                            monthdate = [date substringWithRange:NSMakeRange(5, 1)];
                        }else{
                            monthdate = [date substringWithRange:NSMakeRange(4, 2)];
                        }
                        NSString *daydate= nil;
                        if ([[date substringWithRange:NSMakeRange(6, 2)] hasPrefix:@"0"]) {
                            daydate = [date substringWithRange:NSMakeRange(7, 1)];
                        }else{
                            daydate = [date substringWithRange:NSMakeRange(6, 2)];
                        }
                        if (month == monthdate.integerValue && day == daydate.integerValue) {
                            _nowMonthView.color = self.selectedIndicatorColor;
                            self->_selectedDate = [DAYUtils dateFromDateComponents:comps];
                            [view setSelected:YES];
                            [selectArrView addObject:self.selectedIndicatorView];
                        }else{
                            _nowMonthView.color = self.beforeIndicatorColor;
                            view.textColor = [UIColor whiteColor];
                            [view setSelectedData:YES];
                        }
                    }
                    
                }
            }else{
                if (month2 == _nowMonth) {
                    if (_selectChange == 0) {
                        if (month == _monthNew.integerValue && day == _dayNew.integerValue) {
                            _nowMonthView.color = self.selectedIndicatorColor;
                            self->_selectedDate = [DAYUtils dateFromDateComponents:comps];
                            _selectChange =1;
                            [view setSelected:YES];
                            [selectArrView addObject:self.selectedIndicatorView];
                        }else{
                            _nowMonthView.color = self.beforeIndicatorColor;
                            view.textColor = [UIColor whiteColor];
                            [view setSelectedData:YES];
                        }
                    }else{
                        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                        NSLocale *locale = [[NSLocale alloc]  initWithLocaleIdentifier:[[NSLocale preferredLanguages]  objectAtIndex:0]];
                        [dateformatter setLocale:locale];
                        [dateformatter setDateFormat:@"yyyyMMdd"];
                        NSString * date = [dateformatter stringFromDate:self.selectedDate];
                        
                        NSString *monthdate = nil;
                        if ([[date substringWithRange:NSMakeRange(4, 2)] hasPrefix:@"0"]) {
                            monthdate = [date substringWithRange:NSMakeRange(5, 1)];
                        }else{
                            monthdate = [date substringWithRange:NSMakeRange(4, 2)];
                        }
                        NSString *daydate= nil;
                        if ([[date substringWithRange:NSMakeRange(6, 2)] hasPrefix:@"0"]) {
                            daydate = [date substringWithRange:NSMakeRange(7, 1)];
                        }else{
                            daydate = [date substringWithRange:NSMakeRange(6, 2)];
                        }

                        if (month == monthdate.integerValue && day == daydate.integerValue) {
                            _nowMonthView.color = self.selectedIndicatorColor;
                            self->_selectedDate = [DAYUtils dateFromDateComponents:comps];
                            [view setSelected:YES];
                            [selectArrView addObject:self.selectedIndicatorView];
                        }else{
                            _nowMonthView.color = self.beforeIndicatorColor;
                            view.textColor = [UIColor whiteColor];
                            [view setSelectedData:YES];
                        }
                    }
                }
            }
            
            
            [self.contentWrapperView insertSubview:_nowMonthView belowSubview:self.contentView];
            
            _nowMonthView.transform = CGAffineTransformMakeScale(0, 0);
            [UIView animateWithDuration:0.3 animations:^{
                _nowMonthView.transform = CGAffineTransformIdentity;
            }];
            
            if ([regionViewFlg isEqualToString:@"1"]) {
                UIImageView *localImage = [[UIImageView alloc]init];
                localImage.image = [UIImage imageNamed:@"30_star"];
                [view addSubview:localImage];
                [localImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(view.mas_right).mas_offset(-5);
                    make.bottom.equalTo(view.mas_bottom);
                    make.width.height.mas_equalTo(8);
                }];
                [imageArrView addObject:localImage];
            }
            _nowMonthView.attachingView = view;
            [self addConstraintToCenterIndicatorView:_nowMonthView toView:view];
            [arrView addObject:_nowMonthView];
            
            if (self.selectedDate != nil) {
                if (_select ==0) {
                    
                }else{
                    if (_noReload == 1) {
                        
                    }else{
                        [self.delegate calendarViewDidChange:self.selectedDate];
                    }
                }
                
                
            }
        }
        
    }
    
    
    
    
}

- (void)configureContentView {
    NSUInteger pointer = 0;
    
    NSUInteger totalDays = [DAYUtils daysInMonth:self->_visibleMonth ofYear:self->_visibleYear];
    NSUInteger paddingDays = [DAYUtils firstWeekdayInMonth:self->_visibleMonth ofYear:self->_visibleYear] - 1;

    // Make padding days.
    NSUInteger paddingYear = self->_visibleMonth == 1 ? self->_visibleYear - 1 : self->_visibleYear;
    NSUInteger paddingMonth = self->_visibleMonth == 1 ? 12 : self->_visibleMonth - 1;
    NSUInteger totalDaysInLastMonth = [DAYUtils daysInMonth:paddingMonth ofYear:paddingYear];
    
    for (int j = (int) paddingDays - 1; j >= 0; j--) {
        [self configureComponentView:self.componentViews[pointer++] withDay:totalDaysInLastMonth - j month:paddingMonth year:paddingYear];
    }
    
    // Make days in current month.
    for (int j = 0; j < totalDays; j++) {
        [self configureComponentView:self.componentViews[pointer++] withDay:j + 1 month:self->_visibleMonth year:self->_visibleYear];
    }
    
    // Make days in next month to fill the remain cells.
    NSUInteger reserveYear = self->_visibleMonth == 12 ? self->_visibleYear + 1 : self->_visibleYear;
    NSUInteger reserveMonth = self->_visibleMonth == 12 ? 1 : self->_visibleMonth + 1;
    
    for (int j = 0; self.componentViews.count - pointer > 0; j++) {
        [self configureComponentView:self.componentViews[pointer++] withDay:j + 1 month:reserveMonth year:reserveYear];
    }
}

- (void)addConstraintToCenterIndicatorView:(UIView *)view toView:(UIView *)toView {
    [[self.contentWrapperView.constraints copy] enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstItem == view) {
            [self.contentWrapperView removeConstraint:obj];
        }
    }];
    
    [self.contentWrapperView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:toView
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1.0
                                                                         constant:0]];
    [self.contentWrapperView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:toView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1.0
                                                                         constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:self.indicatorRadius * 2]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:self.indicatorRadius * 2]];
}

- (NSString *)navigationBarTitle {
    NSString *stringOfMonth = [DAYUtils stringOfMonthInEnglish:self->_visibleMonth];
    return [NSString stringWithFormat:@"%@", stringOfMonth];
}

- (DAYComponentView *)componentViewForDateComponents:(NSDateComponents *)comps {
    __block DAYComponentView *view = nil;
    [self.componentViews enumerateObjectsUsingBlock:^(DAYComponentView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDateComponents *_comps = obj.representedObject;
        if (_comps.day == comps.day && _comps.month == comps.month && _comps.year == comps.year) {
            view = obj;
            *stop = YES;
        }
        
    }];
    
    return view;
}

- (void)navigationBarButtonDidTap:(id)sender {
    switch (self.navigationBarView.lastCommand) {
        case DAYNaviagationBarCommandPrevious:
            if (self->_visibleMonth == _publishDate.integerValue) {
                [self jumpToPreviousMonth];
                self.navigationBarView.prevTitle.hidden = YES;
                self.navigationBarView.prevButton.hidden = YES;
                self.navigationBarView.nextButton.hidden = NO;
                self.navigationBarView.nextTitle.hidden = NO;
            }
            break;
            
        case DAYNaviagationBarCommandNext:
            if (self->_visibleMonth == _publishDate.integerValue -1) {
                [self jumpToNextMonth];
                self.navigationBarView.prevTitle.hidden = NO;
                self.navigationBarView.prevButton.hidden = NO;
                self.navigationBarView.nextButton.hidden = YES;
                self.navigationBarView.nextTitle.hidden = YES;
            }
            break;
            
        default:
            break;
    }
}

- (void)prevButtonClick:(UIButton *)sender {
    [self jumpToPreviousMonth];
    self.navigationBarView.prevTitle.hidden = YES;
    self.navigationBarView.prevButton.hidden = YES;
    self.navigationBarView.nextButton.hidden = NO;
    self.navigationBarView.nextTitle.hidden = NO;
}

- (void)nextButtonClick:(UIButton *)sender {
    [self jumpToNextMonth];
    self.navigationBarView.prevTitle.hidden = NO;
    self.navigationBarView.prevButton.hidden = NO;
    self.navigationBarView.nextButton.hidden = YES;
    self.navigationBarView.nextTitle.hidden = YES;
}

- (void)prevTitleTouchUpInside:(UITapGestureRecognizer *)recognizer {
    [self jumpToPreviousMonth];
    self.navigationBarView.prevTitle.hidden = YES;
    self.navigationBarView.prevButton.hidden = YES;
    self.navigationBarView.nextButton.hidden = NO;
    self.navigationBarView.nextTitle.hidden = NO;
}

- (void)nextTitleTouchUpInside:(UITapGestureRecognizer *)recognizer {
    [self jumpToNextMonth];
    self.navigationBarView.prevTitle.hidden = NO;
    self.navigationBarView.prevButton.hidden = NO;
    self.navigationBarView.nextButton.hidden = YES;
    self.navigationBarView.nextTitle.hidden = YES;
}

- (void)componentDidTap:(DAYComponentView *)sender {
    _select = 1;
    NSDateComponents *comps = sender.representedObject;
    if (comps.year != self->_visibleYear || comps.month != self->_visibleMonth) {
        if (comps.month == _publishDate.integerValue -1) {
            [self jumpToMonth:comps.month year:comps.year day:comps.day];
            self.navigationBarView.prevTitle.hidden = YES;
            self.navigationBarView.prevButton.hidden = YES;
            self.navigationBarView.nextButton.hidden = NO;
            self.navigationBarView.nextTitle.hidden = NO;

        }else if (comps.month == _publishDate.integerValue){
            [self jumpToMonth:comps.month year:comps.year day:comps.day];
            self.navigationBarView.nextButton.hidden = YES;
            self.navigationBarView.nextTitle.hidden = YES;
            self.navigationBarView.prevTitle.hidden = NO;
            self.navigationBarView.prevButton.hidden = NO;
        }else{
            
        }
        return;
    }
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    [arr addObjectsFromArray:_nowMonthArray];
    for (NSDictionary *nowSelectedDate in arr) {
        NSString *month2 = nil;
        NSString *publishDate = [nowSelectedDate objectForKey:@"publishDate"];
        if ([[publishDate substringWithRange:NSMakeRange(4, 2)] hasPrefix:@"0"]) {
            month2 = [publishDate substringWithRange:NSMakeRange(5, 1)];
        }else{
            month2 = [publishDate substringWithRange:NSMakeRange(4, 2)];
        }
        NSString *day2= nil;
        if ([[publishDate substringWithRange:NSMakeRange(6, 2)] hasPrefix:@"0"]) {
            day2 = [publishDate substringWithRange:NSMakeRange(7, 1)];
        }else{
            day2 = [publishDate substringWithRange:NSMakeRange(6, 2)];
        }
    
        if (comps.month == month2.integerValue && comps.day == day2.integerValue) {
            if (self.selectedIndicatorView.hidden) {
                for(DAYIndicatorView *view in arrView) {

                    if (view.selectMonth ==month2 && view.selectDay == day2 ) {
                        view.color = self.selectedIndicatorColor;
                        self.selectedIndicatorView.hidden = NO;
                        self.selectedIndicatorView.transform = CGAffineTransformMakeScale(0, 0);
                        self.selectedIndicatorView.attachingView = sender;
                        [self addConstraintToCenterIndicatorView:self.selectedIndicatorView toView:sender];
                        
                        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:kNilOptions animations:^{
                            self.selectedIndicatorView.transform = CGAffineTransformIdentity;
                            [sender setSelected:YES];
                        } completion:nil];
                        self->_selectedDate = [DAYUtils dateFromDateComponents:comps];
                    }else{
                        if (_nowMonth == nil) {
                            if (view.selectMonth.integerValue == _publishDate.integerValue) {
                                view.color = self.beforeIndicatorColor;
                                sender.textColor = [UIColor whiteColor];
                                [sender setSelectedData:YES];
                            }else{
                                view.color = self.beforeIndicatorColor;
                                sender.textColor = [UIColor whiteColor];
                                [sender setSelectedData:YES];
                            }
                        }else{
                            if (view.selectMonth.integerValue == _nowMonth.integerValue) {
                                view.color = self.beforeIndicatorColor;
                                sender.textColor = [UIColor whiteColor];
                                [sender setSelectedData:YES];
                            }else{
                                view.color = self.beforeIndicatorColor;
                                sender.textColor = [UIColor whiteColor];
                                [sender setSelectedData:YES];
                            }
                        }
                    }
                }
                
            }
            else {
                for(DAYIndicatorView *view in arrView) {
                    
                    if (view.selectMonth ==month2 && view.selectDay == day2 ) {
                        view.color = self.selectedIndicatorColor;
                        sender.textColor = [UIColor whiteColor];
                        [self addConstraintToCenterIndicatorView:self.selectedIndicatorView toView:sender];
                        
                        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:kNilOptions animations:^{
                            [self.contentWrapperView layoutIfNeeded];
                            
                            [((DAYComponentView *) self.selectedIndicatorView.attachingView) setSelected:NO];
                            [sender setSelected:YES];
                        } completion:nil];
                        
                        self.selectedIndicatorView.attachingView = sender;
                        self->_selectedDate = [DAYUtils dateFromDateComponents:comps];
                    }else{
                        if (_nowMonth == nil) {
                            if (view.selectMonth.integerValue == _publishDate.integerValue) {
                                view.color = self.beforeIndicatorColor;
                                sender.textColor = [UIColor whiteColor];
                                [sender setSelectedData:YES];
                            }else{
                                view.color = self.beforeIndicatorColor;
                                sender.textColor = [UIColor whiteColor];
                                [sender setSelectedData:YES];
                            }
                        }else{
                            if (view.selectMonth.integerValue == _nowMonth.integerValue) {
                                view.color = self.beforeIndicatorColor;
                                sender.textColor = [UIColor whiteColor];
                                [sender setSelectedData:YES];
                            }else{
                                view.color = self.beforeIndicatorColor;
                                sender.textColor = [UIColor whiteColor];
                                [sender setSelectedData:YES];
                            }
                        }
                    }
                }
            }
            
            
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
    
    
}

- (void)updateCurrentVisibleRow {
    [self.contentView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = NO;
        obj.alpha = 1;
    }];
    self.selectedIndicatorView.alpha = self.selectedIndicatorView.attachingView.superview.hidden ? 0 : 1;
}

- (void)reloadViewAnimated:(BOOL)animated {
    [self configureIndicatorViews];
    [self configureWeekdayHeaderView];
    [self configureContentView];
    
    if (animated) {
        [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:nil];
    }
}

#pragma mark - Actions

- (void)jumpToNextMonth {
    
    NSUInteger nextMonth;
    NSUInteger nextYear;
    
    if (self->_visibleMonth >= 12) {
        nextMonth = 1;
        nextYear = self->_visibleYear + 1;
    }
    else {
        nextMonth = self->_visibleMonth + 1;
        nextYear = self->_visibleYear;
    }
    
    [self jumpToMonth:nextMonth year:nextYear];
   
}

- (void)jumpToPreviousMonth {
    
    NSUInteger prevMonth;
    NSUInteger prevYear;
    
    if (self->_visibleMonth <= 1) {
        prevMonth = 12;
        prevYear = self->_visibleYear - 1;
    }
    else {
        prevMonth = self->_visibleMonth - 1;
        prevYear = self->_visibleYear;
    }
    
    [self jumpToMonth:prevMonth year:prevYear];
   
}

- (void)jumpToMonth:(NSUInteger)month year:(NSUInteger)year day:(NSInteger)day {
    _monthNew = [NSString stringWithFormat:@"%lu",(unsigned long)month];
    _dayNew = [NSString stringWithFormat:@"%lu",(unsigned long)day];
    _nowMonth = [NSString stringWithFormat:@"%ld",month];
    BOOL direction;
    if (self->_visibleYear == year) {
        direction = month > self->_visibleMonth;
    }
    else {
        direction = year > self->_visibleYear;
    }
    
    self->_visibleMonth = month;
    self->_visibleYear = year;
    //self->_selectedDate = nil;
    
    // Deal with indicator views.
    self.selectedIndicatorView.attachingView = nil;
    [self.selectedIndicatorView setHidden:YES];

    [self.contentView removeArrangedSubview:self.contentWrapperView];
    if (arrView.count > 0) {
        for(DAYIndicatorView *view in arrView) {
            [view removeFromSuperview];
        }
        [arrView removeAllObjects];
        
        
    }
    if (imageArrView.count > 0) {
        for(UIImageView *view in imageArrView) {
            [view removeFromSuperview];
        }
        [imageArrView removeAllObjects];
    }
    
    if (selectArrView.count >0) {
        for(DAYIndicatorView *view in arrView) {
            [view removeFromSuperview];
        }
        [selectArrView removeAllObjects];
        
    }
    [UIView transitionWithView:self.navigationBarView.textLabel duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.navigationBarView.textLabel.text = self.navigationBarTitle;
    } completion:nil];
    
    UIView *snapshotView = [self.contentWrapperView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = self.contentWrapperView.frame;
    [self addSubview:snapshotView];
    
    [self configureContentView];
    
    self.contentView.transform = CGAffineTransformMakeTranslation(CGRectGetHeight(self.contentView.frame) / 3 * (direction ? 1 : -1),0);
    self.contentView.alpha = 0;
    
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.72 initialSpringVelocity:0 options:kNilOptions animations:^{
        snapshotView.transform = CGAffineTransformMakeTranslation(-CGRectGetHeight(self.contentView.frame) / 3 * (direction ? 1 : -1),0);
        snapshotView.alpha = 0;
        
        self.selectedIndicatorView.transform = CGAffineTransformMakeScale(0, 0);
        self.contentView.transform = CGAffineTransformIdentity;
        self.contentView.alpha = 1;
        
    } completion:^(BOOL finished) {
        [snapshotView removeFromSuperview];
        
        if (!self.selectedDate) {
            self.selectedIndicatorView.hidden = YES;
        }
    }];
}
- (void)jumpToMonth:(NSUInteger)month year:(NSUInteger)year {
    _nowMonth = [NSString stringWithFormat:@"%ld",month];
    BOOL direction;
    if (self->_visibleYear == year) {
        direction = month > self->_visibleMonth;
    }
    else {
        direction = year > self->_visibleYear;
    }
    
    self->_visibleMonth = month;
    self->_visibleYear = year;
    //self->_selectedDate = nil;
    
    // Deal with indicator views.
    self.selectedIndicatorView.attachingView = nil;
    [self.selectedIndicatorView setHidden:YES];
    
    
    
    [self.contentView removeArrangedSubview:self.contentWrapperView];
    if (arrView.count > 0) {
        for(DAYIndicatorView *view in arrView) {
            [view removeFromSuperview];
        }
        [arrView removeAllObjects];
        
    }
    if (imageArrView.count > 0) {
        for(UIImageView *view in imageArrView) {
            [view removeFromSuperview];
        }
        [imageArrView removeAllObjects];
    }
    if (selectArrView.count >0) {
        for(DAYIndicatorView *view in arrView) {
            [view removeFromSuperview];
        }
        [selectArrView removeAllObjects];
        
    }
    
    
    [UIView transitionWithView:self.navigationBarView.textLabel duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.navigationBarView.textLabel.text = self.navigationBarTitle;
    } completion:nil];
    
    UIView *snapshotView = [self.contentWrapperView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = self.contentWrapperView.frame;
    [self addSubview:snapshotView];
    
    [self configureContentView];
    
    self.contentView.transform = CGAffineTransformMakeTranslation(CGRectGetHeight(self.contentView.frame) / 3 * (direction ? 1 : -1),0);
    self.contentView.alpha = 0;
    
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.72 initialSpringVelocity:0 options:kNilOptions animations:^{
        snapshotView.transform = CGAffineTransformMakeTranslation(-CGRectGetHeight(self.contentView.frame) / 3 * (direction ? 1 : -1),0);
        snapshotView.alpha = 0;
        
        self.selectedIndicatorView.transform = CGAffineTransformMakeScale(0, 0);
        self.contentView.transform = CGAffineTransformIdentity;
        self.contentView.alpha = 1;
        
    } completion:^(BOOL finished) {
        [snapshotView removeFromSuperview];
        
        if (!self.selectedDate) {
            self.selectedIndicatorView.hidden = YES;
        }
    }];
}

#pragma mark -

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (_noReload == 1) {
        
    }else{
        [self reloadViewAnimated:NO];
    }
    
}


@end

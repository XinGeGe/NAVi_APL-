//
//  DAYCalendarView.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/12.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DAYCalendarViewDelegate
-(void)calendarViewDidChange:(id)sender;
@end
@interface DAYCalendarView : UIControl
@property (copy, nonatomic) NSDate *selectedDate;

@property (copy, nonatomic) NSArray<NSString *> *localizedStringsOfWeekday;
@property(assign,nonatomic)id<DAYCalendarViewDelegate> delegate;
// Appearance settings:
@property (copy, nonatomic) UIColor *componentTextColor;
@property (copy, nonatomic) UIColor *highlightedComponentTextColor;
@property (copy, nonatomic) UIColor *selectedIndicatorColor;
//@property (copy, nonatomic) UIColor *todayIndicatorColor;
@property (copy, nonatomic) UIColor *beforeIndicatorColor;
@property (assign, nonatomic) CGFloat indicatorRadius;
@property (nonatomic, strong) NSMutableArray *nowMonthArray;
@property (nonatomic, strong) NSString *publishDate;
@property (nonatomic, strong) NSString *monthNew;
@property (nonatomic, strong) NSString *dayNew;
@property (nonatomic, assign) NSInteger noReload;
@property (nonatomic, assign) NSInteger select;
- (void)reloadViewAnimated:(BOOL)animated;   // Invalidate the original view, use it after changing the appearance settings.

- (void)jumpToNextMonth;
- (void)jumpToPreviousMonth;
- (void)jumpToMonth:(NSUInteger)month year:(NSUInteger)year;
- (void)jumpToMonth:(NSUInteger)month year:(NSUInteger)year day:(NSInteger)day;
@end

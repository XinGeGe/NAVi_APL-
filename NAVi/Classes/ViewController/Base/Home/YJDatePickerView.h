//
//  YJDatePickerView.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/21.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJDatePickerView;
@protocol YJDatePickerDelegate <NSObject>

- (void)selectedData:(NSString *_Nullable)pageNo doc:(NADoc * _Nullable )doc;

@end

typedef void (^CompleteSelection)(NSInteger index, _Nullable id value);
@interface YJDatePickerView : UIView
@property (nonatomic, weak) _Nullable id <YJDatePickerDelegate>delegate;

@property (nonatomic, copy, nonnull) void (^completeSelection)(NSInteger index, _Nullable id value);
/**
 默认选择仅日期
 */
+ (YJDatePickerView * _Nonnull)pickDateWithCompletionHandle:(CompleteSelection _Nonnull)handler;

/**
 传入自定义数组进行选择，默认支持单栏目选择
 */
+ (YJDatePickerView * _Nonnull)pickCustomDataWithArray:(NSArray *_Nonnull)data completionHandle:(CompleteSelection _Nonnull)handler;
- (void)dissmissView;
@end

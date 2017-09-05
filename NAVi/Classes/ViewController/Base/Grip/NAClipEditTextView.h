//
//  NAClipEditTextView.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/9/5.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define COLOR_TEXT_DARK [UIColor colorWithRed:187.0/255 green:186.0/255 blue:194.0/255 alpha:1.0]
@protocol syTextViewDelegate
@required
- (void)newsTextViewString:(NSString *)textViewStr;

@end
@interface NAClipEditTextView : UITextView
@property (nonatomic, assign)NSInteger mmaxNum;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, weak) id<syTextViewDelegate> mydelegate;
-(id)initWithFrame:(CGRect)frame MaxNum:(NSInteger)num;
@end

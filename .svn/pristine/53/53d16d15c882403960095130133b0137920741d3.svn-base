//
//  NAClipEditTextView.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/9/5.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NAClipEditTextView.h"

@implementation NAClipEditTextView
@synthesize mmaxNum;
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setPlaceholder:@""];
    [self setPlaceholderColor:COLOR_TEXT_DARK];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}
-(id)initWithFrame:(CGRect)frame MaxNum:(NSInteger)num
{
    self = [super initWithFrame:frame];
    if (self)
    {
        mmaxNum = num;
        [self setPlaceholder:@""];
        [self setPlaceholderColor:COLOR_TEXT_DARK];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}
-(id)init
{
    self = [super init];
    if (self)
    {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:COLOR_TEXT_DARK];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}


- (void)textChanged:(NSNotification *)notification
{
    //    if([[self placeholder] length] == 0)
    //    {
    //        return;
    //    }
    
    [UIView animateWithDuration:0.0f animations:^{
        if([[self text] length] == 0)
        {
            [[self viewWithTag:999] setAlpha:1];
        }
        else
        {
            [[self viewWithTag:999] setAlpha:0];
        }
    }];
    //NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (self.text.length >= mmaxNum)
            {
                self.text = [self.text substringToIndex:mmaxNum];
                
            }
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (self.text.length >= mmaxNum)
        {
            self.text = [self.text substringToIndex:mmaxNum];
            
        }
    }
    
    
    
    [self.mydelegate newsTextViewString:self.text];
    
}
- (void)setText:(NSString *)text {
    NSLog(@"这个");
    [super setText:text];
    //    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if (_placeHolderLabel == nil )
        {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,7,self.bounds.size.width - 16,0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}

@end

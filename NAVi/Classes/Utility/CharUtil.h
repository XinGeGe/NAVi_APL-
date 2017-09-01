//
//  CharUtil.h
//  NAVi
//
//  Created by y fs on 15/6/26.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharUtil : NSObject
+(void)setHighlightwithTextview:(UITextView *)mytextview keyword:(NSString *)keyword;
+(NSString *)ChangetheDetailtext:(NSString *)dtext keyword:(NSString *)keyword;
+(NSString *)ChangetheTobr:(NSString *)dtext;
// delete the ruby
+(NSString *)deledateTheRT:(NSString *)rtext;
// get the right ruby str
+(NSString *)getRightRubytext:(NSString *)yuantext NORubytext:(NSString *)noRubytext;
+(BOOL)isHaveRubytext:(NSString *)mytext;
+(BOOL)isEnglishChar:(NSString *)myString;
+(NSString *)getRightUrl:(NSString *)myUrl;
+(NSString *)convHttps2Image:(NSString *)pStr;
+(void)setHighlightwithLabel:(UILabel *)myLabel keyword:(NSString *)keyword;
@end

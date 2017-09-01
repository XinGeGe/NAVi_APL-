//
//  CharUtil.m
//  NAVi
//
//  Created by y fs on 15/6/26.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "CharUtil.h"

@implementation CharUtil
+(void)setHighlightwithTextview:(UITextView *)mytextview keyword:(NSString *)keyword{
    NSMutableString *mukeyword=[NSMutableString stringWithString:keyword];
    
    CFStringTransform((CFMutableStringRef)mukeyword, NULL, kCFStringTransformFullwidthHalfwidth, true);
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:mukeyword options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *noteStr = mytextview.text;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:noteStr];
    
    [attrString
     setAttributes:@{NSFontAttributeName:mytextview.font} range:NSMakeRange(0,attrString.length)];
    for (NSTextCheckingResult* b in [regex matchesInString:noteStr options:0 range:NSMakeRange(0, [noteStr length])])
    {
        [attrString addAttribute:NSBackgroundColorAttributeName
                           value:[Util colorWithHexString:Highlightcolor]
                           range:b.range];
    }
    
    [mytextview setAttributedText:attrString];
}
+(NSString *)ChangetheDetailtext:(NSString *)dtext keyword:(NSString *)keyword{
    NSArray *keyArray=[keyword componentsSeparatedByString:@"*"];
    for (NSString *keyWord in keyArray) {
        NSMutableString *mukeyword=[NSMutableString stringWithString:keyWord];
        CFStringTransform((CFMutableStringRef)mukeyword, NULL, kCFStringTransformFullwidthHalfwidth, true);
        if ([self isEnglishChar:keyWord]) {
            
            dtext = [dtext stringByReplacingOccurrencesOfString:mukeyword withString:[NSString stringWithFormat:@"<em class='highlight'>%@</em>",mukeyword]];
            dtext = [dtext stringByReplacingOccurrencesOfString:[mukeyword lowercaseString] withString:[NSString stringWithFormat:@"<em class='highlight'>%@</em>",[mukeyword lowercaseString]]];
        }else{
            dtext = [dtext stringByReplacingOccurrencesOfString:mukeyword withString:[NSString stringWithFormat:@"<em class='highlight'>%@</em>",mukeyword]];
        }

    }
    return dtext;

}
+(BOOL)isEnglishChar:(NSString *)myString{
    NSString *regex = @"^[A-Za-z]+$";
    NSPredicate *regextmyString = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    
    return [regextmyString evaluateWithObject:myString];
    
}
+(NSString *)ChangetheTobr:(NSString *)dtext{
    NSString *strDetailbr = [dtext stringByReplacingOccurrencesOfString:@"\n" withString:[NSString stringWithFormat:@"<br>"]];
    return strDetailbr;
}
+(NSString *)deledateTheRT:(NSString *)rtext{
    NSString *regex = @"<rt>.*?</rt>|<ruby>|</ruby>|<rb>|</rb>";
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:
                                              
                                              regex options:0 error:nil];
    NSString *newstr;
    newstr  = [regularExpression stringByReplacingMatchesInString:rtext options:0 range:NSMakeRange(0, rtext.length) withTemplate:@""];
    //[rtext rep];
    
    
    return newstr;
    
}
+(NSString *)getRightRubytext:(NSString *)yuantext NORubytext:(NSString *)noRubytext{
    NSInteger i=0;
    NSInteger j=0;
    for (i=0; i<noRubytext.length; i++) {
        
        for (j=j;j<yuantext.length; j++) {
            if ([noRubytext characterAtIndex:i]==[yuantext characterAtIndex:j]) {
                j=j+1;
                break;
            }
        }
    }
    NSString *mytext=[yuantext substringWithRange:NSMakeRange(0,j)];

    return mytext;
}
+(BOOL)isHaveRubytext:(NSString *)mytext{
    NSRange range=[mytext rangeOfString:@"<ruby>" options:0];
    if (range.location==NSNotFound) {
        return NO;
    }else{
        return YES;
    }
}
+(NSString *)convHttps2Image:(NSString *)pStr{
    if ([@"https://" isEqualToString:[NASaveData getImageServerProtocol]]&&[[pStr lowercaseString] hasPrefix:@"http://"]==1){
        pStr = [pStr stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
        pStr = [pStr stringByReplacingOccurrencesOfString:@":80" withString:@""];
    }else if ([@"http://" isEqualToString:[NASaveData getImageServerProtocol]]&&[[pStr lowercaseString] hasPrefix:@"https://"]==1){
        pStr = [pStr stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"];
        pStr = [pStr stringByReplacingOccurrencesOfString:@"HTTPS://" withString:@"http://"];
    }
    return pStr;
}
+(NSString *)getRightUrl:(NSString *)myUrl{
    NSString *re80url=myUrl;
    if ([[NASaveData getImageServerProtocol]isEqualToString:@"https://"]) {
        re80url=[myUrl stringByReplacingOccurrencesOfString:@":80" withString:@""];
    }
    
    return [[NASaveData getImageServerProtocol]isEqualToString:@"https://"]?[re80url stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"]:[re80url stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"];
}

+(void)setHighlightwithLabel:(UILabel *)myLabel keyword:(NSString *)keyword{
    NSMutableString *mukeyword=[NSMutableString stringWithString:keyword];
    
    CFStringTransform((CFMutableStringRef)mukeyword, NULL, kCFStringTransformFullwidthHalfwidth, true);
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:mukeyword options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *noteStr = myLabel.text;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:noteStr];
    
    [attrString
     setAttributes:@{NSFontAttributeName:myLabel.font} range:NSMakeRange(0,attrString.length)];
    for (NSTextCheckingResult* b in [regex matchesInString:noteStr options:0 range:NSMakeRange(0, [noteStr length])])
    {
        [attrString addAttribute:NSBackgroundColorAttributeName
                           value:[Util colorWithHexString:Highlightcolor]
                           range:b.range];
    }
    
    [myLabel setAttributedText:attrString];
}

/*
 -(NSString *)convHalf2Full:(NSString  *)halfStr {
 if(halfStr == nil || halfStr.length == 0){
 return halfStr;
 }
 
 NSArray *c = [halfStr a];
 for (int i = 0; i < c.length; i++) {
 if ( (c[i] >= 0x0 && c[i] < 0x81) || (c[i] == 0xf8f0) || (c[i] >= 0xff61 && c[i] < 0xffa0) || (c[i] >= 0xf8f1 && c[i] < 0xf8f4)) {
 // 敿妏
 c[i] = (char)(c[i] + 0xFEE0);
 }
 }
 
 return new String(c);
 }
 */
@end

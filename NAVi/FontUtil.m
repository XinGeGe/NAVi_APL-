//
//  FontUtil.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/7/31.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "FontUtil.h"

@implementation FontUtil
+(UIFont *)boldSystemFontOfSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"MotoyaLMaru-W3-90ms-RKSJ-H" size:size];
    return font;
}
+(UIFont *)systemFontOfSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"MotoyaLMaru-W3-90ms-RKSJ-H" size:size];
    return font;
}
@end

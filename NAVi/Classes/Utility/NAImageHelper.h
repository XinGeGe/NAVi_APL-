//
//  NAImageHelper.h
//  NAVi
//
//  Created by y fs on 15/8/5.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAImageHelper : NSObject
@property (nonatomic,strong)NSString *whichstyle;

+ (NAImageHelper *)sharedInstance;
- (NSString *)getImageName:(NSString *)name;
- (UIColor *)getToolBarColor;
- (UIColor *)getNavTitleColor;
- (UIColor *)getPageTitleColor;
- (UIColor *)getPageDetailTitleColor;
@end

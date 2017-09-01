//
//  NAHomeDataShare.h
//  naviKomei
//
//  Created by y fs on 15/11/30.
//  Copyright © 2015年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAHomeDataShare : NSObject
@property (nonatomic,strong)NSArray *homePageArray;
+ (NAHomeDataShare *)sharedInstance;

@end

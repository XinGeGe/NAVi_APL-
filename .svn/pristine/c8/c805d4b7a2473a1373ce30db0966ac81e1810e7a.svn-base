//
//  NATagBaseClass.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/8/25.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NATagResponse;

@interface NATagBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NATagResponse *response;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

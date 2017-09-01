//
//  NATagHeader.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/8/25.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NATagHeader : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *numFound;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

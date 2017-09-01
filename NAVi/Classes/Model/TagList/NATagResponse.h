//
//  NATagResponse.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/8/25.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NATagHeader;

@interface NATagResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *doc;
@property (nonatomic, strong) NATagHeader *header;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

//
//  NAMasterData.h
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NAUsers, NAPublishers, NALayouts;

@interface NAMasterData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nAVips;
@property (nonatomic, strong) NAUsers *users;
@property (nonatomic, strong) NSString *nAViis;
@property (nonatomic, strong) NAPublishers *publishers;
@property (nonatomic, strong) NALayouts *layouts;
@property (nonatomic, strong) NSString *contentsProvider;
@property (nonatomic, strong) NSString *rssSender;
@property (nonatomic, strong) NSString *content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

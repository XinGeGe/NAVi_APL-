//
//  NALayoutPattern.h
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NALayoutPattern : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *fixFlg;
@property (nonatomic, strong) NSString *maxNewsCount;
@property (nonatomic, strong) NSString *layoutPatternIdentifier;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *horizontal;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *vertical;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

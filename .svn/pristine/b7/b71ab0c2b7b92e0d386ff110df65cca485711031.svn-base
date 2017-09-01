//
//  NAPublicationInfo.h
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NAPublishRegionInfo,NAContent;

@interface NAPublicationInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *publicationInfoIdentifier;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *dispOrder5;
@property (nonatomic, strong) NSArray *editionInfo;
@property (nonatomic, strong) NSString *dispOrder4;
@property (nonatomic, strong) NSString *dispOrder3;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NAPublishRegionInfo *publishRegionInfo;
@property (nonatomic, strong) NSString *dispOrder2;
@property (nonatomic, strong) NSString *dispOrder1;
@property (nonatomic, strong) NAContent *content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

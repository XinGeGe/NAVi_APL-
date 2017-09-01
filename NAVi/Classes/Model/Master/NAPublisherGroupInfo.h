//
//  NAPublisherGroupInfo.h
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NAPublisherGroupInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *publisherInfo;
@property (nonatomic, strong) NSString *publisherGroupInfoIdentifier;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *clipFlg;
@property (nonatomic, strong) NSString *dispOrder5;
@property (nonatomic, strong) NSString *dispOrder4;
@property (nonatomic, strong) NSString *dispOrder3;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *dispOrder2;
@property (nonatomic, strong) NSString *dispOrder1;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

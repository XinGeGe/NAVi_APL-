//
//  NAMasterBaseClass.h
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NAMasterData;

@interface NAMasterBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NAMasterData *masterData;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
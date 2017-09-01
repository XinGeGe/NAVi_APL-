//
//  NAClipBaseClass.h
//
//  Created by 晓晨 段 on 15/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NAClipResponse;

@interface NAClipBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NAClipResponse *response;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

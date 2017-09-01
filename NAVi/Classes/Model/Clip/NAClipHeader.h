//
//  NAClipHeader.h
//
//  Created by 晓晨 段 on 15/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NAClipHeader : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *numFound;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

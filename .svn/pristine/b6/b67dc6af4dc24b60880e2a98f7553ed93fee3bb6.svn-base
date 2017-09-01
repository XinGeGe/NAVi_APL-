//
//  NAUser.h
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NAUser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *publisherGroupInfoId;
@property (nonatomic, strong) NSString *useDevice;
@property (nonatomic, strong) NSString *ttsFlgP;
@property (nonatomic, strong) NSString *ttsFlgI;
@property (nonatomic, strong) NSString *userIdentifier;
@property (nonatomic, strong) NSString *index;
//add new
//@property (nonatomic, strong) NSString *releaseAreaInfo;
//@property (nonatomic, strong) NSString *publishDayInfo;
//@property (nonatomic, strong) NSString *userClass;




+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

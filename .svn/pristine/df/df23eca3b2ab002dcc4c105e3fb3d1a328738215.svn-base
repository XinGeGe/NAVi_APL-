//
//  NAUser.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAUser.h"


NSString *const kNAUserUserId = @"UserId";
NSString *const kNAUserId = @"Id";
NSString *const kNAUserIndex = @"Index";
NSString *const kNAUserTtsFlgI = @"TtsFlg_i";
NSString *const kNAUserUseDevice = @"UseDevice";
NSString *const kNAUserPublisherGroupInfoId = @"PublisherGroupInfoId";
NSString *const kNAUserTtsFlgP = @"TtsFlg_p";
//add new
//NSString *const kNAReleaseAreaInfo = @"ReleaseAreaInfo";
//NSString *const kNAPublishDayInfo = @"PublishDayInfo";
//NSString *const kNAUserClass = @"UserClass";

@interface NAUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAUser

@synthesize userId = _userId;
@synthesize userIdentifier = _userIdentifier;
@synthesize index = _index;
@synthesize ttsFlgI = _ttsFlgI;
@synthesize useDevice = _useDevice;
@synthesize publisherGroupInfoId = _publisherGroupInfoId;
@synthesize ttsFlgP = _ttsFlgP;
//add new
//@synthesize releaseAreaInfo = _releaseAreaInfo;
//@synthesize publishDayInfo = _publishDayInfo;
//@synthesize userClass = _userClass;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.userId = [self objectOrNilForKey:kNAUserUserId fromDictionary:dict];
        self.userIdentifier = [self objectOrNilForKey:kNAUserId fromDictionary:dict];
        self.index = [self objectOrNilForKey:kNAUserIndex fromDictionary:dict];
        self.ttsFlgI = [self objectOrNilForKey:kNAUserTtsFlgI fromDictionary:dict];
        self.useDevice = [self objectOrNilForKey:kNAUserUseDevice fromDictionary:dict];
        self.publisherGroupInfoId = [self objectOrNilForKey:kNAUserPublisherGroupInfoId fromDictionary:dict];
        self.ttsFlgP = [self objectOrNilForKey:kNAUserTtsFlgP fromDictionary:dict];
        //add new
//        self.releaseAreaInfo = [self objectOrNilForKey:kNAReleaseAreaInfo fromDictionary:dict];
//        self.publishDayInfo = [self objectOrNilForKey:kNAPublishDayInfo fromDictionary:dict];
//        self.userClass = [self objectOrNilForKey:kNAUserClass fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userId forKey:kNAUserUserId];
    [mutableDict setValue:self.userIdentifier forKey:kNAUserId];
    [mutableDict setValue:self.index forKey:kNAUserIndex];
    [mutableDict setValue:self.ttsFlgI forKey:kNAUserTtsFlgI];
    [mutableDict setValue:self.useDevice forKey:kNAUserUseDevice];
    [mutableDict setValue:self.publisherGroupInfoId forKey:kNAUserPublisherGroupInfoId];
    [mutableDict setValue:self.ttsFlgP forKey:kNAUserTtsFlgP];
    //add new
//    [mutableDict setValue:self.releaseAreaInfo forKey:kNAReleaseAreaInfo];
//    [mutableDict setValue:self.publishDayInfo forKey:kNAPublishDayInfo];
//    [mutableDict setValue:self.userClass forKey:kNAUserClass];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.userId = [aDecoder decodeObjectForKey:kNAUserUserId];
    self.userIdentifier = [aDecoder decodeObjectForKey:kNAUserId];
    self.index = [aDecoder decodeObjectForKey:kNAUserIndex];
    self.ttsFlgI = [aDecoder decodeObjectForKey:kNAUserTtsFlgI];
    self.useDevice = [aDecoder decodeObjectForKey:kNAUserUseDevice];
    self.publisherGroupInfoId = [aDecoder decodeObjectForKey:kNAUserPublisherGroupInfoId];
    self.ttsFlgP = [aDecoder decodeObjectForKey:kNAUserTtsFlgP];
    //add new
//    self.releaseAreaInfo = [aDecoder decodeObjectForKey:kNAReleaseAreaInfo];
//    self.publishDayInfo = [aDecoder decodeObjectForKey:kNAPublishDayInfo];
//    self.userClass = [aDecoder decodeObjectForKey:kNAUserClass];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userId forKey:kNAUserUserId];
    [aCoder encodeObject:_userIdentifier forKey:kNAUserId];
    [aCoder encodeObject:_index forKey:kNAUserIndex];
    [aCoder encodeObject:_ttsFlgI forKey:kNAUserTtsFlgI];
    [aCoder encodeObject:_useDevice forKey:kNAUserUseDevice];
    [aCoder encodeObject:_publisherGroupInfoId forKey:kNAUserPublisherGroupInfoId];
    [aCoder encodeObject:_ttsFlgP forKey:kNAUserTtsFlgP];
    //add new
//    [aCoder encodeObject:_releaseAreaInfo forKey:kNAReleaseAreaInfo];
//    [aCoder encodeObject:_publishDayInfo forKey:kNAPublishDayInfo];
//    [aCoder encodeObject:_userClass forKey:kNAUserClass];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAUser *copy = [[NAUser alloc] init];
    
    if (copy) {

        copy.userId = [self.userId copyWithZone:zone];
        copy.userIdentifier = [self.userIdentifier copyWithZone:zone];
        copy.index = [self.index copyWithZone:zone];
        copy.ttsFlgI = [self.ttsFlgI copyWithZone:zone];
        copy.useDevice = [self.useDevice copyWithZone:zone];
        copy.publisherGroupInfoId = [self.publisherGroupInfoId copyWithZone:zone];
        copy.ttsFlgP = [self.ttsFlgP copyWithZone:zone];
        //add new
//        copy.releaseAreaInfo = [self.releaseAreaInfo copyWithZone:zone];
//        copy.publishDayInfo = [self.publishDayInfo copyWithZone:zone];
//        copy.userClass = [self.userClass copyWithZone:zone];
    }
    
    return copy;
}


@end

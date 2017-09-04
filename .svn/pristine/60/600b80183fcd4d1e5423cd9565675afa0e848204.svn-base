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
NSString *const kNAReleaseAreaInfo1 = @"ReleaseAreaInfo";
NSString *const kNAPublishDayInfo1 = @"PublishDayInfo";
NSString *const kNAUserClass1 = @"UserClass";

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
@synthesize releaseAreaInfo1 = _releaseAreaInfo1;
@synthesize publishDayInfo1 = _publishDayInfo1;
@synthesize userClass1 = _userClass1;

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
        self.releaseAreaInfo1 = [self objectOrNilForKey:kNAReleaseAreaInfo1 fromDictionary:dict];
        self.publishDayInfo1 = [self objectOrNilForKey:kNAPublishDayInfo1 fromDictionary:dict];
        self.userClass1 = [self objectOrNilForKey:kNAUserClass1 fromDictionary:dict];

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
    [mutableDict setValue:self.releaseAreaInfo1 forKey:kNAReleaseAreaInfo1];
    [mutableDict setValue:self.publishDayInfo1 forKey:kNAPublishDayInfo1];
    [mutableDict setValue:self.userClass1 forKey:kNAUserClass1];

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
    self.releaseAreaInfo1 = [aDecoder decodeObjectForKey:kNAReleaseAreaInfo1];
    self.publishDayInfo1 = [aDecoder decodeObjectForKey:kNAPublishDayInfo1];
    self.userClass1 = [aDecoder decodeObjectForKey:kNAUserClass1];
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
    [aCoder encodeObject:_releaseAreaInfo1 forKey:kNAReleaseAreaInfo1];
    [aCoder encodeObject:_publishDayInfo1 forKey:kNAPublishDayInfo1];
    [aCoder encodeObject:_userClass1 forKey:kNAUserClass1];
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
        copy.releaseAreaInfo1 = [self.releaseAreaInfo1 copyWithZone:zone];
        copy.publishDayInfo1 = [self.publishDayInfo1 copyWithZone:zone];
        copy.userClass1 = [self.userClass1 copyWithZone:zone];
    }
    
    return copy;
}


@end

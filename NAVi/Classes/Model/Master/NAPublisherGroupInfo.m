//
//  NAPublisherGroupInfo.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAPublisherGroupInfo.h"
#import "NAPublisherInfo.h"


NSString *const kNAPublisherGroupInfoPublisherInfo = @"PublisherInfo";
NSString *const kNAPublisherGroupInfoId = @"Id";
NSString *const kNAPublisherGroupInfoIndex = @"Index";
NSString *const kNAPublisherGroupInfoClipFlg = @"ClipFlg";
NSString *const kNAPublisherGroupInfoDispOrder5 = @"DispOrder5";
NSString *const kNAPublisherGroupInfoDispOrder4 = @"DispOrder4";
NSString *const kNAPublisherGroupInfoDispOrder3 = @"DispOrder3";
NSString *const kNAPublisherGroupInfoName = @"Name";
NSString *const kNAPublisherGroupInfoDispOrder2 = @"DispOrder2";
NSString *const kNAPublisherGroupInfoDispOrder1 = @"DispOrder1";


@interface NAPublisherGroupInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAPublisherGroupInfo

@synthesize publisherInfo = _publisherInfo;
@synthesize publisherGroupInfoIdentifier = _publisherGroupInfoIdentifier;
@synthesize index = _index;
@synthesize clipFlg = _clipFlg;
@synthesize dispOrder5 = _dispOrder5;
@synthesize dispOrder4 = _dispOrder4;
@synthesize dispOrder3 = _dispOrder3;
@synthesize name = _name;
@synthesize dispOrder2 = _dispOrder2;
@synthesize dispOrder1 = _dispOrder1;


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
        NSObject *receivedNAPublisherInfo = [dict objectForKey:kNAPublisherGroupInfoPublisherInfo];
        NSMutableArray *parsedNAPublisherInfo = [NSMutableArray array];
        //NSMutableArray *parsedNAPublisherInfo = [NSMutableArray array];
        if ([receivedNAPublisherInfo isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedNAPublisherInfo) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedNAPublisherInfo addObject:[NAPublisherInfo modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedNAPublisherInfo isKindOfClass:[NSDictionary class]]) {
            [parsedNAPublisherInfo addObject:[NAPublisherInfo modelObjectWithDictionary:(NSDictionary *)receivedNAPublisherInfo]];
        }
        
        self.publisherInfo = [NSArray arrayWithArray:parsedNAPublisherInfo];
        self.publisherGroupInfoIdentifier = [self objectOrNilForKey:kNAPublisherGroupInfoId fromDictionary:dict];
        self.index = [self objectOrNilForKey:kNAPublisherGroupInfoIndex fromDictionary:dict];
        self.clipFlg = [self objectOrNilForKey:kNAPublisherGroupInfoClipFlg fromDictionary:dict];
        self.dispOrder5 = [self objectOrNilForKey:kNAPublisherGroupInfoDispOrder5 fromDictionary:dict];
        self.dispOrder4 = [self objectOrNilForKey:kNAPublisherGroupInfoDispOrder4 fromDictionary:dict];
        self.dispOrder3 = [self objectOrNilForKey:kNAPublisherGroupInfoDispOrder3 fromDictionary:dict];
        self.name = [self objectOrNilForKey:kNAPublisherGroupInfoName fromDictionary:dict];
        self.dispOrder2 = [self objectOrNilForKey:kNAPublisherGroupInfoDispOrder2 fromDictionary:dict];
        self.dispOrder1 = [self objectOrNilForKey:kNAPublisherGroupInfoDispOrder1 fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForPublisherInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.publisherInfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPublisherInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPublisherInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPublisherInfo] forKey:kNAPublisherGroupInfoPublisherInfo];
    [mutableDict setValue:self.publisherGroupInfoIdentifier forKey:kNAPublisherGroupInfoId];
    [mutableDict setValue:self.index forKey:kNAPublisherGroupInfoIndex];
    [mutableDict setValue:self.clipFlg forKey:kNAPublisherGroupInfoClipFlg];
    [mutableDict setValue:self.dispOrder5 forKey:kNAPublisherGroupInfoDispOrder5];
    [mutableDict setValue:self.dispOrder4 forKey:kNAPublisherGroupInfoDispOrder4];
    [mutableDict setValue:self.dispOrder3 forKey:kNAPublisherGroupInfoDispOrder3];
    [mutableDict setValue:self.name forKey:kNAPublisherGroupInfoName];
    [mutableDict setValue:self.dispOrder2 forKey:kNAPublisherGroupInfoDispOrder2];
    [mutableDict setValue:self.dispOrder1 forKey:kNAPublisherGroupInfoDispOrder1];
    
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
    
    self.publisherInfo = [aDecoder decodeObjectForKey:kNAPublisherGroupInfoPublisherInfo];
    self.publisherGroupInfoIdentifier = [aDecoder decodeObjectForKey:kNAPublisherGroupInfoId];
    self.index = [aDecoder decodeObjectForKey:kNAPublisherGroupInfoIndex];
    self.clipFlg = [aDecoder decodeObjectForKey:kNAPublisherGroupInfoClipFlg];
    self.dispOrder5 = [aDecoder decodeObjectForKey:kNAPublisherGroupInfoDispOrder5];
    self.dispOrder4 = [aDecoder decodeObjectForKey:kNAPublisherGroupInfoDispOrder4];
    self.dispOrder3 = [aDecoder decodeObjectForKey:kNAPublisherGroupInfoDispOrder3];
    self.name = [aDecoder decodeObjectForKey:kNAPublisherGroupInfoName];
    self.dispOrder2 = [aDecoder decodeObjectForKey:kNAPublisherGroupInfoDispOrder2];
    self.dispOrder1 = [aDecoder decodeObjectForKey:kNAPublisherGroupInfoDispOrder1];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_publisherInfo forKey:kNAPublisherGroupInfoPublisherInfo];
    [aCoder encodeObject:_publisherGroupInfoIdentifier forKey:kNAPublisherGroupInfoId];
    [aCoder encodeObject:_index forKey:kNAPublisherGroupInfoIndex];
    [aCoder encodeObject:_clipFlg forKey:kNAPublisherGroupInfoClipFlg];
    [aCoder encodeObject:_dispOrder5 forKey:kNAPublisherGroupInfoDispOrder5];
    [aCoder encodeObject:_dispOrder4 forKey:kNAPublisherGroupInfoDispOrder4];
    [aCoder encodeObject:_dispOrder3 forKey:kNAPublisherGroupInfoDispOrder3];
    [aCoder encodeObject:_name forKey:kNAPublisherGroupInfoName];
    [aCoder encodeObject:_dispOrder2 forKey:kNAPublisherGroupInfoDispOrder2];
    [aCoder encodeObject:_dispOrder1 forKey:kNAPublisherGroupInfoDispOrder1];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAPublisherGroupInfo *copy = [[NAPublisherGroupInfo alloc] init];
    
    if (copy) {
        
        copy.publisherInfo = [self.publisherInfo copyWithZone:zone];
        copy.publisherGroupInfoIdentifier = [self.publisherGroupInfoIdentifier copyWithZone:zone];
        copy.index = [self.index copyWithZone:zone];
        copy.clipFlg = [self.clipFlg copyWithZone:zone];
        copy.dispOrder5 = [self.dispOrder5 copyWithZone:zone];
        copy.dispOrder4 = [self.dispOrder4 copyWithZone:zone];
        copy.dispOrder3 = [self.dispOrder3 copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.dispOrder2 = [self.dispOrder2 copyWithZone:zone];
        copy.dispOrder1 = [self.dispOrder1 copyWithZone:zone];
    }
    
    return copy;
}


@end

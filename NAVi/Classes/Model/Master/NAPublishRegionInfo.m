//
//  NAPublishRegionInfo.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAPublishRegionInfo.h"


NSString *const kNAPublishRegionInfoId = @"Id";
NSString *const kNAPublishRegionInfoIndex = @"Index";
NSString *const kNAPublishRegionInfoDispOrder5 = @"DispOrder5";
NSString *const kNAPublishRegionInfoDispOrder4 = @"DispOrder4";
NSString *const kNAPublishRegionInfoDispOrder3 = @"DispOrder3";
NSString *const kNAPublishRegionInfoName = @"Name";
NSString *const kNAPublishRegionInfoDispOrder2 = @"DispOrder2";
NSString *const kNAPublishRegionInfoDispOrder1 = @"DispOrder1";


@interface NAPublishRegionInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAPublishRegionInfo

@synthesize publishRegionInfoIdentifier = _publishRegionInfoIdentifier;
@synthesize index = _index;
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
            self.publishRegionInfoIdentifier = [self objectOrNilForKey:kNAPublishRegionInfoId fromDictionary:dict];
            self.index = [self objectOrNilForKey:kNAPublishRegionInfoIndex fromDictionary:dict];
            self.dispOrder5 = [self objectOrNilForKey:kNAPublishRegionInfoDispOrder5 fromDictionary:dict];
            self.dispOrder4 = [self objectOrNilForKey:kNAPublishRegionInfoDispOrder4 fromDictionary:dict];
            self.dispOrder3 = [self objectOrNilForKey:kNAPublishRegionInfoDispOrder3 fromDictionary:dict];
            self.name = [self objectOrNilForKey:kNAPublishRegionInfoName fromDictionary:dict];
            self.dispOrder2 = [self objectOrNilForKey:kNAPublishRegionInfoDispOrder2 fromDictionary:dict];
            self.dispOrder1 = [self objectOrNilForKey:kNAPublishRegionInfoDispOrder1 fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.publishRegionInfoIdentifier forKey:kNAPublishRegionInfoId];
    [mutableDict setValue:self.index forKey:kNAPublishRegionInfoIndex];
    [mutableDict setValue:self.dispOrder5 forKey:kNAPublishRegionInfoDispOrder5];
    [mutableDict setValue:self.dispOrder4 forKey:kNAPublishRegionInfoDispOrder4];
    [mutableDict setValue:self.dispOrder3 forKey:kNAPublishRegionInfoDispOrder3];
    [mutableDict setValue:self.name forKey:kNAPublishRegionInfoName];
    [mutableDict setValue:self.dispOrder2 forKey:kNAPublishRegionInfoDispOrder2];
    [mutableDict setValue:self.dispOrder1 forKey:kNAPublishRegionInfoDispOrder1];

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

    self.publishRegionInfoIdentifier = [aDecoder decodeObjectForKey:kNAPublishRegionInfoId];
    self.index = [aDecoder decodeObjectForKey:kNAPublishRegionInfoIndex];
    self.dispOrder5 = [aDecoder decodeObjectForKey:kNAPublishRegionInfoDispOrder5];
    self.dispOrder4 = [aDecoder decodeObjectForKey:kNAPublishRegionInfoDispOrder4];
    self.dispOrder3 = [aDecoder decodeObjectForKey:kNAPublishRegionInfoDispOrder3];
    self.name = [aDecoder decodeObjectForKey:kNAPublishRegionInfoName];
    self.dispOrder2 = [aDecoder decodeObjectForKey:kNAPublishRegionInfoDispOrder2];
    self.dispOrder1 = [aDecoder decodeObjectForKey:kNAPublishRegionInfoDispOrder1];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_publishRegionInfoIdentifier forKey:kNAPublishRegionInfoId];
    [aCoder encodeObject:_index forKey:kNAPublishRegionInfoIndex];
    [aCoder encodeObject:_dispOrder5 forKey:kNAPublishRegionInfoDispOrder5];
    [aCoder encodeObject:_dispOrder4 forKey:kNAPublishRegionInfoDispOrder4];
    [aCoder encodeObject:_dispOrder3 forKey:kNAPublishRegionInfoDispOrder3];
    [aCoder encodeObject:_name forKey:kNAPublishRegionInfoName];
    [aCoder encodeObject:_dispOrder2 forKey:kNAPublishRegionInfoDispOrder2];
    [aCoder encodeObject:_dispOrder1 forKey:kNAPublishRegionInfoDispOrder1];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAPublishRegionInfo *copy = [[NAPublishRegionInfo alloc] init];
    
    if (copy) {

        copy.publishRegionInfoIdentifier = [self.publishRegionInfoIdentifier copyWithZone:zone];
        copy.index = [self.index copyWithZone:zone];
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

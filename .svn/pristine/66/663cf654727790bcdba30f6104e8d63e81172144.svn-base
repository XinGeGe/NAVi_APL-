//
//  NAEditionInfo.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAEditionInfo.h"


NSString *const kNAEditionInfoId = @"Id";
NSString *const kNAEditionInfoIndex = @"Index";
NSString *const kNAEditionInfoDispOrder5 = @"DispOrder5";
NSString *const kNAEditionInfoDispOrder4 = @"DispOrder4";
NSString *const kNAEditionInfoDispOrder3 = @"DispOrder3";
NSString *const kNAEditionInfoName = @"Name";
NSString *const kNAEditionInfoDispOrder2 = @"DispOrder2";
NSString *const kNAEditionInfoDispOrder1 = @"DispOrder1";


@interface NAEditionInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAEditionInfo

@synthesize editionInfoIdentifier = _editionInfoIdentifier;
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
            self.editionInfoIdentifier = [self objectOrNilForKey:kNAEditionInfoId fromDictionary:dict];
            self.index = [self objectOrNilForKey:kNAEditionInfoIndex fromDictionary:dict];
            self.dispOrder5 = [self objectOrNilForKey:kNAEditionInfoDispOrder5 fromDictionary:dict];
            self.dispOrder4 = [self objectOrNilForKey:kNAEditionInfoDispOrder4 fromDictionary:dict];
            self.dispOrder3 = [self objectOrNilForKey:kNAEditionInfoDispOrder3 fromDictionary:dict];
            self.name = [self objectOrNilForKey:kNAEditionInfoName fromDictionary:dict];
            self.dispOrder2 = [self objectOrNilForKey:kNAEditionInfoDispOrder2 fromDictionary:dict];
            self.dispOrder1 = [self objectOrNilForKey:kNAEditionInfoDispOrder1 fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.editionInfoIdentifier forKey:kNAEditionInfoId];
    [mutableDict setValue:self.index forKey:kNAEditionInfoIndex];
    [mutableDict setValue:self.dispOrder5 forKey:kNAEditionInfoDispOrder5];
    [mutableDict setValue:self.dispOrder4 forKey:kNAEditionInfoDispOrder4];
    [mutableDict setValue:self.dispOrder3 forKey:kNAEditionInfoDispOrder3];
    [mutableDict setValue:self.name forKey:kNAEditionInfoName];
    [mutableDict setValue:self.dispOrder2 forKey:kNAEditionInfoDispOrder2];
    [mutableDict setValue:self.dispOrder1 forKey:kNAEditionInfoDispOrder1];

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

    self.editionInfoIdentifier = [aDecoder decodeObjectForKey:kNAEditionInfoId];
    self.index = [aDecoder decodeObjectForKey:kNAEditionInfoIndex];
    self.dispOrder5 = [aDecoder decodeObjectForKey:kNAEditionInfoDispOrder5];
    self.dispOrder4 = [aDecoder decodeObjectForKey:kNAEditionInfoDispOrder4];
    self.dispOrder3 = [aDecoder decodeObjectForKey:kNAEditionInfoDispOrder3];
    self.name = [aDecoder decodeObjectForKey:kNAEditionInfoName];
    self.dispOrder2 = [aDecoder decodeObjectForKey:kNAEditionInfoDispOrder2];
    self.dispOrder1 = [aDecoder decodeObjectForKey:kNAEditionInfoDispOrder1];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_editionInfoIdentifier forKey:kNAEditionInfoId];
    [aCoder encodeObject:_index forKey:kNAEditionInfoIndex];
    [aCoder encodeObject:_dispOrder5 forKey:kNAEditionInfoDispOrder5];
    [aCoder encodeObject:_dispOrder4 forKey:kNAEditionInfoDispOrder4];
    [aCoder encodeObject:_dispOrder3 forKey:kNAEditionInfoDispOrder3];
    [aCoder encodeObject:_name forKey:kNAEditionInfoName];
    [aCoder encodeObject:_dispOrder2 forKey:kNAEditionInfoDispOrder2];
    [aCoder encodeObject:_dispOrder1 forKey:kNAEditionInfoDispOrder1];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAEditionInfo *copy = [[NAEditionInfo alloc] init];
    
    if (copy) {

        copy.editionInfoIdentifier = [self.editionInfoIdentifier copyWithZone:zone];
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

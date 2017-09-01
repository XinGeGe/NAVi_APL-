//
//  NAPublisherInfo.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAPublisherInfo.h"
#import "NAPublicationInfo.h"


NSString *const kNAPublisherInfoId = @"Id";
NSString *const kNAPublisherInfoIndex = @"Index";
NSString *const kNAPublisherInfoDispOrder5 = @"DispOrder5";
NSString *const kNAPublisherInfoDispOrder4 = @"DispOrder4";
NSString *const kNAPublisherInfoPublicationInfo = @"PublicationInfo";
NSString *const kNAPublisherInfoDispOrder3 = @"DispOrder3";
NSString *const kNAPublisherInfoName = @"Name";
NSString *const kNAPublisherInfoDispOrder2 = @"DispOrder2";
NSString *const kNAPublisherInfoDispOrder1 = @"DispOrder1";


@interface NAPublisherInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAPublisherInfo

@synthesize publisherInfoIdentifier = _publisherInfoIdentifier;
@synthesize index = _index;
@synthesize dispOrder5 = _dispOrder5;
@synthesize dispOrder4 = _dispOrder4;
@synthesize publicationInfo = _publicationInfo;
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
            self.publisherInfoIdentifier = [self objectOrNilForKey:kNAPublisherInfoId fromDictionary:dict];
            self.index = [self objectOrNilForKey:kNAPublisherInfoIndex fromDictionary:dict];
            self.dispOrder5 = [self objectOrNilForKey:kNAPublisherInfoDispOrder5 fromDictionary:dict];
            self.dispOrder4 = [self objectOrNilForKey:kNAPublisherInfoDispOrder4 fromDictionary:dict];
    NSObject *receivedNAPublicationInfo = [dict objectForKey:kNAPublisherInfoPublicationInfo];
    NSMutableArray *parsedNAPublicationInfo = [NSMutableArray array];
    if ([receivedNAPublicationInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNAPublicationInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNAPublicationInfo addObject:[NAPublicationInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNAPublicationInfo isKindOfClass:[NSDictionary class]]) {
       [parsedNAPublicationInfo addObject:[NAPublicationInfo modelObjectWithDictionary:(NSDictionary *)receivedNAPublicationInfo]];
    }

    self.publicationInfo = [NSArray arrayWithArray:parsedNAPublicationInfo];
            self.dispOrder3 = [self objectOrNilForKey:kNAPublisherInfoDispOrder3 fromDictionary:dict];
            self.name = [self objectOrNilForKey:kNAPublisherInfoName fromDictionary:dict];
            self.dispOrder2 = [self objectOrNilForKey:kNAPublisherInfoDispOrder2 fromDictionary:dict];
            self.dispOrder1 = [self objectOrNilForKey:kNAPublisherInfoDispOrder1 fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.publisherInfoIdentifier forKey:kNAPublisherInfoId];
    [mutableDict setValue:self.index forKey:kNAPublisherInfoIndex];
    [mutableDict setValue:self.dispOrder5 forKey:kNAPublisherInfoDispOrder5];
    [mutableDict setValue:self.dispOrder4 forKey:kNAPublisherInfoDispOrder4];
    NSMutableArray *tempArrayForPublicationInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.publicationInfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPublicationInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPublicationInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPublicationInfo] forKey:kNAPublisherInfoPublicationInfo];
    [mutableDict setValue:self.dispOrder3 forKey:kNAPublisherInfoDispOrder3];
    [mutableDict setValue:self.name forKey:kNAPublisherInfoName];
    [mutableDict setValue:self.dispOrder2 forKey:kNAPublisherInfoDispOrder2];
    [mutableDict setValue:self.dispOrder1 forKey:kNAPublisherInfoDispOrder1];

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

    self.publisherInfoIdentifier = [aDecoder decodeObjectForKey:kNAPublisherInfoId];
    self.index = [aDecoder decodeObjectForKey:kNAPublisherInfoIndex];
    self.dispOrder5 = [aDecoder decodeObjectForKey:kNAPublisherInfoDispOrder5];
    self.dispOrder4 = [aDecoder decodeObjectForKey:kNAPublisherInfoDispOrder4];
    self.publicationInfo = [aDecoder decodeObjectForKey:kNAPublisherInfoPublicationInfo];
    self.dispOrder3 = [aDecoder decodeObjectForKey:kNAPublisherInfoDispOrder3];
    self.name = [aDecoder decodeObjectForKey:kNAPublisherInfoName];
    self.dispOrder2 = [aDecoder decodeObjectForKey:kNAPublisherInfoDispOrder2];
    self.dispOrder1 = [aDecoder decodeObjectForKey:kNAPublisherInfoDispOrder1];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_publisherInfoIdentifier forKey:kNAPublisherInfoId];
    [aCoder encodeObject:_index forKey:kNAPublisherInfoIndex];
    [aCoder encodeObject:_dispOrder5 forKey:kNAPublisherInfoDispOrder5];
    [aCoder encodeObject:_dispOrder4 forKey:kNAPublisherInfoDispOrder4];
    [aCoder encodeObject:_publicationInfo forKey:kNAPublisherInfoPublicationInfo];
    [aCoder encodeObject:_dispOrder3 forKey:kNAPublisherInfoDispOrder3];
    [aCoder encodeObject:_name forKey:kNAPublisherInfoName];
    [aCoder encodeObject:_dispOrder2 forKey:kNAPublisherInfoDispOrder2];
    [aCoder encodeObject:_dispOrder1 forKey:kNAPublisherInfoDispOrder1];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAPublisherInfo *copy = [[NAPublisherInfo alloc] init];
    
    if (copy) {

        copy.publisherInfoIdentifier = [self.publisherInfoIdentifier copyWithZone:zone];
        copy.index = [self.index copyWithZone:zone];
        copy.dispOrder5 = [self.dispOrder5 copyWithZone:zone];
        copy.dispOrder4 = [self.dispOrder4 copyWithZone:zone];
        copy.publicationInfo = [self.publicationInfo copyWithZone:zone];
        copy.dispOrder3 = [self.dispOrder3 copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.dispOrder2 = [self.dispOrder2 copyWithZone:zone];
        copy.dispOrder1 = [self.dispOrder1 copyWithZone:zone];
    }
    
    return copy;
}


@end

//
//  NAPublicationInfo.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAPublicationInfo.h"
#import "NAEditionInfo.h"
#import "NAPublishRegionInfo.h"
#import "NAContent.h"

NSString *const kNAPublicationInfoId = @"Id";
NSString *const kNAPublicationInfoIndex = @"Index";
NSString *const kNAPublicationInfoDispOrder5 = @"DispOrder5";
NSString *const kNAPublicationInfoEditionInfo = @"EditionInfo";
NSString *const kNAPublicationInfoDispOrder4 = @"DispOrder4";
NSString *const kNAPublicationInfoDispOrder3 = @"DispOrder3";
NSString *const kNAPublicationInfoName = @"Name";
NSString *const kNAPublicationInfoPublishRegionInfo = @"PublishRegionInfo";
NSString *const kNAPublicationInfoDispOrder2 = @"DispOrder2";
NSString *const kNAPublicationInfoDispOrder1 = @"DispOrder1";

NSString *const kNAMasterDataContent = @"Content";


@interface NAPublicationInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAPublicationInfo

@synthesize publicationInfoIdentifier = _publicationInfoIdentifier;
@synthesize index = _index;
@synthesize dispOrder5 = _dispOrder5;
@synthesize editionInfo = _editionInfo;
@synthesize dispOrder4 = _dispOrder4;
@synthesize dispOrder3 = _dispOrder3;
@synthesize name = _name;
@synthesize publishRegionInfo = _publishRegionInfo;
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
            self.publicationInfoIdentifier = [self objectOrNilForKey:kNAPublicationInfoId fromDictionary:dict];
            self.index = [self objectOrNilForKey:kNAPublicationInfoIndex fromDictionary:dict];
            self.dispOrder5 = [self objectOrNilForKey:kNAPublicationInfoDispOrder5 fromDictionary:dict];
    NSObject *receivedNAEditionInfo = [dict objectForKey:kNAPublicationInfoEditionInfo];
    NSMutableArray *parsedNAEditionInfo = [NSMutableArray array];
    if ([receivedNAEditionInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNAEditionInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNAEditionInfo addObject:[NAEditionInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNAEditionInfo isKindOfClass:[NSDictionary class]]) {
       [parsedNAEditionInfo addObject:[NAEditionInfo modelObjectWithDictionary:(NSDictionary *)receivedNAEditionInfo]];
    }

    self.editionInfo = [NSArray arrayWithArray:parsedNAEditionInfo];
            self.dispOrder4 = [self objectOrNilForKey:kNAPublicationInfoDispOrder4 fromDictionary:dict];
            self.dispOrder3 = [self objectOrNilForKey:kNAPublicationInfoDispOrder3 fromDictionary:dict];
            self.name = [self objectOrNilForKey:kNAPublicationInfoName fromDictionary:dict];
            self.publishRegionInfo = [NAPublishRegionInfo modelObjectWithDictionary:[dict objectForKey:kNAPublicationInfoPublishRegionInfo]];
            self.dispOrder2 = [self objectOrNilForKey:kNAPublicationInfoDispOrder2 fromDictionary:dict];
            self.dispOrder1 = [self objectOrNilForKey:kNAPublicationInfoDispOrder1 fromDictionary:dict];

    }
    
    self.content = [NAContent modelObjectWithDictionary:[dict objectForKey:kNAMasterDataContent]];
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.publicationInfoIdentifier forKey:kNAPublicationInfoId];
    [mutableDict setValue:self.index forKey:kNAPublicationInfoIndex];
    [mutableDict setValue:self.dispOrder5 forKey:kNAPublicationInfoDispOrder5];
    NSMutableArray *tempArrayForEditionInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.editionInfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForEditionInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForEditionInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForEditionInfo] forKey:kNAPublicationInfoEditionInfo];
    [mutableDict setValue:self.dispOrder4 forKey:kNAPublicationInfoDispOrder4];
    [mutableDict setValue:self.dispOrder3 forKey:kNAPublicationInfoDispOrder3];
    [mutableDict setValue:self.name forKey:kNAPublicationInfoName];
    [mutableDict setValue:[self.publishRegionInfo dictionaryRepresentation] forKey:kNAPublicationInfoPublishRegionInfo];
    [mutableDict setValue:self.dispOrder2 forKey:kNAPublicationInfoDispOrder2];
    [mutableDict setValue:self.dispOrder1 forKey:kNAPublicationInfoDispOrder1];

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

    self.publicationInfoIdentifier = [aDecoder decodeObjectForKey:kNAPublicationInfoId];
    self.index = [aDecoder decodeObjectForKey:kNAPublicationInfoIndex];
    self.dispOrder5 = [aDecoder decodeObjectForKey:kNAPublicationInfoDispOrder5];
    self.editionInfo = [aDecoder decodeObjectForKey:kNAPublicationInfoEditionInfo];
    self.dispOrder4 = [aDecoder decodeObjectForKey:kNAPublicationInfoDispOrder4];
    self.dispOrder3 = [aDecoder decodeObjectForKey:kNAPublicationInfoDispOrder3];
    self.name = [aDecoder decodeObjectForKey:kNAPublicationInfoName];
    self.publishRegionInfo = [aDecoder decodeObjectForKey:kNAPublicationInfoPublishRegionInfo];
    self.dispOrder2 = [aDecoder decodeObjectForKey:kNAPublicationInfoDispOrder2];
    self.dispOrder1 = [aDecoder decodeObjectForKey:kNAPublicationInfoDispOrder1];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_publicationInfoIdentifier forKey:kNAPublicationInfoId];
    [aCoder encodeObject:_index forKey:kNAPublicationInfoIndex];
    [aCoder encodeObject:_dispOrder5 forKey:kNAPublicationInfoDispOrder5];
    [aCoder encodeObject:_editionInfo forKey:kNAPublicationInfoEditionInfo];
    [aCoder encodeObject:_dispOrder4 forKey:kNAPublicationInfoDispOrder4];
    [aCoder encodeObject:_dispOrder3 forKey:kNAPublicationInfoDispOrder3];
    [aCoder encodeObject:_name forKey:kNAPublicationInfoName];
    [aCoder encodeObject:_publishRegionInfo forKey:kNAPublicationInfoPublishRegionInfo];
    [aCoder encodeObject:_dispOrder2 forKey:kNAPublicationInfoDispOrder2];
    [aCoder encodeObject:_dispOrder1 forKey:kNAPublicationInfoDispOrder1];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAPublicationInfo *copy = [[NAPublicationInfo alloc] init];
    
    if (copy) {

        copy.publicationInfoIdentifier = [self.publicationInfoIdentifier copyWithZone:zone];
        copy.index = [self.index copyWithZone:zone];
        copy.dispOrder5 = [self.dispOrder5 copyWithZone:zone];
        copy.editionInfo = [self.editionInfo copyWithZone:zone];
        copy.dispOrder4 = [self.dispOrder4 copyWithZone:zone];
        copy.dispOrder3 = [self.dispOrder3 copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.publishRegionInfo = [self.publishRegionInfo copyWithZone:zone];
        copy.dispOrder2 = [self.dispOrder2 copyWithZone:zone];
        copy.dispOrder1 = [self.dispOrder1 copyWithZone:zone];
    }
    
    return copy;
}


@end

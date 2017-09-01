//
//  NAMasterData.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAMasterData.h"
#import "NAUsers.h"
#import "NAPublishers.h"
#import "NALayouts.h"
#import "NAContent.h"


NSString *const kNAMasterDataNAVips = @"NAVips";
NSString *const kNAMasterDataUsers = @"Users";
NSString *const kNAMasterDataNAViis = @"NAViis";
NSString *const kNAMasterDataPublishers = @"Publishers";
NSString *const kNAMasterDataLayouts = @"Layouts";
NSString *const kNAMasterDataContentsProvider = @"ContentsProvider";
NSString *const kNAMasterDataRssSender = @"RssSender";



@interface NAMasterData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAMasterData

@synthesize nAVips = _nAVips;
@synthesize users = _users;
@synthesize nAViis = _nAViis;
@synthesize publishers = _publishers;
@synthesize layouts = _layouts;
@synthesize contentsProvider = _contentsProvider;
@synthesize rssSender = _rssSender;


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
            self.nAVips = [self objectOrNilForKey:kNAMasterDataNAVips fromDictionary:dict];
            self.users = [NAUsers modelObjectWithDictionary:[dict objectForKey:kNAMasterDataUsers]];
            self.nAViis = [self objectOrNilForKey:kNAMasterDataNAViis fromDictionary:dict];
            self.publishers = [NAPublishers modelObjectWithDictionary:[dict objectForKey:kNAMasterDataPublishers]];
            self.layouts = [NALayouts modelObjectWithDictionary:[dict objectForKey:kNAMasterDataLayouts]];
            self.contentsProvider = [self objectOrNilForKey:kNAMasterDataContentsProvider fromDictionary:dict];
            self.rssSender = [self objectOrNilForKey:kNAMasterDataRssSender fromDictionary:dict];
            

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nAVips forKey:kNAMasterDataNAVips];
    [mutableDict setValue:[self.users dictionaryRepresentation] forKey:kNAMasterDataUsers];
    [mutableDict setValue:self.nAViis forKey:kNAMasterDataNAViis];
    [mutableDict setValue:[self.publishers dictionaryRepresentation] forKey:kNAMasterDataPublishers];
    [mutableDict setValue:[self.layouts dictionaryRepresentation] forKey:kNAMasterDataLayouts];
    [mutableDict setValue:self.contentsProvider forKey:kNAMasterDataContentsProvider];
    [mutableDict setValue:self.rssSender forKey:kNAMasterDataRssSender];

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

    self.nAVips = [aDecoder decodeObjectForKey:kNAMasterDataNAVips];
    self.users = [aDecoder decodeObjectForKey:kNAMasterDataUsers];
    self.nAViis = [aDecoder decodeObjectForKey:kNAMasterDataNAViis];
    self.publishers = [aDecoder decodeObjectForKey:kNAMasterDataPublishers];
    self.layouts = [aDecoder decodeObjectForKey:kNAMasterDataLayouts];
    self.contentsProvider = [aDecoder decodeObjectForKey:kNAMasterDataContentsProvider];
    self.rssSender = [aDecoder decodeObjectForKey:kNAMasterDataRssSender];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nAVips forKey:kNAMasterDataNAVips];
    [aCoder encodeObject:_users forKey:kNAMasterDataUsers];
    [aCoder encodeObject:_nAViis forKey:kNAMasterDataNAViis];
    [aCoder encodeObject:_publishers forKey:kNAMasterDataPublishers];
    [aCoder encodeObject:_layouts forKey:kNAMasterDataLayouts];
    [aCoder encodeObject:_contentsProvider forKey:kNAMasterDataContentsProvider];
    [aCoder encodeObject:_rssSender forKey:kNAMasterDataRssSender];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAMasterData *copy = [[NAMasterData alloc] init];
    
    if (copy) {

        copy.nAVips = [self.nAVips copyWithZone:zone];
        copy.users = [self.users copyWithZone:zone];
        copy.nAViis = [self.nAViis copyWithZone:zone];
        copy.publishers = [self.publishers copyWithZone:zone];
        copy.layouts = [self.layouts copyWithZone:zone];
        copy.contentsProvider = [self.contentsProvider copyWithZone:zone];
        copy.rssSender = [self.rssSender copyWithZone:zone];
    }
    
    return copy;
}


@end

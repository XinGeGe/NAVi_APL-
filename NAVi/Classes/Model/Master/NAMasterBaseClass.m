//
//  NAMasterBaseClass.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAMasterBaseClass.h"
#import "NAMasterData.h"


NSString *const kNAMasterBaseClassMasterData = @"MasterData";


@interface NAMasterBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAMasterBaseClass

@synthesize masterData = _masterData;


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
            self.masterData = [NAMasterData modelObjectWithDictionary:[dict objectForKey:kNAMasterBaseClassMasterData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.masterData dictionaryRepresentation] forKey:kNAMasterBaseClassMasterData];

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

    self.masterData = [aDecoder decodeObjectForKey:kNAMasterBaseClassMasterData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_masterData forKey:kNAMasterBaseClassMasterData];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAMasterBaseClass *copy = [[NAMasterBaseClass alloc] init];
    
    if (copy) {

        copy.masterData = [self.masterData copyWithZone:zone];
    }
    
    return copy;
}


@end

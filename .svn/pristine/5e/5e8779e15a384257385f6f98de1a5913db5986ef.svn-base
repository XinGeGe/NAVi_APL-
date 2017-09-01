//
//  NAClipBaseClass.m
//
//  Created by 晓晨 段 on 15/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAClipBaseClass.h"
#import "NAClipResponse.h"


NSString *const kNAClipBaseClassResponse = @"response";


@interface NAClipBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAClipBaseClass

@synthesize response = _response;


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
            self.response = [NAClipResponse modelObjectWithDictionary:[dict objectForKey:kNAClipBaseClassResponse]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.response dictionaryRepresentation] forKey:kNAClipBaseClassResponse];

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

    self.response = [aDecoder decodeObjectForKey:kNAClipBaseClassResponse];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_response forKey:kNAClipBaseClassResponse];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAClipBaseClass *copy = [[NAClipBaseClass alloc] init];
    
    if (copy) {

        copy.response = [self.response copyWithZone:zone];
    }
    
    return copy;
}


@end

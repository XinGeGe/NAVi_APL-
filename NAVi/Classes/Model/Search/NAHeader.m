//
//  NAHeader.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAHeader.h"


NSString *const kNAHeaderNumFound = @"numFound";


@interface NAHeader ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAHeader

@synthesize numFound = _numFound;


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
            self.numFound = [self objectOrNilForKey:kNAHeaderNumFound fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.numFound forKey:kNAHeaderNumFound];

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

    self.numFound = [aDecoder decodeObjectForKey:kNAHeaderNumFound];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_numFound forKey:kNAHeaderNumFound];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAHeader *copy = [[NAHeader alloc] init];
    
    if (copy) {

        copy.numFound = [self.numFound copyWithZone:zone];
    }
    
    return copy;
}


@end

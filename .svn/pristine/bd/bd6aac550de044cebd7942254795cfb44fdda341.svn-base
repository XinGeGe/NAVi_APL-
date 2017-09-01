//
//  NATagBaseClass.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/8/25.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NATagBaseClass.h"

#import "NATagResponse.h"

NSString *const kNATagBaseClassResponse = @"response";

@interface NATagBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NATagBaseClass

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
        self.response = [NATagResponse modelObjectWithDictionary:[dict objectForKey:kNATagBaseClassResponse]];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.response dictionaryRepresentation] forKey:kNATagBaseClassResponse];
    
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
    
    self.response = [aDecoder decodeObjectForKey:kNATagBaseClassResponse];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_response forKey:kNATagBaseClassResponse];
}

- (id)copyWithZone:(NSZone *)zone
{
    NATagBaseClass *copy = [[NATagBaseClass alloc] init];
    
    if (copy) {
        
        copy.response = [self.response copyWithZone:zone];
    }
    
    return copy;
}


@end

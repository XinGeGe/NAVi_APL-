//
//  NATag.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/8/25.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NATag.h"

NSString *const kNATagid = @"Tagid";
NSString *const kNATagName = @"TagName";

@interface NATag ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NATag

@synthesize tagid = _tagid;
@synthesize tagName = _tagName;


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
        
        self.tagid = [self objectOrNilForKey:kNATagid fromDictionary:dict];
        self.tagName = [self objectOrNilForKey:kNATagName fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tagName forKey:kNATagName];
    [mutableDict setValue:self.tagid forKey:kNATagid];
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
    return [object isKindOfClass:[NSString class]] ? object : @"";
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.tagid = [aDecoder decodeObjectForKey:kNATagid];
    self.tagName = [aDecoder decodeObjectForKey:kNATagName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_tagid forKey:kNATagid];
    [aCoder encodeObject:_tagName forKey:kNATagName];
}

- (id)copyWithZone:(NSZone *)zone
{
    NATag *copy = [[NATag alloc] init];
    
    if (copy) {
        copy.tagid = [self.tagid copyWithZone:zone];
        copy.tagName = [self.tagName copyWithZone:zone];
    }
    
    return copy;
}

@end

//
//  NALayoutPattern.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NALayoutPattern.h"


NSString *const kNALayoutPatternFixFlg = @"FixFlg";
NSString *const kNALayoutPatternMaxNewsCount = @"MaxNewsCount";
NSString *const kNALayoutPatternId = @"Id";
NSString *const kNALayoutPatternIndex = @"Index";
NSString *const kNALayoutPatternHorizontal = @"Horizontal";
NSString *const kNALayoutPatternName = @"Name";
NSString *const kNALayoutPatternVertical = @"Vertical";


@interface NALayoutPattern ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NALayoutPattern

@synthesize fixFlg = _fixFlg;
@synthesize maxNewsCount = _maxNewsCount;
@synthesize layoutPatternIdentifier = _layoutPatternIdentifier;
@synthesize index = _index;
@synthesize horizontal = _horizontal;
@synthesize name = _name;
@synthesize vertical = _vertical;


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
            self.fixFlg = [self objectOrNilForKey:kNALayoutPatternFixFlg fromDictionary:dict];
            self.maxNewsCount = [self objectOrNilForKey:kNALayoutPatternMaxNewsCount fromDictionary:dict];
            self.layoutPatternIdentifier = [self objectOrNilForKey:kNALayoutPatternId fromDictionary:dict];
            self.index = [self objectOrNilForKey:kNALayoutPatternIndex fromDictionary:dict];
            self.horizontal = [self objectOrNilForKey:kNALayoutPatternHorizontal fromDictionary:dict];
            self.name = [self objectOrNilForKey:kNALayoutPatternName fromDictionary:dict];
            self.vertical = [self objectOrNilForKey:kNALayoutPatternVertical fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.fixFlg forKey:kNALayoutPatternFixFlg];
    [mutableDict setValue:self.maxNewsCount forKey:kNALayoutPatternMaxNewsCount];
    [mutableDict setValue:self.layoutPatternIdentifier forKey:kNALayoutPatternId];
    [mutableDict setValue:self.index forKey:kNALayoutPatternIndex];
    [mutableDict setValue:self.horizontal forKey:kNALayoutPatternHorizontal];
    [mutableDict setValue:self.name forKey:kNALayoutPatternName];
    [mutableDict setValue:self.vertical forKey:kNALayoutPatternVertical];

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

    self.fixFlg = [aDecoder decodeObjectForKey:kNALayoutPatternFixFlg];
    self.maxNewsCount = [aDecoder decodeObjectForKey:kNALayoutPatternMaxNewsCount];
    self.layoutPatternIdentifier = [aDecoder decodeObjectForKey:kNALayoutPatternId];
    self.index = [aDecoder decodeObjectForKey:kNALayoutPatternIndex];
    self.horizontal = [aDecoder decodeObjectForKey:kNALayoutPatternHorizontal];
    self.name = [aDecoder decodeObjectForKey:kNALayoutPatternName];
    self.vertical = [aDecoder decodeObjectForKey:kNALayoutPatternVertical];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_fixFlg forKey:kNALayoutPatternFixFlg];
    [aCoder encodeObject:_maxNewsCount forKey:kNALayoutPatternMaxNewsCount];
    [aCoder encodeObject:_layoutPatternIdentifier forKey:kNALayoutPatternId];
    [aCoder encodeObject:_index forKey:kNALayoutPatternIndex];
    [aCoder encodeObject:_horizontal forKey:kNALayoutPatternHorizontal];
    [aCoder encodeObject:_name forKey:kNALayoutPatternName];
    [aCoder encodeObject:_vertical forKey:kNALayoutPatternVertical];
}

- (id)copyWithZone:(NSZone *)zone
{
    NALayoutPattern *copy = [[NALayoutPattern alloc] init];
    
    if (copy) {

        copy.fixFlg = [self.fixFlg copyWithZone:zone];
        copy.maxNewsCount = [self.maxNewsCount copyWithZone:zone];
        copy.layoutPatternIdentifier = [self.layoutPatternIdentifier copyWithZone:zone];
        copy.index = [self.index copyWithZone:zone];
        copy.horizontal = [self.horizontal copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.vertical = [self.vertical copyWithZone:zone];
    }
    
    return copy;
}


@end

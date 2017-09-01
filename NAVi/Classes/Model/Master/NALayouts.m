//
//  NALayouts.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NALayouts.h"
#import "NALayoutPattern.h"


NSString *const kNALayoutsLayoutPattern = @"LayoutPattern";


@interface NALayouts ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NALayouts

@synthesize layoutPattern = _layoutPattern;


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
    NSObject *receivedNALayoutPattern = [dict objectForKey:kNALayoutsLayoutPattern];
    NSMutableArray *parsedNALayoutPattern = [NSMutableArray array];
    if ([receivedNALayoutPattern isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNALayoutPattern) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNALayoutPattern addObject:[NALayoutPattern modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNALayoutPattern isKindOfClass:[NSDictionary class]]) {
       [parsedNALayoutPattern addObject:[NALayoutPattern modelObjectWithDictionary:(NSDictionary *)receivedNALayoutPattern]];
    }

    self.layoutPattern = [NSArray arrayWithArray:parsedNALayoutPattern];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForLayoutPattern = [NSMutableArray array];
    for (NSObject *subArrayObject in self.layoutPattern) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForLayoutPattern addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForLayoutPattern addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForLayoutPattern] forKey:kNALayoutsLayoutPattern];

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

    self.layoutPattern = [aDecoder decodeObjectForKey:kNALayoutsLayoutPattern];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_layoutPattern forKey:kNALayoutsLayoutPattern];
}

- (id)copyWithZone:(NSZone *)zone
{
    NALayouts *copy = [[NALayouts alloc] init];
    
    if (copy) {

        copy.layoutPattern = [self.layoutPattern copyWithZone:zone];
    }
    
    return copy;
}


@end

//
//  NAResponse.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAResponse.h"
#import "NADoc.h"
#import "NAHeader.h"


NSString *const kNAResponseStatus = @"status";
NSString *const kNAResponseMessage = @"message";
NSString *const kNAResponseDoc = @"doc";
NSString *const kNAResponseData = @"data";
NSString *const kNAResponseHeader = @"header";


@interface NAResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAResponse

@synthesize status = _status;
@synthesize message = _message;
@synthesize doc = _doc;
@synthesize data = _data;
@synthesize header = _header;


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
            self.status = [self objectOrNilForKey:kNAResponseStatus fromDictionary:dict];
            self.message = [self objectOrNilForKey:kNAResponseMessage fromDictionary:dict];
    NSObject *receivedNADoc = [dict objectForKey:kNAResponseDoc];
    NSMutableArray *parsedNADoc = [NSMutableArray array];
    if ([receivedNADoc isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNADoc) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNADoc addObject:[NADoc modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNADoc isKindOfClass:[NSDictionary class]]) {
       [parsedNADoc addObject:[NADoc modelObjectWithDictionary:(NSDictionary *)receivedNADoc]];
    }

    self.doc = [NSArray arrayWithArray:parsedNADoc];
            self.data = [self objectOrNilForKey:kNAResponseData fromDictionary:dict];
            self.header = [NAHeader modelObjectWithDictionary:[dict objectForKey:kNAResponseHeader]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kNAResponseStatus];
    [mutableDict setValue:self.message forKey:kNAResponseMessage];
    NSMutableArray *tempArrayForDoc = [NSMutableArray array];
    for (NSObject *subArrayObject in self.doc) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDoc addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDoc addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDoc] forKey:kNAResponseDoc];
    [mutableDict setValue:self.data forKey:kNAResponseData];
    [mutableDict setValue:[self.header dictionaryRepresentation] forKey:kNAResponseHeader];

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

    self.status = [aDecoder decodeObjectForKey:kNAResponseStatus];
    self.message = [aDecoder decodeObjectForKey:kNAResponseMessage];
    self.doc = [aDecoder decodeObjectForKey:kNAResponseDoc];
    self.data = [aDecoder decodeObjectForKey:kNAResponseData];
    self.header = [aDecoder decodeObjectForKey:kNAResponseHeader];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kNAResponseStatus];
    [aCoder encodeObject:_message forKey:kNAResponseMessage];
    [aCoder encodeObject:_doc forKey:kNAResponseDoc];
    [aCoder encodeObject:_data forKey:kNAResponseData];
    [aCoder encodeObject:_header forKey:kNAResponseHeader];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAResponse *copy = [[NAResponse alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.message = [self.message copyWithZone:zone];
        copy.doc = [self.doc copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.header = [self.header copyWithZone:zone];
    }
    
    return copy;
}


@end

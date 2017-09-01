//
//  NAClipResponse.m
//
//  Created by 晓晨 段 on 15/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAClipResponse.h"
#import "NAClipDoc.h"
#import "NAClipHeader.h"


NSString *const kNAClipResponseStatus = @"status";
NSString *const kNAClipResponseMessage = @"message";
NSString *const kNAClipResponseDoc = @"doc";
NSString *const kNAClipResponseHeader = @"header";


@interface NAClipResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAClipResponse

@synthesize status = _status;
@synthesize message = _message;
@synthesize doc = _doc;
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
        self.status = [self objectOrNilForKey:kNAClipResponseStatus fromDictionary:dict];
        self.message = [self objectOrNilForKey:kNAClipResponseMessage fromDictionary:dict];
        NSObject *receivedNAClipDoc = [dict objectForKey:kNAClipResponseDoc];
        NSMutableArray *parsedNAClipDoc = [NSMutableArray array];
        if ([receivedNAClipDoc isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedNAClipDoc) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedNAClipDoc addObject:[NAClipDoc modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedNAClipDoc isKindOfClass:[NSDictionary class]]) {
            [parsedNAClipDoc addObject:[NAClipDoc modelObjectWithDictionary:(NSDictionary *)receivedNAClipDoc]];
        }

        self.doc = [NSArray arrayWithArray:parsedNAClipDoc];
        self.header = [NAClipHeader modelObjectWithDictionary:[dict objectForKey:kNAClipResponseHeader]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kNAClipResponseStatus];
    [mutableDict setValue:self.message forKey:kNAClipResponseMessage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDoc] forKey:kNAClipResponseDoc];
    [mutableDict setValue:[self.header dictionaryRepresentation] forKey:kNAClipResponseHeader];

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

    self.status = [aDecoder decodeObjectForKey:kNAClipResponseStatus];
    self.message = [aDecoder decodeObjectForKey:kNAClipResponseMessage];
    self.doc = [aDecoder decodeObjectForKey:kNAClipResponseDoc];
    self.header = [aDecoder decodeObjectForKey:kNAClipResponseHeader];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kNAClipResponseStatus];
    [aCoder encodeObject:_message forKey:kNAClipResponseMessage];
    [aCoder encodeObject:_doc forKey:kNAClipResponseDoc];
    [aCoder encodeObject:_header forKey:kNAClipResponseHeader];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAClipResponse *copy = [[NAClipResponse alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.message = [self.message copyWithZone:zone];
        copy.doc = [self.doc copyWithZone:zone];
        copy.header = [self.header copyWithZone:zone];
    }
    
    return copy;
}


@end

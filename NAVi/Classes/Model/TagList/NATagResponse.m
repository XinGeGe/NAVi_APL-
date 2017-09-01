//
//  NATagResponse.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/8/25.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NATagResponse.h"

#import "NATagHeader.h"
#import "NATagDoc.h"

NSString *const kNATagResponseStatus = @"status";
NSString *const kNATagResponseMessage = @"message";
NSString *const kNATagResponseDoc = @"doc";
NSString *const kNATagResponseHeader = @"header";


@interface NATagResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NATagResponse

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
        self.status = [self objectOrNilForKey:kNATagResponseStatus fromDictionary:dict];
        self.message = [self objectOrNilForKey:kNATagResponseMessage fromDictionary:dict];
        NSObject *receivedNAClipDoc = [dict objectForKey:kNATagResponseDoc];
        NSMutableArray *parsedNAClipDoc = [NSMutableArray array];
        if ([receivedNAClipDoc isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedNAClipDoc) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedNAClipDoc addObject:[NATagDoc modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedNAClipDoc isKindOfClass:[NSDictionary class]]) {
            [parsedNAClipDoc addObject:[NATagDoc modelObjectWithDictionary:(NSDictionary *)receivedNAClipDoc]];
        }
        
        self.doc = [NSArray arrayWithArray:parsedNAClipDoc];
//        self.doc = [NATagDoc modelObjectWithDictionary:[dict objectForKey:kNATagResponseDoc]];
        self.header = [NATagHeader modelObjectWithDictionary:[dict objectForKey:kNATagResponseHeader]];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kNATagResponseStatus];
    [mutableDict setValue:self.message forKey:kNATagResponseMessage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDoc] forKey:kNATagResponseDoc];
//    [mutableDict setValue:[self.doc dictionaryRepresentation] forKey:kNATagResponseDoc];
    [mutableDict setValue:[self.header dictionaryRepresentation] forKey:kNATagResponseHeader];
    
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
    
    self.status = [aDecoder decodeObjectForKey:kNATagResponseStatus];
    self.message = [aDecoder decodeObjectForKey:kNATagResponseMessage];
    self.doc = [aDecoder decodeObjectForKey:kNATagResponseDoc];
    self.header = [aDecoder decodeObjectForKey:kNATagResponseHeader];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_status forKey:kNATagResponseStatus];
    [aCoder encodeObject:_message forKey:kNATagResponseMessage];
    [aCoder encodeObject:_doc forKey:kNATagResponseDoc];
    [aCoder encodeObject:_header forKey:kNATagResponseHeader];
}

- (id)copyWithZone:(NSZone *)zone
{
    NATagResponse *copy = [[NATagResponse alloc] init];
    
    if (copy) {
        
        copy.status = [self.status copyWithZone:zone];
        copy.message = [self.message copyWithZone:zone];
        copy.doc = [self.doc copyWithZone:zone];
        copy.header = [self.header copyWithZone:zone];
    }
    
    return copy;
}


@end

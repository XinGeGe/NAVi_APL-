//
//  NAPublishers.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAPublishers.h"
#import "NAPublisherGroupInfo.h"


NSString *const kNAPublishersPublisherGroupInfo = @"PublisherGroupInfo";


@interface NAPublishers ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAPublishers

@synthesize publisherGroupInfo = _publisherGroupInfo;


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
        NSObject *receivedNAPublisherGroupInfo = [dict objectForKey:kNAPublishersPublisherGroupInfo];
        NSMutableArray *parsedNAPublisherGroupInf = [NSMutableArray array];
        //NSMutableArray *parsedNAPublisherInfo = [NSMutableArray array];
        if ([receivedNAPublisherGroupInfo isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedNAPublisherGroupInfo) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedNAPublisherGroupInf addObject:[NAPublisherGroupInfo modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedNAPublisherGroupInfo isKindOfClass:[NSDictionary class]]) {
            [parsedNAPublisherGroupInf addObject:[NAPublisherGroupInfo modelObjectWithDictionary:(NSDictionary *)receivedNAPublisherGroupInfo]];
        }
        
        self.publisherGroupInfo = [NSArray arrayWithArray:parsedNAPublisherGroupInf];
      
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.publisherGroupInfo  forKey:kNAPublishersPublisherGroupInfo];

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

    self.publisherGroupInfo = [aDecoder decodeObjectForKey:kNAPublishersPublisherGroupInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_publisherGroupInfo forKey:kNAPublishersPublisherGroupInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAPublishers *copy = [[NAPublishers alloc] init];
    
    if (copy) {

        copy.publisherGroupInfo = [self.publisherGroupInfo copyWithZone:zone];
    }
    
    return copy;
}


@end

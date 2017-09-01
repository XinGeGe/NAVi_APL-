//
//  NATagDoc.m
//  NAVi
//
//  Created by Liyuanmeng on 2017/8/25.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import "NATagDoc.h"
#import "NATag.h"

NSString *const kNAIndexNo = @"IndexNo";
NSString *const kNAMemo = @"memo";
NSString *const kNATag = @"Tag";

@interface NATagDoc ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NATagDoc
@synthesize indexNo = _indexNo;
@synthesize memo = _memo;
@synthesize tag = _tag;

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
        self.indexNo = [self objectOrNilForKey:kNAIndexNo fromDictionary:dict];
        self.memo = [self objectOrNilForKey:kNAMemo fromDictionary:dict];
        NSObject *receivedNAClipDoc = [dict objectForKey:kNATag];
        NSMutableArray *parsedNAClipDoc = [NSMutableArray array];
        if ([receivedNAClipDoc isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedNAClipDoc) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedNAClipDoc addObject:[NATag modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedNAClipDoc isKindOfClass:[NSDictionary class]]) {
            [parsedNAClipDoc addObject:[NATag modelObjectWithDictionary:(NSDictionary *)receivedNAClipDoc]];
        }
        
        self.tag = [NSArray arrayWithArray:parsedNAClipDoc];
        
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.indexNo forKey:kNAIndexNo];
    [mutableDict setValue:self.memo forKey:kNAMemo];
    NSMutableArray *tempArrayForDoc = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tag) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDoc addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDoc addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDoc] forKey:kNATag];
    
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
    
    self.indexNo = [aDecoder decodeObjectForKey:kNAIndexNo];
    self.memo = [aDecoder decodeObjectForKey:kNAMemo];
    self.tag = [aDecoder decodeObjectForKey:kNATag];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_indexNo forKey:kNAIndexNo];
    [aCoder encodeObject:_memo forKey:kNAMemo];
    [aCoder encodeObject:_tag forKey:kNATag];
}

- (id)copyWithZone:(NSZone *)zone
{
    NATagDoc *copy = [[NATagDoc alloc] init];
    
    if (copy) {
        
        copy.indexNo = [self.indexNo copyWithZone:zone];
        copy.memo = [self.memo copyWithZone:zone];
        copy.tag = [self.tag copyWithZone:zone];
    }
    
    return copy;
}

@end

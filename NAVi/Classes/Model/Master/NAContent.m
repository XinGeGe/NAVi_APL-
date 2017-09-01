//
//  NAContent.m
//  NAVi
//
//  Created by y fs on 15/7/15.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NAContent.h"
#import "NAGenre.h"
NSString *const kNAContent = @"Genre";
NSString *const kNAContentId = @"Id";

@implementation NAContent
@synthesize genrearray;
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
        
        NSMutableArray *parsedNAGenre = [NSMutableArray array];
        self.contentid=[dict objectForKey:kNAContentId];
        NSObject *receivedNAPublicationInfo = [dict objectForKey:kNAContent];
        
        if ([receivedNAPublicationInfo isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedNAPublicationInfo) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedNAGenre addObject:[NAGenre modelObjectWithDictionary:item]];
                }
            }
        }
        
        self.genrearray=parsedNAGenre;
        
    }
    
    return self;
    
}
- (id)copyWithZone:(NSZone *)zone
{
    NAContent *copy = [[NAContent alloc] init];
    if (copy) {
        copy.dispOrder1 = [self.dispOrder1 copyWithZone:zone];
        copy.dispOrder2 = [self.dispOrder2 copyWithZone:zone];
        copy.dispOrder3 = [self.dispOrder3 copyWithZone:zone];
        copy.dispOrder4 = [self.dispOrder4 copyWithZone:zone];
        copy.dispOrder5 = [self.dispOrder5 copyWithZone:zone];
        copy.genrearray = [self.genrearray copyWithZone:zone];
        copy.genreid = [self.genreid copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.contentid = [self.contentid copyWithZone:zone];
    }
    return copy;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    
    
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
    
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    
}

@end

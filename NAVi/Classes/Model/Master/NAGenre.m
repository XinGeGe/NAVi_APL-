//
//  NAGenre.m
//  NAVi
//
//  Created by y fs on 15/7/14.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NAGenre.h"
NSString *const kNAGenreinfoId = @"Id";
NSString *const kNAGenreInfoDispOrder5 = @"DispOrder5";
NSString *const kNAGenreInfoDispOrder4 = @"DispOrder4";
NSString *const kNAGenrePublicationInfo = @"PublicationInfo";
NSString *const kNAGenreInfoDispOrder3 = @"DispOrder3";
NSString *const kNAGenreInfoName = @"Name";
NSString *const kNAGenreInfoDispOrder2 = @"DispOrder2";
NSString *const kNAGenreInfoDispOrder1 = @"DispOrder1";
NSString *const kNAGenre = @"Genre";

@implementation NAGenre

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}
- (id)copyWithZone:(NSZone *)zone
{
    NAGenre *copy = [[NAGenre alloc] init];
    if (copy) {
        copy.dispOrder1 = [self.dispOrder1 copyWithZone:zone];
        copy.dispOrder2 = [self.dispOrder2 copyWithZone:zone];
        copy.dispOrder3 = [self.dispOrder3 copyWithZone:zone];
        copy.dispOrder4 = [self.dispOrder4 copyWithZone:zone];
        copy.dispOrder5 = [self.dispOrder5 copyWithZone:zone];
        copy.genreid = [self.genreid copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
            }
    return copy;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
       self.dispOrder5 = [self objectOrNilForKey:kNAGenreInfoDispOrder5 fromDictionary:dict];
       self.dispOrder4 = [self objectOrNilForKey:kNAGenreInfoDispOrder4 fromDictionary:dict];
        self.dispOrder3 = [self objectOrNilForKey:kNAGenreInfoDispOrder3 fromDictionary:dict];
        self.name = [self objectOrNilForKey:kNAGenreInfoName fromDictionary:dict];
        self.dispOrder2 = [self objectOrNilForKey:kNAGenreInfoDispOrder2 fromDictionary:dict];
        self.dispOrder1 = [self objectOrNilForKey:kNAGenreInfoDispOrder1 fromDictionary:dict];
        self.genreid=[self objectOrNilForKey:kNAGenreinfoId fromDictionary:dict];
        
        
    }
    
    return self;
    
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

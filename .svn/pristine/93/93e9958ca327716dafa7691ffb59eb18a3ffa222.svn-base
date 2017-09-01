//
//  NAClipClippingImgPath.m
//
//  Created by 晓晨 段 on 15/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAClipClippingImgPath.h"


NSString *const kNAClipClippingImgPathText = @"leafContent";
NSString *const kNAClipClippingImgPathWidth = @"width";
NSString *const kNAClipClippingImgPathDate = @"date";
NSString *const kNAClipClippingImgPathHeight = @"height";


@interface NAClipClippingImgPath ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAClipClippingImgPath

@synthesize text = _text;
@synthesize width = _width;
@synthesize date = _date;
@synthesize height = _height;


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
            self.text = [CharUtil getRightUrl:[self objectOrNilForKey:kNAClipClippingImgPathText fromDictionary:dict]];
            self.width = [self objectOrNilForKey:kNAClipClippingImgPathWidth fromDictionary:dict];
            self.date = [self objectOrNilForKey:kNAClipClippingImgPathDate fromDictionary:dict];
            self.height = [self objectOrNilForKey:kNAClipClippingImgPathHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.text forKey:kNAClipClippingImgPathText];
    [mutableDict setValue:self.width forKey:kNAClipClippingImgPathWidth];
    [mutableDict setValue:self.date forKey:kNAClipClippingImgPathDate];
    [mutableDict setValue:self.height forKey:kNAClipClippingImgPathHeight];

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

    self.text = [aDecoder decodeObjectForKey:kNAClipClippingImgPathText];
    self.width = [aDecoder decodeObjectForKey:kNAClipClippingImgPathWidth];
    self.date = [aDecoder decodeObjectForKey:kNAClipClippingImgPathDate];
    self.height = [aDecoder decodeObjectForKey:kNAClipClippingImgPathHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_text forKey:kNAClipClippingImgPathText];
    [aCoder encodeObject:_width forKey:kNAClipClippingImgPathWidth];
    [aCoder encodeObject:_date forKey:kNAClipClippingImgPathDate];
    [aCoder encodeObject:_height forKey:kNAClipClippingImgPathHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAClipClippingImgPath *copy = [[NAClipClippingImgPath alloc] init];
    
    if (copy) {

        copy.text = [self.text copyWithZone:zone];
        copy.width = [self.width copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
    }
    
    return copy;
}


@end

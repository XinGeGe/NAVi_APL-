//
//  NAImageDetailClass.m
//  NAVi
//
//  Created by y fs on 15/6/23.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NAImageDetailClass.h"
#import "NAResponse.h"
NSString *const kNAImageDetailClassResponse = @"response";

@implementation NAImageDetailClass

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
        //NSLog(@"kNAImageDetailClassResponse dic=%@",dict);
        NSDictionary *responsedic=[self objectOrNilForKey:kNAImageDetailClassResponse fromDictionary:dict];
        if ([responsedic isKindOfClass:[NSDictionary class]]) {
            NSDictionary *docdic=[self objectOrNilForKey:kDoc fromDictionary:responsedic];
            if ([docdic isKindOfClass:[NSDictionary class]]) {
                self.Caption = [self stringOrNilForKey:kCaption fromDictionary:docdic];
                self.Image_L_LastModified=[self objectOrNilForKey:kImage_L_LastModified fromDictionary:docdic];
                self.Image_L_Path = [self objectOrNilForKey:kImage_L_Path fromDictionary:docdic];
                self.Image_S_LastModified = [self objectOrNilForKey:kImage_S_LastModified fromDictionary:docdic];
                self.Image_S_Path = [self objectOrNilForKey:kImage_S_Path fromDictionary:docdic];
                self.IndexNo = [self objectOrNilForKey:kIndexNo fromDictionary:docdic];
                self.MiniImageLastModified = [self objectOrNilForKey:kMiniImageLastModified fromDictionary:docdic];
                self.MiniImagePath = [self objectOrNilForKey:kMiniImagePath fromDictionary:docdic];
                self.PictureType = [self objectOrNilForKey:kPictureType fromDictionary:docdic];
                self.RelatedInfo3 = [self objectOrNilForKey:kRelatedInfo3 fromDictionary:docdic];
                
            }
            
        }
        
    }
    
    return self;
    
}
- (id)copyWithZone:(NSZone *)zone
{
    NAImageDetailClass *copy = [[NAImageDetailClass alloc] init];
    if (copy) {
        copy.Caption = [self.Caption copyWithZone:zone];
        copy.Image_L_LastModified = [self.Image_L_LastModified copyWithZone:zone];
        copy.Image_L_Path = [self.Image_L_Path copyWithZone:zone];
        copy.Image_S_LastModified = [self.Image_S_LastModified copyWithZone:zone];
        copy.Image_S_Path = [self.Image_S_Path copyWithZone:zone];
        copy.IndexNo = [self.IndexNo copyWithZone:zone];
        copy.MiniImageLastModified = [self.MiniImageLastModified copyWithZone:zone];
        copy.MiniImagePath = [self.MiniImagePath copyWithZone:zone];
        copy.PictureType = [self.PictureType copyWithZone:zone];
        copy.RelatedInfo3 =[self.RelatedInfo3 copyWithZone:zone];
        copy.Title =[self.Title copyWithZone:zone];
    }
    return copy;
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

- (id)stringOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isKindOfClass:[NSString class]] ? object : @"";
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

//
//  NAImageDetailClass.h
//  NAVi
//
//  Created by y fs on 15/6/23.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kCaption @"Caption"
#define kImage_L_LastModified @"Image_L_LastModified"
#define kImage_L_Path @"Image_L_Path"
#define kImage_S_LastModified @"Image_S_LastModified"
#define kImage_S_Path @"Image_S_Path"
#define kIndexNo @"IndexNo"
#define kMiniImageLastModified @"MiniImageLastModified"
#define kMiniImagePath @"MiniImagePath"
#define kPictureType @"PictureType"
#define kRelatedInfo3 @"RelatedInfo3"
#define kITitle @"Title"
#define kDoc @"doc"

@interface NAImageDetailClass : NSObject  <NSCoding, NSCopying>
@property (nonatomic, strong) NSString *Caption;
@property (nonatomic, strong) NSString *Image_L_LastModified;
@property (nonatomic, strong) NSString *Image_L_Path;
@property (nonatomic, strong) NSString *Image_S_LastModified;
@property (nonatomic, strong) NSString *Image_S_Path;
@property (nonatomic, strong) NSString *IndexNo;
@property (nonatomic, strong) NSString *MiniImageLastModified;
@property (nonatomic, strong) NSString *MiniImagePath;
@property (nonatomic, strong) NSString *PictureType;
@property (nonatomic, strong) NSString *RelatedInfo3;
@property (nonatomic, strong) NSString *Title;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

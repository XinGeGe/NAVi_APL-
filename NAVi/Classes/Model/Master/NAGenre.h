//
//  NAGenre.h
//  NAVi
//
//  Created by y fs on 15/7/14.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAGenre : NSObject<NSCoding, NSCopying>
@property (nonatomic, strong) NSString *dispOrder5;
@property (nonatomic, strong) NSString *dispOrder4;

@property (nonatomic, strong) NSString *dispOrder3;
@property (nonatomic, strong) NSString *genreid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *dispOrder2;
@property (nonatomic, strong) NSString *dispOrder1;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
@end

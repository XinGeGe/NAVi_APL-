//
//  NATag.h
//  NAVi
//
//  Created by Liyuanmeng on 2017/8/25.
//  Copyright © 2017年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NATag : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *tagid;
@property (nonatomic, strong) NSString *tagName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

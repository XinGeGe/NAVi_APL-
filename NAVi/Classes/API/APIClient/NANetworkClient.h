//
//  NANetworkClient.h
//  NAVi
//
//  Created by y fs on 15/9/18.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NABaseClient.h"
#import "NALoginModel.h"
#import "NALogoutModel.h"


@interface NANetworkClient : NABaseClient

/**
 *  Master
 *
 *  @param useDevice
 *  @param completion
 */
- (void)postMasterWithDevice:(NSDictionary *)param
             completionBlock:(void(^)(id master, NSError *error))completion;
/**
 *  CheckUserid
 *
 *  @param useDevice
 *  @param completion
 */
- (void)postCheckUserid:(NSDictionary *)param
            completionBlock:(void(^)(id master, NSError *error))completion;
/**
 *  検索
 *
 *  @param param
 *  @param completion
 */
- (void)postSearch:(NSDictionary *)param
   completionBlock:(void(^)(id search, NSError *error))completion;

/**
 *  クリップ 保存
 *
 *  @param param
 *  @param completion
 */
- (void)postFavoritesSave:(NSDictionary *)param
          completionBlock:(void(^)(id favorites, NSError *error))completion;
/**
 *  クリップ 削除
 *
 *  @param param
 *  @param completion
 */
- (void)postFavoritesDelete:(NSDictionary *)param
            completionBlock:(void(^)(id favorites, NSError *error))completion;

/**
 *  クリップ 検索
 *
 *  @param param
 *  @param completion
 */
- (void)postFavoritesSearch:(NSDictionary *)param
            completionBlock:(void(^)(id favorites, NSError *error))completion;
//searchTagList
- (void)postTagFavoritesSearch:(NSDictionary *)param
            completionBlock:(void(^)(id favorites, NSError *error))completion;

//searchFavoritesList
- (void)postTagFavoritesListSearch:(NSDictionary *)param
               completionBlock:(void(^)(id favorites, NSError *error))completion;
//deleteTag
- (void)deleteTag:(NSDictionary *)param
            completionBlock:(void(^)(id favorites, NSError *error))completion;

//renameTag
- (void)renameTag:(NSDictionary *)param completionBlock:(void(^)(id favorites, NSError *error))completion;

//saveTag
- (void)saveTag:(NSDictionary *)param completionBlock:(void(^)(id favorites, NSError *error))completion;

//ClipMemo
- (void)ClipMemo:(NSDictionary *)param completionBlock:(void(^)(id favorites, NSError *error))completion;
//changeClipInfo
- (void)changeClipInfo:(NSDictionary *)param completionBlock:(void(^)(id favorites, NSError *error))completion;
/**
 *  画像
 *
 *  @param param
 *  @param completion
 */
- (void)postRelevantPhoto:(NSDictionary *)param
          completionBlock:(void(^)(id favorites, NSError *error))completion;

/**
 *  ログアウト
 *
 *  @param useDevice
 *  @param completion
 */
- (void)postLogoutWithDevice:(NSString *)useDevice completionBlock:(void(^)(NALogoutModel *logout, NSError *error))completion;


- (void)postDefaultUseridMasterWithDevice:(NSString *)useDevice completionBlock:(void(^)(id master, NSError *error))completion;

@end

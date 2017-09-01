//
//  NASQLHelper.h
//  NAVi
//
//  Created by y fs on 15/6/8.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "PaperInfo.h"
#import "NADoc.h"



@interface NASQLHelper : NSObject{
    sqlite3 *database;
}
+ (NASQLHelper *)sharedInstance;
-(void)CreateDB;
-(void)CreateMyPaperTable;
-(BOOL)executeNonQuery:(NSString *)sql;
-(NSArray *)executeQuery:(NSString *)sql;

-(BOOL)revertSeq;
-(BOOL)clearFeedTable;
-(NSArray *)getPaperInfoByUserId:(NSString *)userid;
-(BOOL)deletePaperInfoByUserId:(NSInteger)userid;
-(BOOL)deletePaperInfoByUserIdAndolddate:(NSString *)userid Theolddate:(NSString *)olddate;
-(BOOL)addPaperInfo:(NADoc *)data;
-(BOOL)isHavePaperInfoByDoc:(NADoc *)data;
-(NSString *)getThelastdateWithuserid:(NSString *)userid;
@end

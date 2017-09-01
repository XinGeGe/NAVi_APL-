//
//  NASQLHelper.m
//  NAVi
//
//  Created by y fs on 15/6/8.
//  Copyright (c) 2015年 dxc. All rights reserved.
//

#import "NASQLHelper.h"
NSString *const DB_NAME =@"database.sqlite3";
NSInteger const VERSION = 1;
NSString *const TABLE_PAPER_INFO =@"paperInfo";
NSString *const ID =@"id";

NSString *const USER_ID=@"USER_ID";
NSString *const PUBLISHERGROUPINFO_ID=@"PUBLISHERGROUPINFO_ID";
NSString *const PUBLISHERINFO_ID=@"PUBLISHERINFO_ID";
NSString *const PUBLICATIONINFO_ID=@"PUBLICATIONINFO_ID";
NSString *const EDITIONINFO_ID=@"EDITIONINFO_ID";
NSString *const PUBLISH_DATE=@"PUBLISH_DATE";

@implementation NASQLHelper

+ (NASQLHelper *)sharedInstance
{
    static NASQLHelper *_sharedInstance = nil;
    static dispatch_once_t managerPredicate;
    dispatch_once(&managerPredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}
-(void)CreateDB{
    NSArray *documentsPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
                                                                , NSUserDomainMask
                                                                , YES);
    NSString *databaseFilePath=[[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:DB_NAME];
    
    if (sqlite3_open([databaseFilePath UTF8String], &database)==SQLITE_OK) {
        //        NSLog(@"open sqlite db ok.");
    }
}
-(NSString *) dataFilePath{
    
    NSArray *path =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *document = [path objectAtIndex:0];
    
    return [document stringByAppendingPathComponent:DB_NAME];
    
}
-(void)CreateMyPaperTable{
    [self CreateDB];
    
    char *errorMsg;
    NSString *createSql=[NSString stringWithFormat:@"create table if not exists %@ (_id INTEGER PRIMARY KEY AUTOINCREMENT,%@ INTEGER,%@ VARCHAR,%@ VARCHAR,%@ VARCHAR,%@ VARCHAR,%@ VARCHAR,%@ VARCHAR)",TABLE_PAPER_INFO,ID,USER_ID,PUBLISHERGROUPINFO_ID,PUBLISHERINFO_ID,PUBLICATIONINFO_ID,EDITIONINFO_ID,PUBLISH_DATE];
    
    if (sqlite3_exec(database, [createSql UTF8String], NULL, NULL, &errorMsg)==SQLITE_OK) {
        //        NSLog(@"create ok.");
    }
}

-(BOOL)executeNonQuery:(NSString *)sql{
    [self CreateDB];
    BOOL flag=YES;
    char *error;
    // do sql content, insert,update,delete
    if (SQLITE_OK!=sqlite3_exec(database, sql.UTF8String, NULL, NULL,&error)) {
        NSLog(@"SQL_error=%s",error);
        flag=NO;
    }
    return flag;
}
-(NSArray *)executeQuery:(NSString *)sql{
    [self CreateDB];
    NSMutableArray *rows=[NSMutableArray array];
    
    sqlite3_stmt *stmt;
    
    if (SQLITE_OK==sqlite3_prepare_v2(database, sql.UTF8String, -1, &stmt, NULL)) {
        
        while (SQLITE_ROW==sqlite3_step(stmt)) {
            int columnCount= sqlite3_column_count(stmt);
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            for (int i=0; i<columnCount; i++) {
                const char *name= sqlite3_column_name(stmt, i);
                const unsigned char *value= sqlite3_column_text(stmt, i);
                dic[[NSString stringWithUTF8String:name]]=[NSString stringWithUTF8String:(const char *)value];
            }
            [rows addObject:dic];
        }
    }
    
    
    sqlite3_finalize(stmt);
    
    return rows;
}

-(BOOL)addPaperInfo:(NADoc *)data{
    
    NSString *insertsql=[NSString stringWithFormat:@"INSERT INTO %@ (%@,%@,%@,%@,%@,%@) VALUES('%@','%@','%@','%@','%@','%@')",TABLE_PAPER_INFO,USER_ID,PUBLISHERGROUPINFO_ID,PUBLISHERINFO_ID,PUBLICATIONINFO_ID,EDITIONINFO_ID,PUBLISH_DATE,data.user_id ,data.publisherGroupInfoId,data.publisherInfoId,data.publicationInfoId,data.editionInfoId,data.publishDate];
    return [self  executeNonQuery:insertsql];
}
-(BOOL)deletePaperInfoByUserIdAndolddate:(NSString *)userid Theolddate:(NSString *)olddate{
    NSString *delelesql=[NSString stringWithFormat:@"DELETE FROM paperinfo WHERE %@ = '%@' AND  %@ = '%@'",USER_ID,userid,PUBLISH_DATE,olddate];
    return [self  executeNonQuery:delelesql];
}
-(BOOL)deletePaperInfoByUserId:(NSInteger)userid{
    NSString *delelesql=[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = %ld",TABLE_PAPER_INFO,USER_ID,(long)userid];
    return [self  executeNonQuery:delelesql];
}
-(NSString *)getThelastdateWithuserid:(NSString *)userid{
    NSString *secsql= [NSString stringWithFormat:@"SELECT MAX(PUBLISH_DATE) FROM paperinfo WHERE  USER_ID='%@' group by USER_ID",userid];
    [self CreateDB];
    
    NSString *datestr=@"";
    sqlite3_stmt *stmt;
    
    if (SQLITE_OK==sqlite3_prepare_v2(database, secsql.UTF8String, -1, &stmt, NULL)) {
        
        while (SQLITE_ROW==sqlite3_step(stmt)) {
            char *datechar = (char *)sqlite3_column_text(stmt, 0);
            datestr = [[NSString alloc] initWithUTF8String:datechar];
        }
    }
    
    
    sqlite3_finalize(stmt);
    return datestr;
}

-(BOOL)isHavePaperInfoByDoc:(NADoc *)data{
    [self CreateDB];
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSString *quary =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@='%@' AND %@='%@' AND %@='%@' AND %@='%@' AND %@='%@' AND %@='%@'",TABLE_PAPER_INFO,USER_ID,data.user_id,PUBLISHERGROUPINFO_ID,data.publisherGroupInfoId,PUBLISHERINFO_ID,data.publisherInfoId,PUBLICATIONINFO_ID,data.publicationInfoId,EDITIONINFO_ID,data.editionInfoId,PUBLISH_DATE,data.publishDate] ;
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [quary UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            
            NADoc *paperinfo=[[NADoc alloc]init];
            
            int t_id = sqlite3_column_int(stmt, 1);
            paperinfo.t_id=t_id;
            
            char *user_id = (char *)sqlite3_column_text(stmt, 2);
            NSString *user_idstr = [[NSString alloc] initWithUTF8String:user_id];
            paperinfo.user_id=user_idstr;
            
            char *publishergroupinfo_id = (char *)sqlite3_column_text(stmt, 3);
            NSString *publishergroupinfo_idstr = [[NSString alloc] initWithUTF8String:publishergroupinfo_id];
            paperinfo.publisherGroupInfoId=publishergroupinfo_idstr;
            
            char *publisherinfo_id = (char *)sqlite3_column_text(stmt, 4);
            NSString *publisherinfo_idstr = [[NSString alloc] initWithUTF8String:publisherinfo_id];
            paperinfo.publisherInfoId=publisherinfo_idstr;
            
            char *publicationinfo_id = (char *)sqlite3_column_text(stmt, 5);
            NSString *publicationinfo_idstr = [[NSString alloc] initWithUTF8String:publicationinfo_id];
            paperinfo.publicationInfoId=publicationinfo_idstr;
            
            char *editioninfoid = (char *)sqlite3_column_text(stmt, 6);
            NSString *editioninfoidstr = [[NSString alloc] initWithUTF8String:editioninfoid];
            paperinfo.editionInfoId=editioninfoidstr;
            
            char *publishdate = (char *)sqlite3_column_text(stmt, 7);
            NSString *publishdatestr = [[NSString alloc] initWithUTF8String:publishdate];
            paperinfo.publishDate=publishdatestr;
            
            [array addObject:paperinfo];
            
        }
        
        sqlite3_finalize(stmt);
    }
    
    sqlite3_close(database);
    if (array.count>0) {
        return YES;
    }else{
        return NO;
    }
    
}


-(NSArray *)getPaperInfoByUserId:(NSString *)userid{
    
    [self CreateDB];
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSString *quary =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@='%@' ORDER BY %@,%@ DESC",TABLE_PAPER_INFO,USER_ID,userid,PUBLISHERGROUPINFO_ID,PUBLISH_DATE] ;
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [quary UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            
            
            NADoc *paperinfo=[[NADoc alloc]init];
            int t_id = sqlite3_column_int(stmt, 1);
            paperinfo.t_id=t_id;
            
            char *user_id = (char *)sqlite3_column_text(stmt, 2);
            NSString *user_idstr = [[NSString alloc] initWithUTF8String:user_id];
            paperinfo.user_id=user_idstr;
            
            char *publishergroupinfo_id = (char *)sqlite3_column_text(stmt, 3);
            NSString *publishergroupinfo_idstr = [[NSString alloc] initWithUTF8String:publishergroupinfo_id];
            paperinfo.publisherGroupInfoId=publishergroupinfo_idstr;
            
            char *publisherinfo_id = (char *)sqlite3_column_text(stmt, 4);
            NSString *publisherinfo_idstr = [[NSString alloc] initWithUTF8String:publisherinfo_id];
            paperinfo.publisherInfoId=publisherinfo_idstr;
            
            char *publicationinfo_id = (char *)sqlite3_column_text(stmt, 5);
            NSString *publicationinfo_idstr = [[NSString alloc] initWithUTF8String:publicationinfo_id];
            paperinfo.publicationInfoId=publicationinfo_idstr;
            
            char *editioninfoid = (char *)sqlite3_column_text(stmt, 6);
            NSString *editioninfoidstr = [[NSString alloc] initWithUTF8String:editioninfoid];
            paperinfo.editionInfoId=editioninfoidstr;
            
            char *publishdate = (char *)sqlite3_column_text(stmt, 7);
            NSString *publishdatestr = [[NSString alloc] initWithUTF8String:publishdate];
            paperinfo.publishDate=publishdatestr;
            
            [array addObject:paperinfo];
            
        }
        
        sqlite3_finalize(stmt);
    }
    
    sqlite3_close(database);
    return array;
}
-(BOOL)clearFeedTable{
    NSString *delelesql=[NSString stringWithFormat:@"DELETE FROM %@ ",TABLE_PAPER_INFO];
    return [self  executeNonQuery:delelesql];
}
-(BOOL)revertSeq{
    NSString *delelesql=[NSString stringWithFormat:@"update sqlite_sequence set seq=0 where name= %@ ",TABLE_PAPER_INFO];
    return [self  executeNonQuery:delelesql];
}
@end


#import <Foundation/Foundation.h>
#import "DataModels.h"

NSString *const NoteFileName ;
NSString *const SokuhoFileName ;
NSString *const NAPageMiniPhoto ;
NSString *const NAPageNormalPhoto ;
NSString *const NAPageLargePhoto ;
NSString *const NAImageExtendedName ;

@interface NAFileManager : NSObject



+ (NAFileManager *)sharedInstance;

- (void)deleteUserInfo;
- (void)deleteDetailInfo;
- (void)deleteSearchResult;
- (void)clearTheoldfileWithuserid:(NSString *)userid Thelastdate:(NSString *)lastdate;
-(NSArray *)getNotClearFileDateArray:(NSString *)userid;
- (void)clearOldFileWithNotClearArray:(NSArray *)notClearArray WithUserid:(NSString *)userid;
//master xml
- (void)saveMasterFileWithData:(NSData *)fileData;
- (NSData *)readMasterFile;
- (NSArray *)masterPublicationInfo;
- (NSArray *)masterPublisherGroupInfo;
- (NSArray *)masterpublisherInfo;
//search page xml
- (void)saveSearchFileWithData:(NSData *)fileData Mydoc:(NADoc *)doc;
- (NSString *)searchNoteName:(NADoc *)doc withNoteName:(NSString *)fileName;
- (NSString *)searchSokuhoName:(NASDoc *)doc withSokuhoName:(NSString *)fileName;
- (NSString *)searchPathWithFileName:(NADoc *)doc withImageName:(NSString *)imageName;
- (NSString *)searchNotePathWithFileName:(id)doc withImageName:(NSString *)imageName;

- (void)writeLargeImageToSearchManager:(NSData *)image info:(NADoc *)docInfo;
- (void)writeMiddleImageToSearchManager:(NSData *)image info:(NADoc *)docInfo;
- (void)writeMinImageToSearchManager:(NSData *)image info:(NADoc *)docInfo;
- (void)writeNoteToSearchManager:(NSData *)note info:(NADoc *)docInfo;
- (void)writeSokuhoToSearchManager:(NSData *)note info:(NASDoc *)docInfo;

- (void)saveSearchResult:(NSData *)search;
- (NSString *)getSearchResult;

- (NSData *)dataWitharray:(NSArray *)array;
- (NSArray *)arrayWithData:(NSData *)data;

- (NSString *)AllNotePath;

//save plist
+(int)CopyFileToDocument:(NSString*)FileName;
+(NSDictionary *)ChangePlistTodic;

- (NSData *)readSearchFileWithdoc:(NADoc *)doc;

+(void)deleteinitplistFile;

//save login html
-(void)saveLoginhtml:(NSData *)myHtmlData;
-(NSString *)getLoginHtml;
-(void)saveTophtml:(NSData *)myHtmlData;
-(NSString *)getTopHtml;

+ (NSString *)getPDFPath:(NSString *)filename;
@end

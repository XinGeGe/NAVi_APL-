
#import "NSString+NAAPI.h"
#import "NASaveData.h"

@implementation NSString(NAAPI)

// Date
+ (NSString *)nowDate
{
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMddHHmmss"];
    return [dateformatter stringFromDate:senddate];
}

+ (NSString *)nowDateForSearch:(NSDate *)date
{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    return [dateformatter stringFromDate:date];
}

+ (NSString *)dateForSearch:(NSDate *)date
{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMdd"];
    return [dateformatter stringFromDate:date];
    
}

// API Path
+ (NSString *)baseURLPath
{
    NSDictionary *dic=[NAFileManager ChangePlistTodic];
    NSArray *tmparray=[dic allKeys];
    for (NSInteger index=0; index<tmparray.count; index++) {
        NSString *str=[tmparray objectAtIndex:index];
        NSArray *strarray=[str componentsSeparatedByString:@"."];
        if (strarray.count>1) {
            if (![[strarray objectAtIndex:1] isEqualToString:@"login"]) {
                NSString *userid=[strarray lastObject];
                if ([[NASaveData getLoginUserId] isEqualToString:userid] ) {
                     return [NSString stringWithFormat:@"%@%@",[NASaveData getDataServerProtocol],[dic objectForKey:str]];
                }
            }
        }
        
    }
//    return [NSString stringWithFormat:@"%@%@",[NASaveData getDataServerProtocol],[dic objectForKey:serverdefault]];
    return [NSString stringWithFormat:@"%@",[dic objectForKey:serverdefault]];
    /*
     NSString *userID = @"akita";
     if ([[[NASaveData getLoginUserId] uppercaseString] isEqualToString:[userID uppercaseString]] ) {
     return @"http://153.149.5.60:8080/TCDBWS/";
     }else if ([[[NASaveData getLoginUserId] uppercaseString] isEqualToString:[@"gifu" uppercaseString]]){
     return @"http://153.149.5.60:8080/TCDBWS/";
     
     }else{
     return @"http://153.149.5.60:8083/TCDBWS/";
     }
     
     return nil;
     */
}

+ (NSString *)baseLoginURLPath
{
    //return @"http://153.149.5.60:8080/TCDBWS/";
    NSDictionary *dic=[NAFileManager ChangePlistTodic];
    NSArray *tmparray=[dic allKeys];
    for (NSInteger index=0; index<tmparray.count; index++) {
        NSString *str=[tmparray objectAtIndex:index];
        NSArray *strarray=[str componentsSeparatedByString:@"."];
        if (strarray.count>1) {
            if ([[strarray objectAtIndex:1] isEqualToString:@"login"]) {
                NSString *userid=[strarray lastObject];
                if ([[NASaveData getLoginUserId] isEqualToString:userid] ) {
                     return [NSString stringWithFormat:@"%@%@",[NASaveData getDataServerProtocol],[dic objectForKey:str]];
                }
            }
            
        }
    }
    return [NSString stringWithFormat:@"%@",[dic objectForKey:loginserverdefault]];
//    return [NSString stringWithFormat:@"%@%@",[NASaveData getDataServerProtocol],[dic objectForKey:loginserverdefault]];
}
// push Path
+ (NSString *)pushURLPath{
    return [NASaveData getSendTokenUrl];
}
+ (NSString *)sendTokenPath
{
    return @"saveToken?";
}
+ (NSString *)loginPath
{
    //return @"authority?";
    return @"authin?";
}

+ (NSString *)logoutPath
{
    //return @"logout?";
    return @"signout?";
}

+ (NSString *)loginCheckPath
{
    //return @"check?";
    return @"loginCheck?";
}

+ (NSString *)masterPath
{
    return @"getmaster?";
}

+ (NSString *)searchPath
{
    return @"search?";
}

+ (NSString *)favoritesSavePath
{
    //return @"saveFavorites?";
    return @"stockFavorites?";
}

+ (NSString *)avoritesDeletePath
{
    //return @"deleteFavorites?";
    return @"delFavorites?";
}

+ (NSString *)favoritesSearchPath
{
    return @"searchFavorites?";
}
+ (NSString *)favoritesTagSearchPath
{
    return @"searchTagList?";
}
+ (NSString *)searchFavoritesListPath
{
    return @"searchFavoritesList?";
}
+ (NSString *)deleteTag{
    return @"deleteTag?";
}
+ (NSString *)renameTag{
    return @"renameTag?";
}
+ (NSString *)saveTag{
    return @"saveTag?";
}
+ (NSString *)ClipMemo{
    return @"ClipMemo?";
}
+ (NSString *)changeClipInfo{
    return @"changeClipInfo?";
}

+ (NSString *)relevantPhotoPath
{
    return @"relevantPhoto?";
}

+ (NSString *)searchWithPublicationInfoId
{
    return @"K104,K105,K106,K107,K108,K109,K110,K012,K018,K019,K020,K026,K036,K037,K038,K032,K033,K080,K094";
}

+ (NSString *)searchCurrentFl
{
    return @"K104,K105,K106,K107,K108,K109,K110,K012,K018,K019,K020,K026,K036,K037,K038,K032,K033,K080,K094";
}

+ (NSString *)searchCurrentAtricleFl
{
    return @"K104,K105,K106,K107,K108,K109,K110,K031,K015,K016,K021,K022,K043,K032,K027,K023,K024,K025,K063,K062";
}

+ (NSString *)searchDateSelectedFl
{
    return @"K104,K105,K106,K107,K108,K109,K110,K012,K018,K019,K020,K026,K036,K037,K038,K032,K033,K080,K094,K083,K084";
}

+ (NSString *)clipListFl
{
    return @"K104,K105,K106,K107,K108,K109,K110,K031,K015,K016,K021,K022,K043,K032,K027,K023,K024,K025,K063,K062";
}

+ (NSString *)addclipListFl
{
    
    return @"K104,K105,K106,K107,K108,K109,K110";
}

@end

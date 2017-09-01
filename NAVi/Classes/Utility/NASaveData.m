
#import "NASaveData.h"
NSString * const NASaveDataLoginID       = @"NASaveDataLoginID";
NSString * const NASaveDataLoginPassWord = @"NASaveDataLoginPassWord";
NSString * const NASaveUserInfo          = @"NASaveUserInfo";
NSString * const NASaveLoginTimeStamp    = @"NASaveLoginTimeStamp";
NSString * const NAAlldownload         = @"NAAlldownload";
NSString * const NAFrontSize         = @"NAFRONTSIZE";
NSString * const NASokuhoFrontSize         = @"NASOKUHOFRONTSIZE";
NSString * const NASokuhoFrontNum         = @"NASOKUHOFRONTNUM";
NSString * const NAFrontNum         = @"NAFRONTNUM";
NSString * const NAExpansion_rate         = @"Expansion_rate";
NSString * const NASpanNum         = @"SpanNum";
NSString * const NASpans         = @"Spans";
NSString * const NAExpansion_rateNum=@"NAExpansion_rate";
NSString * const ReleaseAreaInfo = @"ReleaseAreaInfo";
NSString * const PublishDayInfo = @"PublishDayInfo";
NSString * const UserClass = @"UserClass";
@implementation NASaveData


+ (NASaveData *)sharedInstance
{
    static NASaveData *_sharedInstance = nil;
    static dispatch_once_t managerPredicate;
    dispatch_once(&managerPredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark - Login -
#pragma mark

+ (BOOL)isLogin
{
    NSString *pass = [[NSUserDefaults standardUserDefaults] objectForKey:NASaveDataLoginPassWord];
    NSNumber *save  = [[NSUserDefaults standardUserDefaults] objectForKey:NASaveUserInfo];

    if (pass && ![pass isEqualToString:@""] && save.boolValue) {
        return YES;
    }
    return NO;
}
+ (BOOL)isHaveNote{
    NSDictionary *alluserdic=[self getALLUser];
    NSDictionary *valuedic=[alluserdic objectForKey:[self getDefaultUserID]];
    NSNumber *ishavenotenum=[valuedic objectForKey:ishavenote];
    return ishavenotenum.boolValue;
}

+ (NSString *)getExpansion_rate{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NAExpansion_rate];
}
+ (void)saveExpansion_rate:(NSString *)isSave{
    [[NSUserDefaults standardUserDefaults] setObject:isSave forKey:NAExpansion_rate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getIsAutologin{
    return [[NSUserDefaults standardUserDefaults] boolForKey:isAutologin];
}
+ (void)saveAutologin:(BOOL)isSave{
    [[NSUserDefaults standardUserDefaults] setBool:isSave forKey:isAutologin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getLoginUserId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NASaveDataLoginID];
}
+ (NSString *)getLoginPassWord
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NASaveDataLoginPassWord];
}
+ (void)SaveLoginWithID:(NSString *)loginID
           withPassWord:(NSString *)loginPassWord
{
    [[NSUserDefaults standardUserDefaults] setObject:loginID forKey:NASaveDataLoginID];
    [[NSUserDefaults standardUserDefaults] setObject:loginPassWord forKey:NASaveDataLoginPassWord];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+(void)saveUserId:(NSString *)loginID{
    [[NSUserDefaults standardUserDefaults] setObject:loginID forKey:NASaveDataLoginID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)clearLoginInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:NASaveDataLoginID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:NASaveDataLoginPassWord];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:NASaveUserInfo];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserClass];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getReleaseAreaInfo
{
    NSString *save = [[NSUserDefaults standardUserDefaults] objectForKey:ReleaseAreaInfo];
    return save;
}
+ (void)saveReleaseAreaInfo:(NSString *)releaseAreaInfo
{
    [[NSUserDefaults standardUserDefaults] setObject:releaseAreaInfo forKey:ReleaseAreaInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getDataPublishDayInfo
{
    NSString *save = [[NSUserDefaults standardUserDefaults] objectForKey:PublishDayInfo];
    return save;
}
+ (void)saveDataPublishDayInfo:(NSString *)publishDayInfo
{
    [[NSUserDefaults standardUserDefaults] setObject:publishDayInfo forKey:PublishDayInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getDataUserClass
{
    NSString *save = [[NSUserDefaults standardUserDefaults] objectForKey:UserClass];
    return save;
}
+ (void)saveDataUserClass:(NSString *)userClass
{
    [[NSUserDefaults standardUserDefaults] setObject:userClass forKey:UserClass];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)isAlldownload
{
    if ([NASaveData sharedInstance].isAlldownloadNum==nil) {
        BOOL save = [[NSUserDefaults standardUserDefaults] boolForKey:NAAlldownload];
        [NASaveData sharedInstance].isAlldownloadNum=[NSNumber numberWithBool:save];
    }
    
    return [NASaveData sharedInstance].isAlldownloadNum.boolValue;
}

+ (void)saveAlldownload:(NSNumber *)isSave
{
    if (isSave) {
        [NASaveData sharedInstance].isAlldownloadNum=isSave;
        [[NSUserDefaults standardUserDefaults] setBool:isSave.boolValue forKey:NAAlldownload];
    } else {
        [NASaveData sharedInstance].isAlldownloadNum=[NSNumber numberWithBool:NO];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:NAAlldownload];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+ (NSString *)getDataServerProtocol
{
    NSString *save = [[NSUserDefaults standardUserDefaults] objectForKey:NADataServerProtocol];
    return save;
}
+ (void)saveDataServerProtocol:(NSString *)isSave
{
    [[NSUserDefaults standardUserDefaults] setObject:isSave forKey:NADataServerProtocol];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getImageServerProtocol
{
    NSString *save = [[NSUserDefaults standardUserDefaults] objectForKey:NAImageServerProtocol];
    return save;
}

+ (void)saveImageServerProtocol:(NSString *)isSave
{
    [[NSUserDefaults standardUserDefaults] setObject:isSave forKey:NAImageServerProtocol];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isSaveUserInfo
{
    NSNumber *save  = [[NSUserDefaults standardUserDefaults] objectForKey:NASaveUserInfo];
    if (save) {
        return save.boolValue;
    }
    return NO;
}

+ (void)saveUserInfo:(NSNumber *)isSave
{
    [[NSUserDefaults standardUserDefaults] setObject:isSave forKey:NASaveUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)isAgreeMent{
    NSNumber *save  = [[NSUserDefaults standardUserDefaults] objectForKey:@"IsAgreeMent"];
    if (save) {
        return save.boolValue;
    }
    return NO;
}
+ (void)saveIsAgreeMent:(NSNumber *)isSave{
    [[NSUserDefaults standardUserDefaults] setObject:isSave forKey:@"IsAgreeMent"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//timestamp

+ (void)saveTimeStamp:(NSString *)timeStamp
{
    [[NSUserDefaults standardUserDefaults] setObject:timeStamp forKey:NASaveLoginTimeStamp];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isSaveTimeStamp
{
    NSString *timeStamp = [[NSUserDefaults standardUserDefaults] objectForKey:NASaveLoginTimeStamp];
    if (timeStamp && ![timeStamp isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
//InformationUrl
+ (void)InformationUrl:(NSString *)url{
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:NAInformationUrlkey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getInformationUrl{
     NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:NAInformationUrlkey];
    return url;
}
//Landscapekei
+ (void)saveLandscapekei:(NSNumber *)kei{
    [[NSUserDefaults standardUserDefaults] setObject:kei forKey:NALandscapekeikey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (CGFloat )getLandscapekei{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NALandscapekeikey] ;
    return kei.floatValue;
}
//BarShowInterval
+ (void)saveBarShowInterval:(NSNumber *)kei{
    [[NSUserDefaults standardUserDefaults] setObject:kei forKey:NABarShowIntervalkey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (CGFloat )getBarShowInterval{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NABarShowIntervalkey] ;
    return kei.floatValue;
}
+ (void)saveTimeoutInterval:(NSNumber *)kei{
    [[NSUserDefaults standardUserDefaults] setObject:kei forKey:NATimeoutIntervalkey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (CGFloat )getTimeoutInterval{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NATimeoutIntervalkey] ;
    return kei.floatValue;
}
//FastNewsRows
+ (void)saveFastNewsRows:(NSNumber *)kei{
    [[NSUserDefaults standardUserDefaults] setObject:kei forKey:NAFastNewsRowskey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getFastNewsRows{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NAFastNewsRowskey] ;
    return kei.floatValue;
}
+ (void)saveNotClearDays:(NSNumber *)kei{
    [[NSUserDefaults standardUserDefaults] setObject:kei forKey:NANOTCLEARDAYSKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getNotClearDays{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NANOTCLEARDAYSKEY] ;
    return kei.floatValue;
}
+ (NSInteger)getFirstDownload{
    NSNumber *kei=[[NSUserDefaults standardUserDefaults] objectForKey:NAFirstDownload];
    return  kei.integerValue;
}
+ (void)saveFirstDownload:(NSNumber *)oIndex{
    [[NSUserDefaults standardUserDefaults] setObject:oIndex forKey:NAFirstDownload];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+ (NSInteger)getISFastNews{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NAISFastNewskey] ;
    return kei.integerValue;
}
+ (void)saveISFastNews:(NSNumber *)oIndex{
    [[NSUserDefaults standardUserDefaults] setObject:oIndex forKey:NAISFastNewskey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)saveClipSelectedBtnTag:(NSInteger)tag{
    [[NSUserDefaults standardUserDefaults] setInteger:tag forKey:NAClipSelectedTag];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getClipSelectedBtnTag{
    NSNumber *selectedTag = [[NSUserDefaults standardUserDefaults] objectForKey:NAClipSelectedTag];
    return selectedTag.integerValue;
}
+ (void)saveFastNewsTate:(NSNumber *)kei{
    [[NSUserDefaults standardUserDefaults] setObject:kei forKey:NAFastNewsTatekey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL )getFastNewsTate{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NAFastNewsTatekey] ;
    return kei.boolValue;
}
+ (void)saveDetailTate:(NSNumber *)kei{
    [[NSUserDefaults standardUserDefaults] setObject:kei forKey:NADetailTatekey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL )getDetailTate{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NADetailTatekey] ;
    return kei.boolValue;
}
+ (void)saveSearchFastNewsRows:(NSNumber *)kei{
    [[NSUserDefaults standardUserDefaults] setObject:kei forKey:NASearchFastNewsRowskey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger )getSearchFastNewsRows{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NASearchFastNewsRowskey] ;
    return kei.floatValue;
}
+ (NSString *)saveTimeStamp
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NASaveLoginTimeStamp];
}

+ (NSInteger)getFontNum
{
    NSNumber *save  = [[NSUserDefaults standardUserDefaults] objectForKey:NAFrontNum];
    if (save) {
        return save.intValue;
    }
    return 1;
}
+ (void)saveFontNum:(NSInteger )oIndex
{
    [[NSUserDefaults standardUserDefaults] setInteger:oIndex forKey:NAFrontNum];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getExpansion_rateNum
{
    NSNumber *save  = [[NSUserDefaults standardUserDefaults] objectForKey:NAExpansion_rateNum];
    if (save) {
        return save.intValue;
    }
    return 1;
}
+ (void)saveExpansion_rateNum:(NSInteger )oIndex
{
    [[NSUserDefaults standardUserDefaults] setInteger:oIndex forKey:NAExpansion_rateNum];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getSpanIndex
{
    NSNumber *save  = [[NSUserDefaults standardUserDefaults] objectForKey:NASpanNum];
    if (save) {
        return save.intValue;
    }
    return 1;
}
+ (void)saveSpanIndex:(NSInteger )oIndex
{
    [[NSUserDefaults standardUserDefaults] setInteger:oIndex forKey:NASpanNum];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSInteger)getSokuhoFontNum{
    NSNumber *save  = [[NSUserDefaults standardUserDefaults] objectForKey:NASokuhoFrontNum];
    if (save) {
        return save.intValue;
    }
    return 1;
}
+ (void)saveSokuhoFontNum:(NSInteger)oIndex{
    [[NSUserDefaults standardUserDefaults] setInteger:oIndex forKey:NASokuhoFrontNum];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSInteger)getFontSize:(NSInteger )oIndex
{
    NSArray *save  = [[NSUserDefaults standardUserDefaults] objectForKey:NAFrontSize];
    if (save) {
        NSString *size=[save objectAtIndex:oIndex];
        return [size integerValue];
    }
    return 17;
}

+ (NSInteger)getCurFontSize
{
    NSArray *save  = [[NSUserDefaults standardUserDefaults] objectForKey:NAFrontSize];
    
    if (save) {
        NSNumber *oIndex  = [[NSUserDefaults standardUserDefaults] objectForKey:NAFrontNum];
         NSString *size=[save objectAtIndex:oIndex.intValue];
        return size.intValue;
    }
    return 17;
}

+ (void)saveSpans:(NSString *)value
{
    NSArray *array = [value componentsSeparatedByString:@","];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:NASpans];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getSpanNum:(NSInteger )oIndex
{
    NSArray *save  = [[NSUserDefaults standardUserDefaults] objectForKey:NASpans];
    if (save) {
        NSString *size=[save objectAtIndex:oIndex];
        return [size integerValue];
    }
    return 3;
}
+ (NSInteger)getCurSpanNum
{
    NSArray *save  = [[NSUserDefaults standardUserDefaults] objectForKey:NASpans];
    
    if (save) {
        NSNumber *oIndex  = [[NSUserDefaults standardUserDefaults] objectForKey:NASpanNum];
        NSString *size=[save objectAtIndex:oIndex.intValue];
        return size.intValue;
    }
    return 3;
}
+ (void)saveFontSize:(NSString *)value
{
    NSArray *array = [value componentsSeparatedByString:@","];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:NAFrontSize];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getSokuhoFontSize:(NSInteger )oIndex{
    NSArray *save  = [[NSUserDefaults standardUserDefaults] objectForKey:NASokuhoFrontSize];
    if (save) {
        NSString *size=[save objectAtIndex:oIndex];
        return [size integerValue];
    }
    return 17;
}
+ (NSInteger)getSokuhoCurFontSize{
    NSArray *save  = [[NSUserDefaults standardUserDefaults] objectForKey:NASokuhoFrontSize];
    
    if (save) {
        NSNumber *oIndex  = [[NSUserDefaults standardUserDefaults] objectForKey:NASokuhoFrontNum];
        NSString *size=[save objectAtIndex:oIndex.intValue];
        return size.intValue;
    }
    return 17;
}
+ (void)saveSokuhoFontSize:(NSString *)value{
    NSArray *array = [value componentsSeparatedByString:@","];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:NASokuhoFrontSize];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)isFirst
{
    NSObject *save= [[NSUserDefaults standardUserDefaults] objectForKey:NAFrontSize];
    if (save ==nil) {
        return YES;
    }
    return NO;
}

+ (void)firstInit:(NSDictionary *)value
{
    NSString *font_size = [value objectForKey:@"font_size"];
    NSNumber *font_num = [value objectForKey:@"font_num"];
    
    NSString *spannum = [value objectForKey:@"span.num"];
    NSNumber *spanindex = [value objectForKey:@"span.index"];
    
    [self saveFontNum:font_num.intValue];
    [self saveFontSize:font_size];
    [self saveSpanIndex:spanindex.intValue];
    [self saveSpans:spannum];
}

+ (NSDictionary *)getALLUser{
     return [[NSUserDefaults standardUserDefaults] objectForKey:ALLUserKey];
}
+ (void)saveALLUser:(NSDictionary *)ALLUser{
    [[NSUserDefaults standardUserDefaults] setObject:ALLUser forKey:ALLUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NADoc *)getCurrentDoc{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSData *data = [user objectForKey:CURRENT_DOC];
    if ([self getIsUseCurrentDoc]) {
        NADoc *doc = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return doc;
    }else{
        return nil;
    }
    
}
+ (void)saveCurrentDoc:(NADoc *)currentDoc{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:currentDoc];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:data forKey:CURRENT_DOC];
}
+ (void)saveIsUseCurrentDoc:(NSNumber *)kei{
    [[NSUserDefaults standardUserDefaults] setObject:kei forKey:NAFastNewsTatekey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL )getIsUseCurrentDoc{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NAFastNewsTatekey] ;
    return kei.boolValue;
}

+ (NSString *)getDefaultUserID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NADEFAULTUSERID];
}
+ (void)saveDefaultUserID:(NSString *)userID{
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:NADEFAULTUSERID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getDefaultUserPass{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NADEFAULTUSERPASS];
}
+ (void)saveDefaultUserPass:(NSString *)pass{
    [[NSUserDefaults standardUserDefaults] setObject:pass forKey:NADEFAULTUSERPASS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)agreeMentVersion{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NAAGREEMENTVERSION];
}
+ (void)saveAgreeMentVersion:(NSString *)version{
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:NAAGREEMENTVERSION];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getWuliaoPublicationInfoId{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NAWULIAOPUBLICATIONINFOID];
}
+ (void)saveWuliaoPublicationInfoId:(NSString *)publicationInfoId{
    [[NSUserDefaults standardUserDefaults] setObject:publicationInfoId forKey:NAWULIAOPUBLICATIONINFOID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)saveIsVisitorModel:(BOOL )isVisitorModel{
    [[NSUserDefaults standardUserDefaults] setBool:isVisitorModel forKey:NAISVISITORMODEL];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+ (BOOL)getIsVisitorModel{
     return [[NSUserDefaults standardUserDefaults] boolForKey:NAISVISITORMODEL];
}
+ (void)saveIsPublication:(BOOL )IsPublication{
    [[NSUserDefaults standardUserDefaults] setBool:IsPublication forKey:NAISPUBLICATION];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getIsPublication{
     return [[NSUserDefaults standardUserDefaults] boolForKey:NAISPUBLICATION];
}

+ (NSString *)getToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NASAVETOKENKEY];
}
+ (void)saveToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:NASAVETOKENKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getSendTokenUrl{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NASENDTOKENURL];
}
+ (void)saveSendTokenUrl:(NSString *)sendUrl{
    [[NSUserDefaults standardUserDefaults] setObject:sendUrl forKey:NASENDTOKENURL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)saveIsSendTokenSuccess:(BOOL )IsSuccess{
    [[NSUserDefaults standardUserDefaults] setBool:IsSuccess forKey:NAISSENDTOKENSUCCESS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getIsSendTokenSuccess{
     return [[NSUserDefaults standardUserDefaults] boolForKey:NAISSENDTOKENSUCCESS];
}
+ (BOOL)getIsSwipeViewShowHighImage{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NAISSWIPEVIEWSHOWHIGHIMAGE] ;
    if (kei) {
        return kei.boolValue;
    }else{
        return NO;
    }
    
}
+ (void)saveIsSwipeViewShowHighImage:(NSNumber *)isShow{
    [[NSUserDefaults standardUserDefaults] setObject:isShow forKey:NAISSWIPEVIEWSHOWHIGHIMAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getIsHaveSearchOrderNO{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NAISHAVESEARCHORDERNO] ;
    return kei.boolValue;
}
+ (void)saveIsHaveSearchOrderNO:(NSNumber *)isShow{
    [[NSUserDefaults standardUserDefaults] setObject:isShow forKey:NAISHAVESEARCHORDERNO];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getIsShowAgreeMent{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NAISSHOWAGREEMENT] ;
    return kei.boolValue;
}
+ (void)saveIsShowAgreeMent:(NSNumber *)isShow{
    [[NSUserDefaults standardUserDefaults] setObject:isShow forKey:NAISSHOWAGREEMENT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getIsShowSearchPage{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NAISSHOWSEARCHPAGE] ;
    return kei.boolValue;
}
+ (void)saveIsShowSearchPage:(NSNumber *)isShow{
    [[NSUserDefaults standardUserDefaults] setObject:isShow forKey:NAISSHOWSEARCHPAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getIsHaveWebBtn{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NAISHAVEWEBBTN] ;
    if ([NACheckNetwork sharedInstance].isHavenetwork) {
        return kei.boolValue;
    }else{
        return NO;
    }
}
+ (void)saveIsHaveWebBtn:(NSNumber *)isShow{
    [[NSUserDefaults standardUserDefaults] setObject:isShow forKey:NAISHAVEWEBBTN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+ (BOOL)getIsHaveExtraImage{
    NSNumber *kei = [[NSUserDefaults standardUserDefaults] objectForKey:NAISHAVEEXTRAIMAGE];
    if ([NACheckNetwork sharedInstance].isHavenetwork) {
        return kei.boolValue;
    }else{
        return NO;
    }
    
}
+ (void)saveIsHaveExtraImage:(NSNumber *)isShow{
    [[NSUserDefaults standardUserDefaults] setObject:isShow forKey:NAISHAVEEXTRAIMAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+ (NSString *)getWebUrl{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NAWEBURL];
}
+ (void)saveWebUrl:(NSString *)sendUrl{
    [[NSUserDefaults standardUserDefaults] setObject:sendUrl forKey:NAWEBURL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getExtraUrl{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NAEXTRAURL];
}
+ (void)saveExtraUrl:(NSString *)sendUrl{
    [[NSUserDefaults standardUserDefaults] setObject:sendUrl forKey:NAEXTRAURL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getTopUrl{
    return [[NSUserDefaults standardUserDefaults] objectForKey:TOPURL];
}
+ (void)saveTopUrl:(NSString *)sendUrl{
    [[NSUserDefaults standardUserDefaults] setObject:sendUrl forKey:TOPURL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end

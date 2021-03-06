
#import <Foundation/Foundation.h>
#define  isAutologin @"isautologin"
#define  isHaveNoteKey @"isHaveNote"
#define  ALLUserKey @"ALLUserKey"
#define  CURRENT_DOC @"currentDoc"


@interface NASaveData : NSObject
@property(nonatomic,strong)NSArray *masterArray;
@property (nonatomic, readwrite)NSNumber *isAlldownloadNum;
+ (NASaveData *)sharedInstance;
//login
+ (BOOL)isLogin;
+ (NSString *)getLoginUserId;
+ (NSString *)getLoginPassWord;
+ (void)SaveLoginWithID:(NSString *)loginID
           withPassWord:(NSString *)loginPassWord;

+ (NSString *)getReleaseAreaInfo;
+ (void)saveReleaseAreaInfo:(NSString *)releaseAreaInfo;
+ (NSString *)getDataPublishDayInfo;
+ (void)saveDataPublishDayInfo:(NSString *)publishDayInfo;
+ (NSString *)getDataUserClass;
+ (void)saveDataUserClass:(NSString *)userClass;

+(void)saveUserId:(NSString *)loginID;
+ (void)clearLoginInfo;
+ (BOOL)isSaveUserInfo;
+ (void)saveUserInfo:(NSNumber *)isSave;
+ (BOOL)isAgreeMent;
+ (void)saveIsAgreeMent:(NSNumber *)isSave;

+ (void)saveTimeStamp:(NSString *)timeStamp;
+ (BOOL)isSaveTimeStamp;
+ (NSString *)saveTimeStamp;

+ (void)InformationUrl:(NSString *)url;
+ (NSString *)getInformationUrl;
+ (void)saveLandscapekei:(NSNumber *)kei;
+ (CGFloat)getLandscapekei;
+ (void)saveBarShowInterval:(NSNumber *)kei;
+ (CGFloat )getBarShowInterval;

+ (void)saveTimeoutInterval:(NSNumber *)kei;
+ (CGFloat )getTimeoutInterval;

+ (void)saveFastNewsRows:(NSNumber *)kei;
+ (NSInteger )getFastNewsRows;
+ (void)saveSearchFastNewsRows:(NSNumber *)kei;
+ (NSInteger )getSearchFastNewsRows;

+ (void)saveNotClearDays:(NSNumber *)kei;
+ (NSInteger)getNotClearDays;

+ (void)saveDetailTate:(NSNumber *)kei;
+ (BOOL)getDetailTate;

+ (void)saveFastNewsTate:(NSNumber *)kei;
+ (BOOL)getFastNewsTate;

+ (BOOL)isAlldownload;
+ (void)saveAlldownload:(NSNumber *)isSave;

+ (BOOL)getIsAutologin;
+ (void)saveAutologin:(BOOL)isSave;

+ (NSInteger)getSpanNum:(NSInteger )oIndex;
+ (NSInteger)getCurSpanNum;
+ (void)saveSpans:(NSString *)value;

+ (NSInteger)getSpanIndex;
+ (void)saveSpanIndex:(NSInteger )oIndex;


+ (NSInteger)getFontNum;
+ (void)saveFontNum:(NSInteger)oIndex;

+ (NSInteger)getFontSize:(NSInteger )oIndex;
+ (NSInteger)getCurFontSize;
+ (void)saveFontSize:(NSString *)value;

+ (NSInteger)getSokuhoFontNum;
+ (void)saveSokuhoFontNum:(NSInteger)oIndex;

+ (NSInteger)getFirstDownload;
+ (void)saveFirstDownload:(NSNumber *)oIndex;

+ (NSInteger)getISFastNews;
+ (void)saveISFastNews:(NSNumber *)oIndex;

+ (NSInteger)getClipSelectedBtnTag;
+ (void)saveClipSelectedBtnTag:(NSInteger)tag;

+ (NSInteger)getSokuhoFontSize:(NSInteger )oIndex;
+ (NSInteger)getSokuhoCurFontSize;
+ (void)saveSokuhoFontSize:(NSString *)value;

+ (BOOL)isFirst;
+ (void)firstInit:(NSDictionary *)value;
+ (BOOL)isHaveNote;


+ (NSString *)getExpansion_rate;
+ (void)saveExpansion_rate:(NSString *)isSave;

+ (NSDictionary *)getALLUser;
+ (void)saveALLUser:(NSDictionary *)ALLUser;

+ (NSString *)getDataServerProtocol;
+ (void)saveDataServerProtocol:(NSString *)isSave;

+ (NSString *)getImageServerProtocol;
+ (void)saveImageServerProtocol:(NSString *)isSave;

+ (NADoc *)getCurrentDoc;
+ (void)saveCurrentDoc:(NADoc *)currentDoc;

+ (void)saveIsUseCurrentDoc:(NSNumber *)kei;
+ (BOOL)getIsUseCurrentDoc;

+ (NSString *)getDefaultUserID;
+ (void)saveDefaultUserID:(NSString *)userID;
+ (NSString *)getDefaultUserPass;
+ (void)saveDefaultUserPass:(NSString *)pass;

+ (NSString *)agreeMentVersion;
+ (void)saveAgreeMentVersion:(NSString *)version;

+ (void)saveIsVisitorModel:(BOOL )isVisitorModel;
+ (BOOL)getIsVisitorModel;

+ (void)saveIsPublication:(BOOL )IsPublication;
+ (BOOL)getIsPublication;

+ (NSString *)getWuliaoPublicationInfoId;
+ (void)saveWuliaoPublicationInfoId:(NSString *)publicationInfoId;

+ (NSString *)getToken;
+ (void)saveToken:(NSString *)token;

+ (NSString *)getSendTokenUrl;
+ (void)saveSendTokenUrl:(NSString *)sendUrl;

+ (void)saveIsSendTokenSuccess:(BOOL )IsSuccess;
+ (BOOL)getIsSendTokenSuccess;

+ (NSInteger)getExpansion_rateNum;
+ (void)saveExpansion_rateNum:(NSInteger )oIndex;

+ (BOOL)getIsSwipeViewShowHighImage;
+ (void)saveIsSwipeViewShowHighImage:(NSNumber *)isShow;

//key NAISHAVESEARCHORDERNO
+ (BOOL)getIsHaveSearchOrderNO;
+ (void)saveIsHaveSearchOrderNO:(NSNumber *)isShow;
//key NAISSHOWAGREEMENT
+ (BOOL)getIsShowAgreeMent;
+ (void)saveIsShowAgreeMent:(NSNumber *)isShow;
//key NAISSHOWSEARCHPAGE
+ (BOOL)getIsShowSearchPage;
+ (void)saveIsShowSearchPage:(NSNumber *)isShow;
//key NAISHAVEWEBBTN
+ (BOOL)getIsHaveWebBtn;
+ (void)saveIsHaveWebBtn:(NSNumber *)isShow;
//key NAISHAVEEXTRAIMAGE
+ (BOOL)getIsHaveExtraImage;
+ (void)saveIsHaveExtraImage:(NSNumber *)isShow;
//key NAWEBURL
+ (NSString *)getWebUrl;
+ (void)saveWebUrl:(NSString *)sendUrl;
//key NAEXTRAURL
+ (NSString *)getExtraUrl;
+ (void)saveExtraUrl:(NSString *)sendUrl;
//key TOPURL
+ (NSString *)getTopUrl;
+ (void)saveTopUrl:(NSString *)sendUrl;
@end

//
//  NADoc.m
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NADoc.h"


NSString *const kNADocPublishDate = @"PublishDate";
NSString *const kNADocPublisherInfoId = @"PublisherInfoId";
NSString *const kNADocMiniPagePath = @"MiniPagePath";
NSString *const kNADocPagePath3 = @"PagePath3";
NSString *const kNADocChangeImageInfo = @"ChangeImageInfo";
NSString *const kNADocPageInfoId = @"PageInfoId";
NSString *const kNADocPageno = @"Pageno";
NSString *const kNADocPublicationInfoId = @"PublicationInfoId";
NSString *const kNADocContentType = @"ContentType";
NSString *const kNADocIndexNo = @"IndexNo";
NSString *const kNADocPublisherGroupInfoId = @"PublisherGroupInfoId";
NSString *const kNADocPagePath4 = @"PagePath4";
NSString *const kNADocVariableString31 = @"VariableString31";
NSString *const kNADocEditionInfoId = @"EditionInfoId";
NSString *const kNADocVariableString32 = @"VariableString32";
NSString *const kNADocVariableString33 = @"VariableString33";
NSString *const kNADocPrintRevisionInfoId = @"PrintRevisionInfoId";
NSString *const kNADocPublishRegionInfoId = @"PublishRegionInfoId";

NSString *const kNADocKID = @"K_ID";
NSString *const kNADocVariableBoolean01 = @"VariableBoolean01";
NSString *const kNADocHeadlineText = @"HeadlineText";
NSString *const kNADocNewsText = @"NewsText";
NSString *const kNADocCaption = @"Caption";
NSString *const kNADocLocationInfoPosX = @"LocationInfoPosX";
NSString *const kNADocLocationInfoPosY = @"LocationInfoPosY";
NSString *const kNADocCompositionWidth = @"CompositionWidth";
NSString *const kNADocCompositionHeight = @"CompositionHeight";
NSString *const kNADocPublisherGroupInfoName = @"PublisherGroupInfoName";
NSString *const kNADocPublisherInfoName = @"PublisherInfoName";
NSString *const kNADocPublicationInfoName = @"PublicationInfoName";
NSString *const kNADocPublishRegionInfoName = @"PublishRegionInfoName";
NSString *const kNADocEditionInfoName = @"EditionInfoName";
NSString *const kNADocPageInfoName = @"PageInfoName";
NSString *const kNADocPrintRevisionInfoName = @"PrintRevisionInfoName";
NSString *const kNADocNewsflashFlg = @"NewsflashFlg";
NSString *const kNADocRankGetDateTime = @"RankGetDateTime";
NSString *const kNADocFlashScore = @"FlashScore";
NSString *const kNADocImportance = @"Importance";
NSString *const kNADocRank = @"Rank";
NSString *const kNADocPublishingHistoryInfoContentIdPaperInfo = @"PublishingHistoryInfoContentId_PaperInfo";
NSString *const kNADocPublishingHistoryInfoContentId_NewsInfo = @"PublishingHistoryInfoContentId_NewsInfo";
NSString *const kNADocPublishingHistoryInfoContentId_Picture = @"PublishingHistoryInfoContentId_Picture";
NSString *const kNADocPublishingHistoryInfoContentIdAds = @"PublishingHistoryInfoContentId_Ads";
NSString *const kNADocPublishingHistoryInfoPictorialValue = @"PublishingHistoryInfoPictorialValue";
NSString *const kNADocPageComment = @"PageComment";
NSString *const kNADocNewsGroupTitle = @"NewsGroupTitle";
NSString *const kNADocLastUpdateDateAndTime = @"LastUpdateDateAndTime";
NSString *const kNADocTurnPageDirection = @"TurnPageDirection";
NSString *const kNADocTategakiFlg = @"TategakiFlg";
NSString *const kNADocReceivedDateAndTime = @"ReceivedDateAndTime";
NSString *const kNADocImageLLastModified = @"Image_L_LastModified";
NSString *const kNADocPhotoPathC = @"PhotoPathC";
NSString *const kNADocPhotoPathD = @"PhotoPathD";
NSString *const kNADocMiniPhotoPath = @"MiniPhotoPath";
NSString *const kNADocTitle = @"Title";
NSString *const kNADocRelatedInfo3 = @"RelatedInfo3";
NSString *const kNADocTeiseiInfoId = @"TeiseiInfoId";
NSString *const kNADocTeiseiInfoName = @"TeiseiInfoName";
NSString *const kNAGenreName = @"GenreName";
NSString *const kNAGenreId = @"GenreId";
//add new
NSString *const kNAReleaseAreaInfo = @"ReleaseAreaInfo";
NSString *const kNAClippingImgPath = @"ClipImagePath";
NSString *const kNAPublishDayInfo = @"PublishDayInfo";
NSString *const kNARegionViewFlg = @"RegionViewFlg";
@interface NADoc ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NADoc

@synthesize publishDate = _publishDate;
@synthesize publisherInfoId = _publisherInfoId;
@synthesize miniPagePath = _miniPagePath;
@synthesize pagePath3 = _pagePath3;
@synthesize changeImageInfo = _changeImageInfo;
@synthesize pageInfoId = _pageInfoId;
@synthesize pageno = _pageno;
@synthesize publicationInfoId = _publicationInfoId;
@synthesize contentType = _contentType;
@synthesize indexNo = _indexNo;
@synthesize publisherGroupInfoId = _publisherGroupInfoId;
@synthesize pagePath4 = _pagePath4;
@synthesize variableString31 = _variableString31;
@synthesize editionInfoId = _editionInfoId;
@synthesize variableString32 = _variableString32;
@synthesize variableString33 = _variableString33;
@synthesize printRevisionInfoId = _printRevisionInfoId;
@synthesize publishRegionInfoId = _publishRegionInfoId;
@synthesize k_ID = _k_ID;
@synthesize variableBoolean01 = _variableBoolean01;
@synthesize headlineText = _headlineText;
@synthesize newsText = _newsText;
@synthesize caption = _caption;
@synthesize locationInfoPosX = _locationInfoPosX;
@synthesize locationInfoPosY = _locationInfoPosY;
@synthesize compositionWidth = _compositionWidth;
@synthesize compositionHeight = _compositionHeight;
@synthesize publisherGroupInfoName = _publisherGroupInfoName;
@synthesize publisherInfoName = _publisherInfoName;
@synthesize publicationInfoName = _publicationInfoName;
@synthesize publishRegionInfoName = _publishRegionInfoName;
@synthesize editionInfoName = _editionInfoName;
@synthesize pageInfoName = _pageInfoName;
@synthesize printRevisionInfoName = _printRevisionInfoName;
@synthesize newsflashFlg = _newsflashFlg;
@synthesize rankGetDateTime = _rankGetDateTime;



@synthesize flashScore = _flashScore;
@synthesize importance = _importance;
@synthesize rank = _rank;
@synthesize publishingHistoryInfoContentIdPaperInfo = _publishingHistoryInfoContentIdPaperInfo;
@synthesize publishingHistoryInfoContentIdNewsInfo = _publishingHistoryInfoContentIdNewsInfo;
@synthesize publishingHistoryInfoContentIdPicture = _publishingHistoryInfoContentIdPicture;
@synthesize publishingHistoryInfoContentIdAds = _publishingHistoryInfoContentIdAds;
@synthesize publishingHistoryInfoPictorialValue = _publishingHistoryInfoPictorialValue;
@synthesize pageComment = _pageComment;
@synthesize newsGroupTitle = _newsGroupTitle;
@synthesize lastUpdateDateAndTime = _lastUpdateDateAndTime;
@synthesize turnPageDirection = _turnPageDirection;
@synthesize tategakiFlg = _tategakiFlg;
@synthesize receivedDateAndTime = _receivedDateAndTime;
@synthesize image_L_LastModified = _image_L_LastModified;
@synthesize photoPathC = _photoPathC;
@synthesize photoPathD = _photoPathD;
@synthesize miniPhotoPath = _miniPhotoPath;
@synthesize title = _title;
@synthesize relatedInfo3 = _relatedInfo3;
@synthesize teiseiInfoId = _teiseiInfoId;
@synthesize teiseiInfoName = _teiseiInfoName;


@synthesize iselecton;
@synthesize whichimage;
@synthesize thumbimage;
@synthesize notearray;

@synthesize t_id;
@synthesize user_id;
//add new
@synthesize releaseAreaInfo = _releaseAreaInfo;
@synthesize clippingImgPath = _clippingImgPath;
@synthesize publishDayInfo = _publishDayInfo;
@synthesize regionViewFlg = _regionViewFlg;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.publishDate = [self objectOrNilForKey:kNADocPublishDate fromDictionary:dict];
            self.publisherInfoId = [self objectOrNilForKey:kNADocPublisherInfoId fromDictionary:dict];
            self.miniPagePath = [CharUtil getRightUrl:[self stringOrNilForKey:kNADocMiniPagePath fromDictionary:dict]];
            self.pagePath3 = [CharUtil getRightUrl:[self stringOrNilForKey:kNADocPagePath3 fromDictionary:dict]];
    
            self.changeImageInfo = [self objectOrNilForKey:kNADocChangeImageInfo fromDictionary:dict];
            self.pageInfoId = [self objectOrNilForKey:kNADocPageInfoId fromDictionary:dict];
            self.pageno = [self objectOrNilForKey:kNADocPageno fromDictionary:dict];
            self.publicationInfoId = [self objectOrNilForKey:kNADocPublicationInfoId fromDictionary:dict];
            self.contentType = [self objectOrNilForKey:kNADocContentType fromDictionary:dict];
            self.indexNo = [self objectOrNilForKey:kNADocIndexNo fromDictionary:dict];
            self.publisherGroupInfoId = [self objectOrNilForKey:kNADocPublisherGroupInfoId fromDictionary:dict];
            self.pagePath4 = [CharUtil getRightUrl:[self stringOrNilForKey:kNADocPagePath4 fromDictionary:dict]];
            self.variableString31 = [self stringOrNilForKey:kNADocVariableString31 fromDictionary:dict];
            self.editionInfoId = [self objectOrNilForKey:kNADocEditionInfoId fromDictionary:dict];
            self.variableString32 = [self objectOrNilForKey:kNADocVariableString32 fromDictionary:dict];
            self.variableString33 = [self objectOrNilForKey:kNADocVariableString33 fromDictionary:dict];
            self.printRevisionInfoId = [self objectOrNilForKey:kNADocPrintRevisionInfoId fromDictionary:dict];
            self.publishRegionInfoId = [self objectOrNilForKey:kNADocPublishRegionInfoId fromDictionary:dict];
        
        

        self.k_ID = [self objectOrNilForKey:kNADocKID fromDictionary:dict];
        self.variableBoolean01 = [self objectOrNilForKey:kNADocVariableBoolean01 fromDictionary:dict];
        self.headlineText = [self objectOrNilForKey:kNADocHeadlineText fromDictionary:dict];
        NSString *myNewsText=[self stringOrNilForKey:kNADocNewsText fromDictionary:dict];
        self.newsText = myNewsText.length==0 ? NSLocalizedString(@"NO NewsText", nil):myNewsText;
        self.caption = [self objectOrNilForKey:kNADocCaption fromDictionary:dict];
        self.locationInfoPosX = [self objectOrNilForKey:kNADocLocationInfoPosX fromDictionary:dict];
        self.locationInfoPosY = [self objectOrNilForKey:kNADocLocationInfoPosY fromDictionary:dict];
        self.compositionWidth = [self objectOrNilForKey:kNADocCompositionWidth fromDictionary:dict];
        self.compositionHeight = [self objectOrNilForKey:kNADocCompositionHeight fromDictionary:dict];
        self.publisherGroupInfoName = [self objectOrNilForKey:kNADocPublisherGroupInfoName fromDictionary:dict];
        self.publisherInfoName = [self objectOrNilForKey:kNADocPublisherInfoName fromDictionary:dict];
        self.publicationInfoName = [self objectOrNilForKey:kNADocPublicationInfoName fromDictionary:dict];
        self.publishRegionInfoName = [self objectOrNilForKey:kNADocPublishRegionInfoName fromDictionary:dict];
        self.editionInfoName = [self stringOrNilForKey:kNADocEditionInfoName fromDictionary:dict];
        self.pageInfoName = [self objectOrNilForKey:kNADocPageInfoName fromDictionary:dict];
        self.printRevisionInfoName = [self objectOrNilForKey:kNADocPrintRevisionInfoName fromDictionary:dict];
        self.newsflashFlg = [self objectOrNilForKey:kNADocNewsflashFlg fromDictionary:dict];
        self.rankGetDateTime = [self objectOrNilForKey:kNADocRankGetDateTime fromDictionary:dict];
        self.flashScore = [self objectOrNilForKey:kNADocFlashScore fromDictionary:dict];
        self.importance = [self objectOrNilForKey:kNADocImportance fromDictionary:dict];
        self.rank = [self objectOrNilForKey:kNADocRank fromDictionary:dict];
        self.publishingHistoryInfoContentIdPaperInfo = [self objectOrNilForKey:kNADocPublishingHistoryInfoContentIdPaperInfo fromDictionary:dict];
        
        self.publishingHistoryInfoContentIdNewsInfo = [self objectOrNilForKey:kNADocPublishingHistoryInfoContentId_NewsInfo fromDictionary:dict];
        self.publishingHistoryInfoContentIdPicture = [self objectOrNilForKey:kNADocPublishingHistoryInfoContentId_Picture fromDictionary:dict];
        self.publishingHistoryInfoContentIdAds = [self objectOrNilForKey:kNADocPublishingHistoryInfoContentIdAds fromDictionary:dict];
        self.publishingHistoryInfoPictorialValue = [self objectOrNilForKey:kNADocPublishingHistoryInfoPictorialValue fromDictionary:dict];
        self.pageComment = [self objectOrNilForKey:kNADocPageComment fromDictionary:dict];
        self.newsGroupTitle = [self objectOrNilForKey:kNADocNewsGroupTitle fromDictionary:dict];
        self.lastUpdateDateAndTime = [self objectOrNilForKey:kNADocLastUpdateDateAndTime fromDictionary:dict];
        self.turnPageDirection = [self objectOrNilForKey:kNADocTurnPageDirection fromDictionary:dict];
        self.tategakiFlg = [self objectOrNilForKey:kNADocTategakiFlg fromDictionary:dict];
        self.receivedDateAndTime = [self objectOrNilForKey:kNADocReceivedDateAndTime fromDictionary:dict];
        self.image_L_LastModified = [self objectOrNilForKey:kNADocImageLLastModified fromDictionary:dict];
        self.photoPathC = [self objectOrNilForKey:kNADocPhotoPathC fromDictionary:dict];
        self.photoPathD = [self objectOrNilForKey:kNADocPhotoPathD fromDictionary:dict];
        self.miniPhotoPath = [self objectOrNilForKey:kNADocMiniPhotoPath fromDictionary:dict];
        self.title = [self objectOrNilForKey:kNADocTitle fromDictionary:dict];
        self.relatedInfo3 = [self objectOrNilForKey:kNADocRelatedInfo3 fromDictionary:dict];
        self.teiseiInfoId = [self objectOrNilForKey:kNADocTeiseiInfoId fromDictionary:dict];
        self.teiseiInfoName = [self objectOrNilForKey:kNADocTeiseiInfoName fromDictionary:dict];


        //add new
        self.releaseAreaInfo = [self objectOrNilForKey:kNAReleaseAreaInfo fromDictionary:dict];
        self.clippingImgPath = [self objectOrNilForKey:kNAClippingImgPath fromDictionary:dict];
        self.publishDayInfo = [self objectOrNilForKey:kNAPublishDayInfo fromDictionary:dict];
        self.regionViewFlg = [self objectOrNilForKey:kNARegionViewFlg fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.publishDate forKey:kNADocPublishDate];
    [mutableDict setValue:self.publisherInfoId forKey:kNADocPublisherInfoId];
    [mutableDict setValue:self.miniPagePath forKey:kNADocMiniPagePath];
    [mutableDict setValue:self.pagePath3 forKey:kNADocPagePath3];
    [mutableDict setValue:self.changeImageInfo forKey:kNADocChangeImageInfo];
    [mutableDict setValue:self.pageInfoId forKey:kNADocPageInfoId];
    [mutableDict setValue:self.pageno forKey:kNADocPageno];
    [mutableDict setValue:self.publicationInfoId forKey:kNADocPublicationInfoId];
    [mutableDict setValue:self.contentType forKey:kNADocContentType];
    [mutableDict setValue:self.indexNo forKey:kNADocIndexNo];
    [mutableDict setValue:self.publisherGroupInfoId forKey:kNADocPublisherGroupInfoId];
    [mutableDict setValue:self.pagePath4 forKey:kNADocPagePath4];
    [mutableDict setValue:self.variableString31 forKey:kNADocVariableString31];
    [mutableDict setValue:self.editionInfoId forKey:kNADocEditionInfoId];
    [mutableDict setValue:self.variableString32 forKey:kNADocVariableString32];
    [mutableDict setValue:self.variableString33 forKey:kNADocVariableString33];
    [mutableDict setValue:self.printRevisionInfoId forKey:kNADocPrintRevisionInfoId];
    [mutableDict setValue:self.publishRegionInfoId forKey:kNADocPublishRegionInfoId];


    
    
    [mutableDict setValue:self.k_ID forKey:kNADocKID];
    [mutableDict setValue:self.variableBoolean01 forKey:kNADocVariableBoolean01];
    [mutableDict setValue:self.headlineText forKey:kNADocHeadlineText];
    [mutableDict setValue:self.newsText forKey:kNADocNewsText];
    [mutableDict setValue:self.caption forKey:kNADocCaption];
    [mutableDict setValue:self.locationInfoPosX forKey:kNADocLocationInfoPosX];
    [mutableDict setValue:self.locationInfoPosY forKey:kNADocLocationInfoPosY];
    [mutableDict setValue:self.compositionWidth forKey:kNADocCompositionWidth];
    [mutableDict setValue:self.compositionHeight forKey:kNADocCompositionHeight];
    [mutableDict setValue:self.publisherGroupInfoName forKey:kNADocPublisherGroupInfoName];
    [mutableDict setValue:self.publisherInfoName forKey:kNADocPublisherInfoName];
    [mutableDict setValue:self.publicationInfoName forKey:kNADocPublicationInfoName];
    [mutableDict setValue:self.publishRegionInfoName forKey:kNADocPublishRegionInfoName];
    [mutableDict setValue:self.editionInfoName forKey:kNADocEditionInfoName];
    [mutableDict setValue:self.pageInfoName forKey:kNADocPageInfoName];
    [mutableDict setValue:self.printRevisionInfoName forKey:kNADocPrintRevisionInfoName];
    [mutableDict setValue:self.newsflashFlg forKey:kNADocNewsflashFlg];
    [mutableDict setValue:self.rankGetDateTime forKey:kNADocRankGetDateTime];
    [mutableDict setValue:self.flashScore forKey:kNADocFlashScore];
    [mutableDict setValue:self.importance forKey:kNADocImportance];
    [mutableDict setValue:self.rank forKey:kNADocRank];
    [mutableDict setValue:self.publishingHistoryInfoContentIdPaperInfo forKey:kNADocPublishingHistoryInfoContentIdPaperInfo];
    [mutableDict setValue:self.publishingHistoryInfoContentIdNewsInfo forKey:kNADocPublishingHistoryInfoContentId_NewsInfo];
    [mutableDict setValue:self.publishingHistoryInfoContentIdPaperInfo forKey:kNADocPublishingHistoryInfoContentId_Picture];
    [mutableDict setValue:self.publishingHistoryInfoContentIdAds forKey:kNADocPublishingHistoryInfoContentIdAds];
    [mutableDict setValue:self.publishingHistoryInfoPictorialValue forKey:kNADocPublishingHistoryInfoPictorialValue];
    [mutableDict setValue:self.pageComment forKey:kNADocPageComment];
    [mutableDict setValue:self.newsGroupTitle forKey:kNADocNewsGroupTitle];
    [mutableDict setValue:self.lastUpdateDateAndTime forKey:kNADocLastUpdateDateAndTime];
    [mutableDict setValue:self.turnPageDirection forKey:kNADocTurnPageDirection];
    [mutableDict setValue:self.tategakiFlg forKey:kNADocTategakiFlg];
    [mutableDict setValue:self.receivedDateAndTime forKey:kNADocReceivedDateAndTime];
    [mutableDict setValue:self.image_L_LastModified forKey:kNADocImageLLastModified];
    [mutableDict setValue:self.photoPathC forKey:kNADocPhotoPathC];
    [mutableDict setValue:self.photoPathD forKey:kNADocPhotoPathD];
    [mutableDict setValue:self.miniPhotoPath forKey:kNADocMiniPhotoPath];
    [mutableDict setValue:self.title forKey:kNADocTitle];
    [mutableDict setValue:self.relatedInfo3 forKey:kNADocRelatedInfo3];
    [mutableDict setValue:self.teiseiInfoId forKey:kNADocTeiseiInfoId];
    [mutableDict setValue:self.teiseiInfoName forKey:kNADocTeiseiInfoName];

    //add new
    [mutableDict setValue:self.releaseAreaInfo forKey:kNAReleaseAreaInfo];
    [mutableDict setValue:self.clippingImgPath forKey:kNAClippingImgPath];
    [mutableDict setValue:self.publishDayInfo forKey:kNAPublishDayInfo];
    [mutableDict setValue:self.regionViewFlg forKey:kNARegionViewFlg];
    
    
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}
- (id)stringOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isKindOfClass:[NSString class]] ? object : @"";
}

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.publishDate = [aDecoder decodeObjectForKey:kNADocPublishDate];
    self.publisherInfoId = [aDecoder decodeObjectForKey:kNADocPublisherInfoId];
    self.miniPagePath = [aDecoder decodeObjectForKey:kNADocMiniPagePath];
    self.pagePath3 = [aDecoder decodeObjectForKey:kNADocPagePath3];
    self.changeImageInfo = [aDecoder decodeObjectForKey:kNADocChangeImageInfo];
    self.pageInfoId = [aDecoder decodeObjectForKey:kNADocPageInfoId];
    self.pageno = [aDecoder decodeObjectForKey:kNADocPageno];
    self.publicationInfoId = [aDecoder decodeObjectForKey:kNADocPublicationInfoId];
    self.contentType = [aDecoder decodeObjectForKey:kNADocContentType];
    self.indexNo = [aDecoder decodeObjectForKey:kNADocIndexNo];
    self.publisherGroupInfoId = [aDecoder decodeObjectForKey:kNADocPublisherGroupInfoId];
    self.pagePath4 = [aDecoder decodeObjectForKey:kNADocPagePath4];
    self.variableString31 = [aDecoder decodeObjectForKey:kNADocVariableString31];
    self.editionInfoId = [aDecoder decodeObjectForKey:kNADocEditionInfoId];
    self.variableString32 = [aDecoder decodeObjectForKey:kNADocVariableString32];
    self.variableString33 = [aDecoder decodeObjectForKey:kNADocVariableString33];
    self.printRevisionInfoId = [aDecoder decodeObjectForKey:kNADocPrintRevisionInfoId];
    self.publishRegionInfoId = [aDecoder decodeObjectForKey:kNADocPublishRegionInfoId];

    self.k_ID = [aDecoder decodeObjectForKey:kNADocKID];
    self.variableBoolean01 = [aDecoder decodeObjectForKey:kNADocVariableBoolean01];
    self.headlineText = [aDecoder decodeObjectForKey:kNADocHeadlineText];
    self.newsText = [aDecoder decodeObjectForKey:kNADocNewsText];
    self.caption = [aDecoder decodeObjectForKey:kNADocCaption];
    self.locationInfoPosX = [aDecoder decodeObjectForKey:kNADocLocationInfoPosX];
    self.locationInfoPosY = [aDecoder decodeObjectForKey:kNADocLocationInfoPosY];
    self.compositionWidth = [aDecoder decodeObjectForKey:kNADocCompositionWidth];
    self.compositionHeight = [aDecoder decodeObjectForKey:kNADocCompositionHeight];
    self.publisherGroupInfoName = [aDecoder decodeObjectForKey:kNADocPublisherGroupInfoName];
    self.publisherInfoName = [aDecoder decodeObjectForKey:kNADocPublisherInfoName];
    self.publicationInfoName = [aDecoder decodeObjectForKey:kNADocPublicationInfoName];
    self.publishRegionInfoName = [aDecoder decodeObjectForKey:kNADocPublishRegionInfoName];
    self.editionInfoName = [aDecoder decodeObjectForKey:kNADocEditionInfoName];
    self.pageInfoName = [aDecoder decodeObjectForKey:kNADocPageInfoName];
    self.printRevisionInfoName = [aDecoder decodeObjectForKey:kNADocPrintRevisionInfoName];
    self.newsflashFlg = [aDecoder decodeObjectForKey:kNADocNewsflashFlg];
    self.rankGetDateTime = [aDecoder decodeObjectForKey:kNADocRankGetDateTime];
    self.flashScore = [aDecoder decodeObjectForKey:kNADocFlashScore];
    self.importance = [aDecoder decodeObjectForKey:kNADocImportance];
    self.rank = [aDecoder decodeObjectForKey:kNADocRank];
    self.publishingHistoryInfoContentIdPaperInfo = [aDecoder decodeObjectForKey:kNADocPublishingHistoryInfoContentIdPaperInfo];
    self.publishingHistoryInfoContentIdNewsInfo = [aDecoder decodeObjectForKey:kNADocPublishingHistoryInfoContentId_NewsInfo];
    self.publishingHistoryInfoContentIdPicture = [aDecoder decodeObjectForKey:kNADocPublishingHistoryInfoContentId_Picture];
    self.publishingHistoryInfoContentIdAds = [aDecoder decodeObjectForKey:kNADocPublishingHistoryInfoContentIdAds];
    self.publishingHistoryInfoPictorialValue = [aDecoder decodeObjectForKey:kNADocPublishingHistoryInfoPictorialValue];
    self.pageComment = [aDecoder decodeObjectForKey:kNADocPageComment];
    self.newsGroupTitle = [aDecoder decodeObjectForKey:kNADocNewsGroupTitle];
    self.lastUpdateDateAndTime = [aDecoder decodeObjectForKey:kNADocLastUpdateDateAndTime];
    self.turnPageDirection = [aDecoder decodeObjectForKey:kNADocTurnPageDirection];
    self.tategakiFlg = [aDecoder decodeObjectForKey:kNADocTategakiFlg];
    self.receivedDateAndTime = [aDecoder decodeObjectForKey:kNADocReceivedDateAndTime];
    self.image_L_LastModified = [aDecoder decodeObjectForKey:kNADocImageLLastModified];
    self.photoPathC = [aDecoder decodeObjectForKey:kNADocPhotoPathC];
    self.photoPathD = [aDecoder decodeObjectForKey:kNADocPhotoPathD];
    self.miniPhotoPath = [aDecoder decodeObjectForKey:kNADocMiniPhotoPath];
    self.title = [aDecoder decodeObjectForKey:kNADocTitle];
    self.relatedInfo3 = [aDecoder decodeObjectForKey:kNADocRelatedInfo3];
    self.teiseiInfoId = [aDecoder decodeObjectForKey:kNADocPrintRevisionInfoId];
    self.teiseiInfoName = [aDecoder decodeObjectForKey:kNADocTeiseiInfoName];

    
    //add new
    self.releaseAreaInfo = [aDecoder decodeObjectForKey:kNAReleaseAreaInfo];
    self.clippingImgPath = [aDecoder decodeObjectForKey:kNAClippingImgPath];
    self.publishDayInfo = [aDecoder decodeObjectForKey:kNAPublishDayInfo];
    self.regionViewFlg = [aDecoder decodeObjectForKey:kNARegionViewFlg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_publishDate forKey:kNADocPublishDate];
    [aCoder encodeObject:_publisherInfoId forKey:kNADocPublisherInfoId];
    [aCoder encodeObject:_miniPagePath forKey:kNADocMiniPagePath];
    [aCoder encodeObject:_pagePath3 forKey:kNADocPagePath3];
    [aCoder encodeObject:_changeImageInfo forKey:kNADocChangeImageInfo];
    [aCoder encodeObject:_pageInfoId forKey:kNADocPageInfoId];
    [aCoder encodeObject:_pageno forKey:kNADocPageno];
    [aCoder encodeObject:_publicationInfoId forKey:kNADocPublicationInfoId];
    [aCoder encodeObject:_contentType forKey:kNADocContentType];
    [aCoder encodeObject:_indexNo forKey:kNADocIndexNo];
    [aCoder encodeObject:_publisherGroupInfoId forKey:kNADocPublisherGroupInfoId];
    [aCoder encodeObject:_pagePath4 forKey:kNADocPagePath4];
    [aCoder encodeObject:_variableString31 forKey:kNADocVariableString31];
    [aCoder encodeObject:_editionInfoId forKey:kNADocEditionInfoId];
    [aCoder encodeObject:_variableString32 forKey:kNADocVariableString32];
    [aCoder encodeObject:_variableString33 forKey:kNADocVariableString33];
    [aCoder encodeObject:_printRevisionInfoId forKey:kNADocPrintRevisionInfoId];
    [aCoder encodeObject:_publishRegionInfoId forKey:kNADocPublishRegionInfoId];

    [aCoder encodeObject:_k_ID forKey:kNADocKID];
    [aCoder encodeObject:_variableBoolean01 forKey:kNADocVariableBoolean01];
    [aCoder encodeObject:_headlineText forKey:kNADocHeadlineText];
    [aCoder encodeObject:_newsText forKey:kNADocNewsText];
    [aCoder encodeObject:_caption forKey:kNADocCaption];
    [aCoder encodeObject:_locationInfoPosX forKey:kNADocLocationInfoPosX];
    [aCoder encodeObject:_locationInfoPosY forKey:kNADocLocationInfoPosY];
    [aCoder encodeObject:_compositionWidth forKey:kNADocCompositionWidth];
    [aCoder encodeObject:_compositionHeight forKey:kNADocCompositionHeight];
    [aCoder encodeObject:_publisherGroupInfoName forKey:kNADocPublisherGroupInfoName];
    [aCoder encodeObject:_publisherGroupInfoId forKey:kNADocPublisherInfoName];
    [aCoder encodeObject:_publisherInfoName forKey:kNADocPublicationInfoName];
    [aCoder encodeObject:_publicationInfoName forKey:kNADocPublishRegionInfoName];
    [aCoder encodeObject:_publishRegionInfoName forKey:kNADocEditionInfoName];
    [aCoder encodeObject:_editionInfoName forKey:kNADocPageInfoName];
    [aCoder encodeObject:_printRevisionInfoName forKey:kNADocPrintRevisionInfoName];
    [aCoder encodeObject:_newsflashFlg forKey:kNADocNewsflashFlg];
    [aCoder encodeObject:_rankGetDateTime forKey:kNADocRankGetDateTime];
    [aCoder encodeObject:_flashScore forKey:kNADocFlashScore];
    [aCoder encodeObject:_importance forKey:kNADocImportance];
    [aCoder encodeObject:_rank forKey:kNADocRank];
    [aCoder encodeObject:_publishingHistoryInfoContentIdPaperInfo forKey:kNADocPublishingHistoryInfoContentIdPaperInfo];
    [aCoder encodeObject:_publishingHistoryInfoContentIdNewsInfo forKey:kNADocPublishingHistoryInfoContentId_NewsInfo];
    [aCoder encodeObject:_publishingHistoryInfoContentIdPicture forKey:kNADocPublishingHistoryInfoContentId_Picture];
    [aCoder encodeObject:_publishingHistoryInfoContentIdAds forKey:kNADocPublishingHistoryInfoContentIdAds];
    [aCoder encodeObject:_publishingHistoryInfoPictorialValue forKey:kNADocPublishingHistoryInfoPictorialValue];
    [aCoder encodeObject:_pageComment forKey:kNADocPageComment];
    [aCoder encodeObject:_newsGroupTitle forKey:kNADocNewsGroupTitle];
    [aCoder encodeObject:_lastUpdateDateAndTime forKey:kNADocLastUpdateDateAndTime];
    [aCoder encodeObject:_turnPageDirection forKey:kNADocTurnPageDirection];
    [aCoder encodeObject:_tategakiFlg forKey:kNADocTategakiFlg];
    [aCoder encodeObject:_receivedDateAndTime forKey:kNADocReceivedDateAndTime];
    [aCoder encodeObject:_image_L_LastModified forKey:kNADocImageLLastModified];
    [aCoder encodeObject:_photoPathC forKey:kNADocPhotoPathC];
    [aCoder encodeObject:_photoPathD forKey:kNADocPhotoPathD];
    [aCoder encodeObject:_miniPhotoPath forKey:kNADocMiniPhotoPath];
    [aCoder encodeObject:_title forKey:kNADocTitle];
    [aCoder encodeObject:_relatedInfo3 forKey:kNADocRelatedInfo3];
    [aCoder encodeObject:_teiseiInfoId forKey:kNADocTeiseiInfoId];
    [aCoder encodeObject:_teiseiInfoName forKey:kNADocTeiseiInfoName];
    
    
    //add new
    [aCoder encodeObject:_releaseAreaInfo forKey:kNAReleaseAreaInfo];
    [aCoder encodeObject:_clippingImgPath forKey:kNAClippingImgPath];
    [aCoder encodeObject:_publishDayInfo forKey:kNAPublishDayInfo];
    [aCoder encodeObject:_regionViewFlg forKey:kNARegionViewFlg];
}

- (id)copyWithZone:(NSZone *)zone
{
    NADoc *copy = [[NADoc alloc] init];
    
    if (copy) {

        copy.publishDate = [self.publishDate copyWithZone:zone];
        copy.publisherInfoId = [self.publisherInfoId copyWithZone:zone];
        copy.miniPagePath = [self.miniPagePath copyWithZone:zone];
        copy.pagePath3 = [self.pagePath3 copyWithZone:zone];
        copy.changeImageInfo = [self.changeImageInfo copyWithZone:zone];
        copy.pageInfoId = [self.pageInfoId copyWithZone:zone];
        copy.pageno = [self.pageno copyWithZone:zone];
        copy.publicationInfoId = [self.publicationInfoId copyWithZone:zone];
        copy.contentType = [self.contentType copyWithZone:zone];
        copy.indexNo = [self.indexNo copyWithZone:zone];
        copy.publisherGroupInfoId = [self.publisherGroupInfoId copyWithZone:zone];
        copy.pagePath4 = [self.pagePath4 copyWithZone:zone];
        copy.variableString31 = [self.variableString31 copyWithZone:zone];
        copy.editionInfoId = [self.editionInfoId copyWithZone:zone];
        copy.variableString32 = [self.variableString32 copyWithZone:zone];
        copy.variableString33 = [self.variableString33 copyWithZone:zone];
        copy.printRevisionInfoId = [self.printRevisionInfoId copyWithZone:zone];
        copy.publishRegionInfoId = [self.publishRegionInfoId copyWithZone:zone];

    
        copy.k_ID = [self.k_ID copyWithZone:zone];
        copy.variableBoolean01 = [self.variableBoolean01 copyWithZone:zone];
        copy.headlineText = [self.newsText copyWithZone:zone];
        copy.newsText = [self.newsText copyWithZone:zone];
        copy.caption = [self.caption copyWithZone:zone];
        copy.locationInfoPosX = [self.locationInfoPosX copyWithZone:zone];
        copy.locationInfoPosY = [self.locationInfoPosY copyWithZone:zone];
        copy.compositionWidth = [self.compositionWidth copyWithZone:zone];
        copy.compositionHeight = [self.compositionHeight copyWithZone:zone];
        copy.publisherGroupInfoName = [self.publisherGroupInfoName copyWithZone:zone];
        copy.publisherInfoName = [self.publisherInfoName copyWithZone:zone];
        copy.publicationInfoName = [self.publicationInfoName copyWithZone:zone];
        copy.publishRegionInfoName = [self.publishRegionInfoName copyWithZone:zone];
        copy.editionInfoName = [self.editionInfoName copyWithZone:zone];
        copy.pageInfoName = [self.pageInfoName copyWithZone:zone];
        copy.printRevisionInfoName = [self.printRevisionInfoName copyWithZone:zone];
        copy.newsflashFlg = [self.newsflashFlg copyWithZone:zone];
        copy.rankGetDateTime = [self.rankGetDateTime copyWithZone:zone];
        copy.flashScore = [self.flashScore copyWithZone:zone];
        copy.importance = [self.importance copyWithZone:zone];
        copy.rank = [self.rank copyWithZone:zone];
        copy.publishingHistoryInfoContentIdPaperInfo = [self.publishingHistoryInfoContentIdPaperInfo copyWithZone:zone];
        copy.publishingHistoryInfoContentIdNewsInfo = [self.publishingHistoryInfoContentIdNewsInfo copyWithZone:zone];
        copy.publishingHistoryInfoContentIdPicture = [self.publishingHistoryInfoContentIdPicture copyWithZone:zone];
        copy.publishingHistoryInfoContentIdAds = [self.publishingHistoryInfoContentIdAds copyWithZone:zone];
        copy.publishingHistoryInfoPictorialValue = [self.publishingHistoryInfoPictorialValue copyWithZone:zone];
        copy.pageComment = [self.pageComment copyWithZone:zone];
        copy.newsGroupTitle = [self.newsGroupTitle copyWithZone:zone];
        copy.lastUpdateDateAndTime = [self.lastUpdateDateAndTime copyWithZone:zone];
        copy.turnPageDirection = [self.turnPageDirection copyWithZone:zone];
        copy.tategakiFlg = [self.tategakiFlg copyWithZone:zone];
        copy.receivedDateAndTime = [self.receivedDateAndTime copyWithZone:zone];
        copy.image_L_LastModified = [self.image_L_LastModified copyWithZone:zone];
        copy.photoPathC = [self.photoPathC copyWithZone:zone];
        copy.photoPathD = [self.photoPathD copyWithZone:zone];
        copy.miniPhotoPath = [self.miniPhotoPath copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.relatedInfo3 = [self.relatedInfo3 copyWithZone:zone];
        copy.teiseiInfoId = [self.teiseiInfoId copyWithZone:zone];
        copy.teiseiInfoName = [self.teiseiInfoName copyWithZone:zone];
        
        
        //add new
        copy.releaseAreaInfo = [self.releaseAreaInfo copyWithZone:zone];
        copy.clippingImgPath = [self.clippingImgPath copyWithZone:zone];
        copy.publishDayInfo = [self.publishDayInfo copyWithZone:zone];
        copy.regionViewFlg = [self.regionViewFlg copyWithZone:zone];

}
    
    return copy;
}


@end

//
//  NAClipDoc.m
//
//  Created by 晓晨 段 on 15/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NAClipDoc.h"
#import "NAClipClippingImgPath.h"


NSString *const kNAClipDocPageno = @"Pageno";
NSString *const kNAClipDocCompositionWidth = @"CompositionWidth";
NSString *const kNAClipDocPublishRegionInfoName = @"PublishRegionInfoName";
NSString *const kNAClipDocClippingImgPath = @"ClipImagePath";
NSString *const kNAClipDocNewsText = @"NewsText";
NSString *const kNAClipDocPageInfoName = @"PageInfoName";
NSString *const kNAClipDocPhotoPathD = @"PhotoPathD";
NSString *const kNAClipDocEditionInfoName = @"EditionInfoName";
NSString *const kNAClipDocChangeImageInfo = @"ChangeImageInfo";
NSString *const kNAClipDocMiniPhotoPath = @"MiniPhotoPath";
NSString *const kNAClipDocPublisherGroupInfoName = @"PublisherGroupInfoName";
NSString *const kNAClipDocPublisherInfoName = @"PublisherInfoName";
NSString *const kNAClipDocContentType = @"ContentType";
NSString *const kNAClipDocLocationInfoPosX = @"LocationInfoPosX";
NSString *const kNAClipDocNewsGroupTitle = @"NewsGroupTitle";
NSString *const kNAClipDocHeadlineText = @"HeadlineText";
NSString *const kNAClipDocIndexNo = @"IndexNo";
NSString *const kNAClipDocPublishDate = @"PublishDate";
NSString *const kNAClipDocLastUpdateDateAndTime = @"LastUpdateDateAndTime";
NSString *const kNAClipDocPublisherGroupInfoId = @"PublisherGroupInfoId";
NSString *const kNAClipDocPublisherInfoId = @"PublisherInfoId";
NSString *const kNAClipDocPublicationInfoName = @"PublicationInfoName";
NSString *const kNAClipDocPublishingHistoryInfoContentIdPaperInfo = @"PublishingHistoryInfoContentId_PaperInfo";
NSString *const kNAClipDocPublishRegionInfoId = @"PublishRegionInfoId";
NSString *const kNAClipDocEditionInfoId = @"EditionInfoId";
NSString *const kNAClipDocCompositionHeight = @"CompositionHeight";
NSString *const kNAClipDocPageInfoId = @"PageInfoId";
NSString *const kNAClipDocPublishingHistoryInfoContentIdPicture = @"PublishingHistoryInfoContentId_Picture";
NSString *const kNAClipDocLocationInfoPosY = @"LocationInfoPosY";
NSString *const kNAClipDocPrintRevisionInfoName = @"PrintRevisionInfoName";
NSString *const kNAClipDocPrintRevisionInfoId = @"PrintRevisionInfoId";
NSString *const kNAClipDocPublicationInfoId = @"PublicationInfoId";
NSString *const kNAClipDocCaption = @"Caption";

//add new
NSString *const kNAClipDocTagid = @"Tagid";
NSString *const kNAClipDocTagName = @"TagName";
NSString *const kNAClipDocMemo = @"memo";

@interface NAClipDoc ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NAClipDoc

@synthesize pageno = _pageno;
@synthesize compositionWidth = _compositionWidth;
@synthesize publishRegionInfoName = _publishRegionInfoName;
@synthesize clippingImgPath = _clippingImgPath;
@synthesize newsText = _newsText;
@synthesize pageInfoName = _pageInfoName;
@synthesize photoPathD = _photoPathD;
@synthesize editionInfoName = _editionInfoName;
@synthesize changeImageInfo = _changeImageInfo;
@synthesize miniPhotoPath = _miniPhotoPath;
@synthesize publisherGroupInfoName = _publisherGroupInfoName;
@synthesize publisherInfoName = _publisherInfoName;
@synthesize contentType = _contentType;
@synthesize locationInfoPosX = _locationInfoPosX;
@synthesize newsGroupTitle = _newsGroupTitle;
@synthesize headlineText = _headlineText;
@synthesize indexNo = _indexNo;
@synthesize publishDate = _publishDate;
@synthesize lastUpdateDateAndTime = _lastUpdateDateAndTime;
@synthesize publisherGroupInfoId = _publisherGroupInfoId;
@synthesize publisherInfoId = _publisherInfoId;
@synthesize publicationInfoName = _publicationInfoName;
@synthesize publishingHistoryInfoContentIdPaperInfo = _publishingHistoryInfoContentIdPaperInfo;
@synthesize publishRegionInfoId = _publishRegionInfoId;
@synthesize editionInfoId = _editionInfoId;
@synthesize compositionHeight = _compositionHeight;
@synthesize pageInfoId = _pageInfoId;
@synthesize publishingHistoryInfoContentIdPicture = _publishingHistoryInfoContentIdPicture;
@synthesize locationInfoPosY = _locationInfoPosY;
@synthesize printRevisionInfoName = _printRevisionInfoName;
@synthesize printRevisionInfoId = _printRevisionInfoId;
@synthesize publicationInfoId = _publicationInfoId;

@synthesize miniPagePath = _miniPagePath;
@synthesize pagePath3 = _pagePath3;
@synthesize pagePath4 = _pagePath4;

@synthesize iselecton;
@synthesize genreId;
@synthesize genreName;
//add new
@synthesize tagid = _tagid;
@synthesize tagName = _tagName;
@synthesize memo = _memo;

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
            self.pageno = [self objectOrNilForKey:kNAClipDocPageno fromDictionary:dict];
            self.compositionWidth = [self objectOrNilForKey:kNAClipDocCompositionWidth fromDictionary:dict];
            self.publishRegionInfoName = [self objectOrNilForKey:kNAClipDocPublishRegionInfoName fromDictionary:dict];
            self.clippingImgPath = [self objectOrNilForKey:kNAClipDocClippingImgPath fromDictionary:dict];;
            NSString *myNewsText=[self objectOrNilForKey:kNAClipDocNewsText fromDictionary:dict];
            self.newsText = myNewsText.length==0 ? NSLocalizedString(@"NO NewsText", nil):myNewsText;
            self.pageInfoName = [self objectOrNilForKey:kNAClipDocPageInfoName fromDictionary:dict];
            self.photoPathD = [self objectOrNilForKey:kNAClipDocPhotoPathD fromDictionary:dict];
            self.editionInfoName = [self objectOrNilForKey:kNAClipDocEditionInfoName fromDictionary:dict];
            self.changeImageInfo = [self objectOrNilForKey:kNAClipDocChangeImageInfo fromDictionary:dict];
            self.miniPhotoPath =[CharUtil getRightUrl:[self objectOrNilForKey:kNAClipDocMiniPhotoPath fromDictionary:dict]] ;
            self.publisherGroupInfoName = [self objectOrNilForKey:kNAClipDocPublisherGroupInfoName fromDictionary:dict];
            self.publisherInfoName = [self objectOrNilForKey:kNAClipDocPublisherInfoName fromDictionary:dict];
            self.contentType = [self objectOrNilForKey:kNAClipDocContentType fromDictionary:dict];
            self.locationInfoPosX = [self objectOrNilForKey:kNAClipDocLocationInfoPosX fromDictionary:dict];
            self.newsGroupTitle = [self objectOrNilForKey:kNAClipDocNewsGroupTitle fromDictionary:dict];
            self.headlineText = [self objectOrNilForKey:kNAClipDocHeadlineText fromDictionary:dict];
            self.indexNo = [self objectOrNilForKey:kNAClipDocIndexNo fromDictionary:dict];
            self.publishDate = [self objectOrNilForKey:kNAClipDocPublishDate fromDictionary:dict];
            self.lastUpdateDateAndTime = [self objectOrNilForKey:kNAClipDocLastUpdateDateAndTime fromDictionary:dict];
            self.publisherGroupInfoId = [self objectOrNilForKey:kNAClipDocPublisherGroupInfoId fromDictionary:dict];
            self.publisherInfoId = [self objectOrNilForKey:kNAClipDocPublisherInfoId fromDictionary:dict];
            self.publicationInfoName = [self objectOrNilForKey:kNAClipDocPublicationInfoName fromDictionary:dict];
            self.publishingHistoryInfoContentIdPaperInfo = [self objectOrNilForKey:kNAClipDocPublishingHistoryInfoContentIdPaperInfo fromDictionary:dict];
            self.publishRegionInfoId = [self objectOrNilForKey:kNAClipDocPublishRegionInfoId fromDictionary:dict];
            self.editionInfoId = [self objectOrNilForKey:kNAClipDocEditionInfoId fromDictionary:dict];
            self.compositionHeight = [self objectOrNilForKey:kNAClipDocCompositionHeight fromDictionary:dict];
            self.pageInfoId = [self objectOrNilForKey:kNAClipDocPageInfoId fromDictionary:dict];
            self.publishingHistoryInfoContentIdPicture = [self objectOrNilForKey:kNAClipDocPublishingHistoryInfoContentIdPicture fromDictionary:dict];
            self.locationInfoPosY = [self objectOrNilForKey:kNAClipDocLocationInfoPosY fromDictionary:dict];
            self.printRevisionInfoName = [self objectOrNilForKey:kNAClipDocPrintRevisionInfoName fromDictionary:dict];
            self.printRevisionInfoId = [self objectOrNilForKey:kNAClipDocPrintRevisionInfoId fromDictionary:dict];
            self.publicationInfoId = [self objectOrNilForKey:kNAClipDocPublicationInfoId fromDictionary:dict];
            self.caption = [self objectOrNilForKey:kNAClipDocCaption fromDictionary:dict];
        //add new
        self.tagid = [self objectOrNilForKey:kNAClipDocTagid fromDictionary:dict];
        self.tagName = [self objectOrNilForKey:kNAClipDocTagName fromDictionary:dict];
        self.memo = [self objectOrNilForKey:kNAClipDocMemo fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.pageno forKey:kNAClipDocPageno];
    [mutableDict setValue:self.compositionWidth forKey:kNAClipDocCompositionWidth];
    [mutableDict setValue:self.publishRegionInfoName forKey:kNAClipDocPublishRegionInfoName];
    [mutableDict setValue:self.clippingImgPath  forKey:kNAClipDocClippingImgPath];
    [mutableDict setValue:self.newsText forKey:kNAClipDocNewsText];
    [mutableDict setValue:self.pageInfoName forKey:kNAClipDocPageInfoName];
    [mutableDict setValue:self.photoPathD forKey:kNAClipDocPhotoPathD];
    [mutableDict setValue:self.editionInfoName forKey:kNAClipDocEditionInfoName];
    [mutableDict setValue:self.changeImageInfo forKey:kNAClipDocChangeImageInfo];
    [mutableDict setValue:self.miniPhotoPath forKey:kNAClipDocMiniPhotoPath];
    [mutableDict setValue:self.publisherGroupInfoName forKey:kNAClipDocPublisherGroupInfoName];
    [mutableDict setValue:self.publisherInfoName forKey:kNAClipDocPublisherInfoName];
    [mutableDict setValue:self.contentType forKey:kNAClipDocContentType];
    [mutableDict setValue:self.locationInfoPosX forKey:kNAClipDocLocationInfoPosX];
    [mutableDict setValue:self.newsGroupTitle forKey:kNAClipDocNewsGroupTitle];
    [mutableDict setValue:self.headlineText forKey:kNAClipDocHeadlineText];
    [mutableDict setValue:self.indexNo forKey:kNAClipDocIndexNo];
    [mutableDict setValue:self.publishDate forKey:kNAClipDocPublishDate];
    [mutableDict setValue:self.lastUpdateDateAndTime forKey:kNAClipDocLastUpdateDateAndTime];
    [mutableDict setValue:self.publisherGroupInfoId forKey:kNAClipDocPublisherGroupInfoId];
    [mutableDict setValue:self.publisherInfoId forKey:kNAClipDocPublisherInfoId];
    [mutableDict setValue:self.publicationInfoName forKey:kNAClipDocPublicationInfoName];
    [mutableDict setValue:self.publishingHistoryInfoContentIdPaperInfo forKey:kNAClipDocPublishingHistoryInfoContentIdPaperInfo];
    [mutableDict setValue:self.publishRegionInfoId forKey:kNAClipDocPublishRegionInfoId];
    [mutableDict setValue:self.editionInfoId forKey:kNAClipDocEditionInfoId];
    [mutableDict setValue:self.compositionHeight forKey:kNAClipDocCompositionHeight];
    [mutableDict setValue:self.pageInfoId forKey:kNAClipDocPageInfoId];
    [mutableDict setValue:self.publishingHistoryInfoContentIdPicture forKey:kNAClipDocPublishingHistoryInfoContentIdPicture];
    [mutableDict setValue:self.locationInfoPosY forKey:kNAClipDocLocationInfoPosY];
    [mutableDict setValue:self.printRevisionInfoName forKey:kNAClipDocPrintRevisionInfoName];
    [mutableDict setValue:self.printRevisionInfoId forKey:kNAClipDocPrintRevisionInfoId];
    [mutableDict setValue:self.publicationInfoId forKey:kNAClipDocPublicationInfoId];

    //add new
    [mutableDict setValue:self.tagName forKey:kNAClipDocTagName];
    [mutableDict setValue:self.tagid forKey:kNAClipDocTagid];
    [mutableDict setValue:self.memo forKey:kNAClipDocMemo];
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
    return [object isKindOfClass:[NSString class]] ? object : @"";
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.pageno = [aDecoder decodeObjectForKey:kNAClipDocPageno];
    self.compositionWidth = [aDecoder decodeObjectForKey:kNAClipDocCompositionWidth];
    self.publishRegionInfoName = [aDecoder decodeObjectForKey:kNAClipDocPublishRegionInfoName];
    self.clippingImgPath = [aDecoder decodeObjectForKey:kNAClipDocClippingImgPath];
    self.newsText = [aDecoder decodeObjectForKey:kNAClipDocNewsText];
    self.pageInfoName = [aDecoder decodeObjectForKey:kNAClipDocPageInfoName];
    self.photoPathD = [aDecoder decodeObjectForKey:kNAClipDocPhotoPathD];
    self.editionInfoName = [aDecoder decodeObjectForKey:kNAClipDocEditionInfoName];
    self.changeImageInfo = [aDecoder decodeObjectForKey:kNAClipDocChangeImageInfo];
    self.miniPhotoPath = [aDecoder decodeObjectForKey:kNAClipDocMiniPhotoPath];
    self.publisherGroupInfoName = [aDecoder decodeObjectForKey:kNAClipDocPublisherGroupInfoName];
    self.publisherInfoName = [aDecoder decodeObjectForKey:kNAClipDocPublisherInfoName];
    self.contentType = [aDecoder decodeObjectForKey:kNAClipDocContentType];
    self.locationInfoPosX = [aDecoder decodeObjectForKey:kNAClipDocLocationInfoPosX];
    self.newsGroupTitle = [aDecoder decodeObjectForKey:kNAClipDocNewsGroupTitle];
    self.headlineText = [aDecoder decodeObjectForKey:kNAClipDocHeadlineText];
    self.indexNo = [aDecoder decodeObjectForKey:kNAClipDocIndexNo];
    self.publishDate = [aDecoder decodeObjectForKey:kNAClipDocPublishDate];
    self.lastUpdateDateAndTime = [aDecoder decodeObjectForKey:kNAClipDocLastUpdateDateAndTime];
    self.publisherGroupInfoId = [aDecoder decodeObjectForKey:kNAClipDocPublisherGroupInfoId];
    self.publisherInfoId = [aDecoder decodeObjectForKey:kNAClipDocPublisherInfoId];
    self.publicationInfoName = [aDecoder decodeObjectForKey:kNAClipDocPublicationInfoName];
    self.publishingHistoryInfoContentIdPaperInfo = [aDecoder decodeObjectForKey:kNAClipDocPublishingHistoryInfoContentIdPaperInfo];
    self.publishRegionInfoId = [aDecoder decodeObjectForKey:kNAClipDocPublishRegionInfoId];
    self.editionInfoId = [aDecoder decodeObjectForKey:kNAClipDocEditionInfoId];
    self.compositionHeight = [aDecoder decodeObjectForKey:kNAClipDocCompositionHeight];
    self.pageInfoId = [aDecoder decodeObjectForKey:kNAClipDocPageInfoId];
    self.publishingHistoryInfoContentIdPicture = [aDecoder decodeObjectForKey:kNAClipDocPublishingHistoryInfoContentIdPicture];
    self.locationInfoPosY = [aDecoder decodeObjectForKey:kNAClipDocLocationInfoPosY];
    self.printRevisionInfoName = [aDecoder decodeObjectForKey:kNAClipDocPrintRevisionInfoName];
    self.printRevisionInfoId = [aDecoder decodeObjectForKey:kNAClipDocPrintRevisionInfoId];
    self.publicationInfoId = [aDecoder decodeObjectForKey:kNAClipDocPublicationInfoId];
    //add new
    self.tagid = [aDecoder decodeObjectForKey:kNAClipDocTagid];
    self.tagName = [aDecoder decodeObjectForKey:kNAClipDocTagName];
    self.memo = [aDecoder decodeObjectForKey:kNAClipDocMemo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_pageno forKey:kNAClipDocPageno];
    [aCoder encodeObject:_compositionWidth forKey:kNAClipDocCompositionWidth];
    [aCoder encodeObject:_publishRegionInfoName forKey:kNAClipDocPublishRegionInfoName];
    [aCoder encodeObject:_clippingImgPath forKey:kNAClipDocClippingImgPath];
    [aCoder encodeObject:_newsText forKey:kNAClipDocNewsText];
    [aCoder encodeObject:_pageInfoName forKey:kNAClipDocPageInfoName];
    [aCoder encodeObject:_photoPathD forKey:kNAClipDocPhotoPathD];
    [aCoder encodeObject:_editionInfoName forKey:kNAClipDocEditionInfoName];
    [aCoder encodeObject:_changeImageInfo forKey:kNAClipDocChangeImageInfo];
    [aCoder encodeObject:_miniPhotoPath forKey:kNAClipDocMiniPhotoPath];
    [aCoder encodeObject:_publisherGroupInfoName forKey:kNAClipDocPublisherGroupInfoName];
    [aCoder encodeObject:_publisherInfoName forKey:kNAClipDocPublisherInfoName];
    [aCoder encodeObject:_contentType forKey:kNAClipDocContentType];
    [aCoder encodeObject:_locationInfoPosX forKey:kNAClipDocLocationInfoPosX];
    [aCoder encodeObject:_newsGroupTitle forKey:kNAClipDocNewsGroupTitle];
    [aCoder encodeObject:_headlineText forKey:kNAClipDocHeadlineText];
    [aCoder encodeObject:_indexNo forKey:kNAClipDocIndexNo];
    [aCoder encodeObject:_publishDate forKey:kNAClipDocPublishDate];
    [aCoder encodeObject:_lastUpdateDateAndTime forKey:kNAClipDocLastUpdateDateAndTime];
    [aCoder encodeObject:_publisherGroupInfoId forKey:kNAClipDocPublisherGroupInfoId];
    [aCoder encodeObject:_publisherInfoId forKey:kNAClipDocPublisherInfoId];
    [aCoder encodeObject:_publicationInfoName forKey:kNAClipDocPublicationInfoName];
    [aCoder encodeObject:_publishingHistoryInfoContentIdPaperInfo forKey:kNAClipDocPublishingHistoryInfoContentIdPaperInfo];
    [aCoder encodeObject:_publishRegionInfoId forKey:kNAClipDocPublishRegionInfoId];
    [aCoder encodeObject:_editionInfoId forKey:kNAClipDocEditionInfoId];
    [aCoder encodeObject:_compositionHeight forKey:kNAClipDocCompositionHeight];
    [aCoder encodeObject:_pageInfoId forKey:kNAClipDocPageInfoId];
    [aCoder encodeObject:_publishingHistoryInfoContentIdPicture forKey:kNAClipDocPublishingHistoryInfoContentIdPicture];
    [aCoder encodeObject:_locationInfoPosY forKey:kNAClipDocLocationInfoPosY];
    [aCoder encodeObject:_printRevisionInfoName forKey:kNAClipDocPrintRevisionInfoName];
    [aCoder encodeObject:_printRevisionInfoId forKey:kNAClipDocPrintRevisionInfoId];
    [aCoder encodeObject:_publicationInfoId forKey:kNAClipDocPublicationInfoId];
    //add new
    [aCoder encodeObject:_tagid forKey:kNAClipDocTagid];
    [aCoder encodeObject:_tagName forKey:kNAClipDocTagName];
    [aCoder encodeObject:_memo forKey:kNAClipDocMemo];
}

- (id)copyWithZone:(NSZone *)zone
{
    NAClipDoc *copy = [[NAClipDoc alloc] init];
    
    if (copy) {

        copy.pageno = [self.pageno copyWithZone:zone];
        copy.compositionWidth = [self.compositionWidth copyWithZone:zone];
        copy.publishRegionInfoName = [self.publishRegionInfoName copyWithZone:zone];
        copy.clippingImgPath = [self.clippingImgPath copyWithZone:zone];
        copy.newsText = [self.newsText copyWithZone:zone];
        copy.pageInfoName = [self.pageInfoName copyWithZone:zone];
        copy.photoPathD = [self.photoPathD copyWithZone:zone];
        copy.editionInfoName = [self.editionInfoName copyWithZone:zone];
        copy.changeImageInfo = [self.changeImageInfo copyWithZone:zone];
        copy.miniPhotoPath = [self.miniPhotoPath copyWithZone:zone];
        copy.publisherGroupInfoName = [self.publisherGroupInfoName copyWithZone:zone];
        copy.publisherInfoName = [self.publisherInfoName copyWithZone:zone];
        copy.contentType = [self.contentType copyWithZone:zone];
        copy.locationInfoPosX = [self.locationInfoPosX copyWithZone:zone];
        copy.newsGroupTitle = [self.newsGroupTitle copyWithZone:zone];
        copy.headlineText = [self.headlineText copyWithZone:zone];
        copy.indexNo = [self.indexNo copyWithZone:zone];
        copy.publishDate = [self.publishDate copyWithZone:zone];
        copy.lastUpdateDateAndTime = [self.lastUpdateDateAndTime copyWithZone:zone];
        copy.publisherGroupInfoId = [self.publisherGroupInfoId copyWithZone:zone];
        copy.publisherInfoId = [self.publisherInfoId copyWithZone:zone];
        copy.publicationInfoName = [self.publicationInfoName copyWithZone:zone];
        copy.publishingHistoryInfoContentIdPaperInfo = [self.publishingHistoryInfoContentIdPaperInfo copyWithZone:zone];
        copy.publishRegionInfoId = [self.publishRegionInfoId copyWithZone:zone];
        copy.editionInfoId = [self.editionInfoId copyWithZone:zone];
        copy.compositionHeight = [self.compositionHeight copyWithZone:zone];
        copy.pageInfoId = [self.pageInfoId copyWithZone:zone];
        copy.publishingHistoryInfoContentIdPicture = [self.publishingHistoryInfoContentIdPicture copyWithZone:zone];
        copy.locationInfoPosY = [self.locationInfoPosY copyWithZone:zone];
        copy.printRevisionInfoName = [self.printRevisionInfoName copyWithZone:zone];
        copy.printRevisionInfoId = [self.printRevisionInfoId copyWithZone:zone];
        copy.publicationInfoId = [self.publicationInfoId copyWithZone:zone];
        //add new
        copy.tagid = [self.tagid copyWithZone:zone];
        copy.tagName = [self.tagName copyWithZone:zone];
        copy.memo = [self.memo copyWithZone:zone];
    }
    
    return copy;
}


@end

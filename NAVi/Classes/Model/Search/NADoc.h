//
//  NADoc.h
//
//  Created by 晓晨 段 on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface NADoc : NSObject <NSCoding, NSCopying>
@property (nonatomic, strong) NSString *changeImageInfo;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *editionInfoId;
@property (nonatomic, strong) NSString *editionInfoName;
@property (nonatomic, strong) NSString *indexNo;
@property (nonatomic, strong) NSString *lastUpdateDateAndTime;
@property (nonatomic, strong) NSString *miniPagePath;
@property (nonatomic, strong) NSString *newsText;
@property (nonatomic, strong) NSString *pageInfoId;
@property (nonatomic, strong) NSString *pageInfoName;
@property (nonatomic, strong) NSString *pagePath3;
@property (nonatomic, strong) NSString *pagePath4;
@property (nonatomic, strong) NSString *pageno;
@property (nonatomic, strong) NSString *printRevisionInfoId;
@property (nonatomic, strong) NSString *publishDate;
@property (nonatomic, strong) NSString *publisherGroupInfoId;//
@property (nonatomic, strong) NSString *publisherInfoId;//
@property (nonatomic, strong) NSString *publicationInfoId;//
@property (nonatomic, strong) NSString *publishRegionInfoId;
@property (nonatomic, strong) NSString *variableString31;
@property (nonatomic, strong) NSString *variableString32;
@property (nonatomic, strong) NSString *variableString33;
@property (nonatomic, strong) NSString *k_ID;
@property (nonatomic, strong) NSString *variableBoolean01;
@property (nonatomic, strong) NSString *headlineText;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSString *locationInfoPosX;
@property (nonatomic, strong) NSString *locationInfoPosY;
@property (nonatomic, strong) NSString *compositionWidth;
@property (nonatomic, strong) NSString *compositionHeight;
@property (nonatomic, strong) NSString *publisherGroupInfoName;
@property (nonatomic, strong) NSString *publisherInfoName;//
@property (nonatomic, strong) NSString *publicationInfoName;
@property (nonatomic, strong) NSString *publishRegionInfoName;
@property (nonatomic, strong) NSString *printRevisionInfoName;
@property (nonatomic, strong) NSString *newsflashFlg;
@property (nonatomic, strong) NSString *rankGetDateTime;
@property (nonatomic, strong) NSString *flashScore;
@property (nonatomic, strong) NSString *importance;
@property (nonatomic, strong) NSString *rank;
@property (nonatomic, strong) NSString *publishingHistoryInfoContentIdPaperInfo;
@property (nonatomic, strong) NSString *publishingHistoryInfoContentIdNewsInfo;
@property (nonatomic, strong) NSString *publishingHistoryInfoContentIdPicture;
@property (nonatomic, strong) NSString *publishingHistoryInfoContentIdAds;
@property (nonatomic, strong) NSString *publishingHistoryInfoPictorialValue;
@property (nonatomic, strong) NSString *pageComment;
@property (nonatomic, strong) NSString *newsGroupTitle;
@property (nonatomic, strong) NSString *turnPageDirection;
@property (nonatomic, strong) NSString *tategakiFlg;
@property (nonatomic, strong) NSString *receivedDateAndTime;
@property (nonatomic, strong) NSString *image_L_LastModified;
@property (nonatomic, strong) NSString *photoPathC;
@property (nonatomic, strong) NSString *photoPathD;
@property (nonatomic, strong) NSString *miniPhotoPath;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *relatedInfo3;
@property (nonatomic, strong) NSString *teiseiInfoId;
@property (nonatomic, strong) NSString *teiseiInfoName;
@property (nonatomic, strong) NSString *whichimage;

@property (nonatomic, strong) NSString *iselecton;

@property (nonatomic,strong) NSArray *notearray;
@property (nonatomic,strong) UIImage *thumbimage;
@property (nonatomic,readwrite) NSInteger t_id;
@property (nonatomic,strong) NSString *user_id;
@property (nonatomic, strong) NSString *genreId;
@property (nonatomic, strong) NSString *genreName;
@property (nonatomic, strong) NSString *publication_disOrder1;
@property (nonatomic, strong) NSString *publication_disOrder3;
@property (nonatomic, strong) NSString *publication_disOrder4;
//add new
@property (nonatomic,strong) NSString *releaseAreaInfo;
@property (nonatomic,strong) NSString *clippingImgPath;
@property (nonatomic,strong) NSString *publishDayInfo;
@property (nonatomic,strong) NSString *regionViewFlg;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

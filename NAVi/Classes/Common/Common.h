//
//  Common.h
//  NAVi
//
//  Created by y fs on 15/5/5.
//  Copyright (c) 2015年 dxc. All rights reserved.
//
#import "Util.h"
#import "iToast.h"
#import "NASQLHelper.h"
#import "ProgressHUD.h"
#import "NACheckNetwork.h"
#import "TAGManagerUtil.h"
#import "CharUtil.h"
#import "NAImageHelper.h"
#import "NADefine.h"
#import "NANetworkClient.h"
#import "NABaseViewController.h"
#import "NAHomeDataShare.h"



#ifndef NAVi_Common_h
#define NAVi_Common_h

#define NASearchResultPagesize @"75"

#define NAThumbimage  @"Thumbimage"
#define NANormalimage @"Normalimage"
#define NALargeimage @"Largeimage"
#define NASOKUHO  @"sokuho"

//init.plist
#define NAplist @"init.plist"
#define serverdefault @"data.server.ip.default"
#define loginserverdefault @"data.login.server.ip.default"
#define NALLDownloadKey @"setting.auto.download"
#define NAFontnumkey @"font_num"
#define NAPapersize @"paper.size."
#define NAFontsizekey @"font_size"
#define NASpanskey @"span.num"
#define NASokuhoFontsizekey @"sokuho_font_size"
#define NADEFAULTUSERID @"default.user.id"
#define NADEFAULTUSERPASS @"default.user.pass"
#define NAAGREEMENTVERSION @"agreement.version"

#define NAAutologinkey @"setting.auto.login"
#define NAShowdaycountkey @"baitai.ShowDayCount."
#define NAShowdaycountdefaultkey @"baitai.ShowDayCount.default"
#define NANewsTitleLengthkey @"paper.detail.kiji.newsTitleLength"
#define NANewsTextLengthkey @"paper.detail.kiji.newsTextLength"
#define NAInformationUrlkey @"information.url"
#define NALandscapekeikey @"landscape.kei"
#define NAFastNewsRowskey @"fastNewsRows"
#define NASearchFastNewsRowskey @"searchfastNewsRows"
#define NADetailTatekey @"detailTate"
#define NAFastNewsTatekey @"fastNewsTate"
#define NAFirstDownload @"setting.firstDownload"
#define NAISFastNewskey @"sokuho.select.serviceFlg"
#define NAWULIAOPUBLICATIONINFOID @"data.wuliao.publicationInfoId"
#define NANOTCLEARDAYSKEY @"data.notclear.days"
#define NAClipSelectedTag @"clipSelectedTag"

#define NAISVISITORMODEL @"VisitorModel"
#define NASAVETOKENKEY @"savetokenkey"
#define NASENDTOKENURL @"sendTokenUrl"
#define NAISSENDTOKENSUCCESS @"isSendTokenSuccess"
#define NAISSWIPEVIEWSHOWHIGHIMAGE @"isSwipeViewShowHighImage"

#define Screen_with @"[ UIScreen mainScreen ].bounds.size.width"
#define NABarShowIntervalkey @"barShowInterval"
#define NATimeoutIntervalkey @"timeoutInterval"
#define NAISUSECURRENTDOC @"isUseCurrentDoc"
#define NAISHAVESEARCHORDERNO @"isHaveSearchOrderNO"
#define NAISSHOWAGREEMENT @"isShowAgreement"
#define NAISSHOWSEARCHPAGE @"isShowSearchPage"
#define NAISHAVEWEBBTN @"isHaveWebBtn"
#define NAISHAVEEXTRAIMAGE @"isHaveExtraImage"
#define NAWEBURL @"WebUrl"
#define TOPURL @"topUrl"
#define NAEXTRAURL @"ExtraUrl"
#define NADataServerProtocol @"data.server.protocol"
#define NAImageServerProtocol @"image.server.protocol"
#define HostName @"www.yahoo.co.jp"
#define PROTOCOLURL @"protocol.url"
//ios verision
#define isIOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define is_ios_7_Later [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#define APPVERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)
#define ONCE(block) dispatch_once(&oncePredicate, block)


#define AFTER(delayInSeconds,block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block)

//toast
#define ITOAST_BOTTOM(message)[[[iToast makeText:NSLocalizedString(message, nil)]setGravity:iToastGravityBottom] show]
//message
#define NETWORKERROR @"networkerror"
//status
#define REQUEST_SUCCESS @"1"
//Notification
#define NOTYGetNASDoc @"getNASDoc"
#define NOTYDrawFirstnote @"drawFirstnote"
#define NOTYReloadClip @"reloadClip"
#define NOTYImageDetailClick @"imageDetailClick"
#define NOTYImageSingleClick @"singleClick"
#define NOTYReloadPage @"reloadPage"
#define NOTYGETHOMEPAGE @"gethomepage"
#define NOTYNOTECHANGE @"ToPublicationViewController"
#define NOTYToPublicationViewController @""
//file name
#define  NALoginHtmlFileName @"osirase_apl.html"
#define  NATopHtmlFileName @"osirase_top.jsp"
#define  NAISSHOWTOPOSIRASE @"isShowTopOsirase"

//image
#define NALoadingimage @"nextep_loading_blue.png"
#define NANOImage @"no_image_1"

//image style
#define NABlueStyle @"_2"
#define NAWhiteStyle @"_1"

#define GETIMAGENAME(imagename) [[NAImageHelper sharedInstance]getImageName:imagename]
// color
#define BaseToolBarColor [[NAImageHelper sharedInstance]getToolBarColor]
#define NAVTitleColor [[NAImageHelper sharedInstance]getNavTitleColor]
#define NAPageTitleColor [[NAImageHelper sharedInstance]getPageTitleColor]
#define NAPageDetailTitleColor [[NAImageHelper sharedInstance]getPageDetailTitleColor]

//
#define userpassword @"userpassword"
#define ishavenote @"ishavenote"
#define NAISPUBLICATION @"ispublication"

#define TYPE_SOKUHO @"sokuho"
#define TYPE_NOTE @"note"
#define TYPE_NOTE_SELECT @"noteSelect"
#define TYPE_CLIP @"cilp"
#define TYPE_SEARCH @"search"
#define TYPE_HOME @"home"

#define TYPE_PAGETATE @"pagetate"
#define TYPE_SPANNUM @"spannums"
//color
#define Lightbulecolor @"D0E0F0" 
#define Highlightcolor @"0XFFFF00" 

//GoogleTagMangager
#define  TagMangagerId @"GTM-PD495X"
//紙面表示
#define  ENPageView @"pagerView"
//画像表示
#define  ENImageView @"imageView"
#define  ENSelectPhotoKiji @"selectPhotoKiji"
#define  ENSelectPhotoPaper @"selectPhotoPaper"
#define  ENSelectPhotoClip @"selectPhotoClip"
#define  ENNotePhoto @"記事画像"
#define  ENPagerPhoto @"切り抜きイメージ画像"
#define  ENClipPhoto @"関連紙面画像"
#define  ENSendMailBtn @"sendMailBtn"
#define  ENSendMailLab @"メール送信"
#define  ENSavePhotoBtn @"savePhotoBtn"
#define  ENSavePhotoLab @"画像保存"


//記事表示
#define  ENKijiView @"kijiView"
#define  ENDelClipBtn @"delClipBtn"
#define  ENDelClipLab @"クリップ削除"
#define  ENAddClipBtn @"addClipBtn"
#define  ENAddClipLab @"クリップ保存"
#define  ENChangeFontBtn @"changeFontBtn"
#define  ENChangeFontBigLab @"字体变更大"
#define  ENChangeFontNormalLab @"字体变更中"
#define  ENChangeFontSmallLab @"字体变更小"
#define  ENKijiDetailBtn @"kijiDetailBtn"
#define  ENKijiDetailLab @"記事詳細"
//sokuhaoボタン
#define  ENSokuhoListBtn @"sokuhoListBtn"
//検索画面表示
#define  ENSearchView @"searchView"
//設定画面表示
#define  ENSetupView @"setupView"
//日付一覧
#define  ENDateListView @"dateListView"
//地方面
#define  ENPlaceListView @"placeListView"
//紙面一覧
#define  ENPageListView @"pageListView"
//記事一覧
#define  ENKijiListView @"kijiListView"
#define  ENKijiListViewLab @"記事一覧"
//clip
#define  ENClipListView @"clipListView"
#define  ENClipListViewLab @"クリップリスト"
//設定
#define  ENSetupView @"setupView"
//検索
#define  ENSearchView @"searchView"

//検索结果
#define  ENSearchResultView @"searchResultView"
#define  ENSearchResultViewLab @"検索结果"

//記事詳細
#define  ENKijiDetailView @"kijiDetailView"
#define  ENKijiDetailViewLab @"記事詳細"

//画像詳細
#define  ENPhotoDetailView @"photoDetailView"
#define  ENPhotoDetailViewLab @"画像詳細"

//検索ボタン
#define  ENSerachBtn @"searchBtn"
#define  ENSerachLab @"検索"
#define  ENSearchPaperBtn @"searchPaperBtn"
#define  ENSearchPaperInfo @"紙面検索"
#define  ENSearchKijiBtn @"searchKijiBtn"
#define  ENSearchKijiInfo @"記事検索"
//リフレッシュボタン
#define  ENRefreshBtn @"refreshBtn"
#define  ENRefreshLab @"更新"
//新聞一覧ボタン
#define  ENPaperListBtn @"paperListBtn"
//まとめ読みボタン
#define  ENSummaryReadBtn @"summaryReadBtn"
//日付一覧ボタン
#define  ENDateListBtn @"dateListBtn"
#define  ENDateListLab @"日付一覧"
#define  ENSelectPaperByDate @"selectPaperByDate"

//地方面選択ボタン
#define  ENLocalBtn @"placeListBtn"
#define  ENLocalLab @"地方面"
#define  ENSelectPaperByPlace @"selectPaperByPlace"
//ページボタン
#define  ENPageListBtn @"pageListBtn"
#define  ENPageListLab @"紙面一覧"
#define  ENSelectPageBtn @"selectPageBtn"
//記事ボタン
#define  ENKijiListBtn @"kijiListBtn"
#define  ENSelectKiji @"selectKiji"
#define  ENKijiListLab @"記事"

#define  ENPrevDateBtn @"prevDateBtn"
#define  ENNextDateBtn @"nextDateBtn"
//clipボタン
#define  ENClipListBtn @"clipListBtn"
#define  ENClipListLab @"クリップ"
//設定ボタン
#define  ENSetupBtn @"setupBtn"
#define  ENSetupLab @"設定"
#define  ENAutoLoginBtn @"autoLoginBtn"
#define  ENAllDownloadBtn @"allDownloadBtn"
#define  ENSetZoomBtn @"setZoomBtn"
#define  ENClearIdPassBtn @"clearIdPassBtn"
#define  ENClearSearchHistoryBtn @"clearSearchHistoryBtn"
#define  ENClearDataBtn @"clearDataBtn"
#define  ENUserModelBtn @"userModelBtn"
#define  ENUserConfirm @"紙面確認"
#define  ENUserOrdinary @"普通"
#define  ENIsShowMessageBtn @"isShowMessageBtn"


//clip削除ボタン
#define  ENClipDelBtn @"clipDelBtn"
//clip保存ボタン
#define  ENClipSaveBtn @"clipSaveBtn"
#endif

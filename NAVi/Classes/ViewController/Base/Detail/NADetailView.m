
#import "NADetailView.h"
#import "UIImageView+AFNetworking.h"
#import "NADefine.h"
#import "NANotePageView.h"

#define TITLE_MARGIN 10
#define TITLE_TOP_Y 25
#define NAVBARHEIGHT 44



@interface NADetailView ()

@property (nonatomic, assign) UIInterfaceOrientation oldFromInterfaceOrientation;
@property (nonatomic, assign) UIInterfaceOrientation oldToInterfaceOrientation;

@end

@implementation NADetailView{
    NSString *bundleFile;
    NSString *viewFormatHtml;
    BOOL  isWebViewloadFinished;
}
@synthesize imageurlarray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        bundleFile = [[NSBundle mainBundle] pathForResource:@"htmlsource" ofType:@"bundle"];
        
        NSString *viewFilePath =[NSString stringWithFormat:@"%@/kijiDetail.html",bundleFile];
        viewFormatHtml = [NSString stringWithContentsOfFile:viewFilePath encoding:NSUTF8StringEncoding error:nil];
        [_textView loadHTMLString:viewFormatHtml.copy baseURL:[NSURL fileURLWithPath:bundleFile]];
    }
    
    return self;
}


#pragma mark - utility -
#pragma mark

- (void)initViews
{
    self.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1];
    [self addSubview:self.textView];

}

/**
 * Views　更新
 *
 */
- (void)updateViews
{
    
}

/**
 * html内容を設定
 *
 */
-(void)loadmyhtml{
    if (!isWebViewloadFinished) {
        return;
    }
    
    // 記事文字を設定
    CGFloat textFont = [NASaveData getExpansion_rateNum];
    CGFloat fontSize = [NASaveData getFontSize:textFont];
    [self textFontValue:fontSize];
    
    NSString *jsString = [NSString stringWithFormat:@"changeHtml(\"%@\");",@""];
    [_textView stringByEvaluatingJavaScriptFromString:jsString];
    
    [NSThread sleepForTimeInterval:1];
    
    NSString *htmlString = nil;
    if (htmlString==nil) {
        NSString *contentFilePath =[NSString stringWithFormat:@"%@/kijiDetailContent.html",bundleFile];
        NSString *contentFormatHtml = [NSString stringWithContentsOfFile:contentFilePath encoding:NSUTF8StringEncoding error:nil];
        htmlString = contentFormatHtml.copy;
        
    }
    if ([self.text isKindOfClass:[NSString class]] && self.text) {
        NSString *spanNum = [NSString stringWithFormat:@"%ld",(long)[NASaveData getCurSpanNum]];
        
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@spanNum@" withString:spanNum];
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@text@" withString:self.text];
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@title@" withString:self.title];
        NSString *str =self.detailDoc.headlineText;
        NSArray *range = [str componentsSeparatedByString:@"／"];
        NSString *subStr = [range objectAtIndex:0];
        NSLog(@"%@",subStr);
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@head_title@" withString:subStr];
        if ([_isfromWhere isEqualToString:TYPE_CLIP]) {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@type@" withString:@"TYPE_CLIP"];
        }else if ([_isfromWhere isEqualToString:TYPE_NOTE]){
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@type@" withString:@"TYPE_NOTE"];

        }

        NSString *clippingImgPath = self.detailDoc.clippingImgPath;
        if (clippingImgPath) {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@ClipImagePath@" withString:clippingImgPath];
        }else{
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@ClipImagePath@" withString:@""];
        }
//        NSString *memo = self.detailDoc.memo;
        if (_memo) {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@ClipMemo@" withString:_memo];
        }else{
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@ClipMemo@" withString:@""];
        }
        if (_tagDetail) {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@TagDetail@" withString:_tagDetail];
        }else{
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@TagDetail@" withString:@""];
        }

        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@publisj_data@" withString:[NSString stringWithFormat:@"%@ %@",[Util getTheFormatString:self.detailDoc.publishDate],self.detailDoc.pageInfoName]];
        
        if (self.imagePath) {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@srcPath@" withString:self.imagePath];
        }else{
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@srcPath@" withString:@""];
        }
        
        if ([_isfromWhere isEqualToString:TYPE_SOKUHO]) {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@linkDisplay@" withString:@"none"];
        } if ([_isfromWhere isEqualToString:TYPE_CLIP] && !clippingImgPath) {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@linkDisplay@" withString:@"none"];
        } else {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@linkDisplay@" withString:@"block"];
            
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@link_data_title@" withString:self.detailDoc.pageInfoName];
            
            NSString *linkDetailLabel = [NSMutableString stringWithFormat:@"%@　%@ページ",self.detailDoc.publicationInfoName, self.detailDoc.pageno];
            CFStringTransform((CFMutableStringRef)linkDetailLabel, NULL, kCFStringTransformFullwidthHalfwidth, true);
            
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@link_data_detail@" withString:linkDetailLabel];
            
            NSString *linkHeadLabel;
            if ([_isfromWhere isEqualToString:TYPE_CLIP]) {
                linkHeadLabel = NSLocalizedString(@"Clip to Page", nil);
            }else if([_isfromWhere isEqualToString:TYPE_SEARCH]){
                linkHeadLabel = NSLocalizedString(@"Note to Page", nil);
            }else{
                linkHeadLabel = NSLocalizedString(@"Note to Page", nil);
            }
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@link_title@" withString:linkHeadLabel];
            
            NSString *lingSrcPath = @"";
            if ([_isfromWhere isEqualToString:TYPE_CLIP]) {
                if (clippingImgPath) {
                    lingSrcPath = clippingImgPath ;
                }
                
            }
            
            if([_isfromWhere isEqualToString:TYPE_SEARCH] || [_isfromWhere isEqualToString:TYPE_NOTE]||[_isfromWhere isEqualToString:TYPE_HOME]){
                if (self.paperDoc && [self.paperDoc.indexNo isEqualToString:self.detailDoc.publishingHistoryInfoContentIdPaperInfo]) {
                    lingSrcPath = self.paperDoc.miniPagePath;
                }
            }
            
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@linkSrcPath@" withString:lingSrcPath];
        }
        if (_photoPathD) {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@imgPaths@" withString:_photoPathD];
            
        }else{
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@imgPaths@" withString:@""];
        }
        htmlString=[htmlString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        htmlString=[htmlString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString *jsString = [NSString stringWithFormat:@"changeHtml(\"%@\");",htmlString];
        [_textView stringByEvaluatingJavaScriptFromString:jsString];
        [self setShowStyle:_isTateShow];
//        [self changeView:_btnType];
        if([_isfromWhere isEqualToString:TYPE_SEARCH] || [_isfromWhere isEqualToString:TYPE_NOTE]||[_isfromWhere isEqualToString:TYPE_HOME]){
            [self searchMiniPagePath];
        }
        
    }else{
       
    }
    
}
/**
 * Layout　更新
 *
 */
- (void)updateLayout
{

    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat titleY=25;
    if (self.navBarHeight<NAVBARHEIGHT) {
        titleY=5;
    }
    self.textView.frame = CGRectMake(TITLE_MARGIN, 0, width - 2*TITLE_MARGIN, height);
    
    CGFloat tvheight = [[_textView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGRect tvframe = self.textView.frame;
    if (tvheight==0) {
        [_textView loadHTMLString:viewFormatHtml.copy baseURL:[NSURL fileURLWithPath:bundleFile]];
    }
    if (tvheight>0) {
        _textView.frame = CGRectMake(tvframe.origin.x, tvframe.origin.y, tvframe.size.width, tvheight);
    }

}



/**
 * textView初期化（記事の内容）
 *
 */
- (UIWebView *)textView
{
    
    if (!_textView) {
        _textView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.userInteractionEnabled=YES;
        _textView.scrollView.scrollEnabled=NO;
        _textView.opaque=NO;
        
    }
    return _textView;
}
#pragma mark --
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"naviapp"]) {
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"imageClick"])
        {
            [self toDisplayDetail];
        }
        
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"linkImageClick"])
        {
            [self noteToPage];
        }
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"editTags"])
        {
            [self editTags];
        }
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"editDescription"])
        {
            [self editDescription];
        }
        return NO;
    }
    [self getTag:_indexNo];
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    isWebViewloadFinished=YES;
    if (self.isNewDetailview) {
        [self loadmyhtml];
    }
    [self updateLayout];
    [self getTag:_indexNo];
    [self getClipAPI:_indexNo];
}
- (void)getTag:(NSString *)indexNo{
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"IndexNo"       :  indexNo,
                            @"UseFlg"       :  @"1",
                            };
    [[NANetworkClient sharedClient] postTagFavoritesSearch:param completionBlock:^(id favorites, NSError *error) {
        SHXMLParser *parser = [[SHXMLParser alloc] init];
        NSDictionary *dic = [parser parseData:favorites];
        NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];

        NSArray *arr = clipBaseClass.response.doc;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (arr.count > 0) {
                NSString *tag;
                for (int i = 0; i < arr.count;i++) {
                    if (i == 0) {
                        NAClipDoc *doc = [arr objectAtIndex:0];
                        tag = doc.tagName;
                    }else{
                        NAClipDoc *doc = [arr objectAtIndex:i];
                        tag = [NSString stringWithFormat:@"%@,%@",tag,doc.tagName];
                    }
                }
                _tagDetail = tag;
                //[self loadmyhtml];
            }
        });
    }];
}
//刷新memo
- (void)getClipAPI:(NSString *)indexNo
{
    NSDictionary *param = @{
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"K001"       :  indexNo,
                            @"K002" :@"4",
                            };
    [[NANetworkClient sharedClient] postFavoritesSearch:param completionBlock:^(id favorites, NSError *error) {
        if (!error) {
            SHXMLParser *parser = [[SHXMLParser alloc] init];
            NSDictionary *dic = [parser parseData:favorites];
            NAClipBaseClass *clipBaseClass = [NAClipBaseClass modelObjectWithDictionary:dic];
            NSArray *array = clipBaseClass.response.doc;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (array.count != 0) {
                    NAClipDoc *doc = [array objectAtIndex:0];
                    _memo = doc.memo;
                    //[self loadmyhtml];
                }
                
            });
        }else{
            ITOAST_BOTTOM(error.localizedDescription);
            //[self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

/**
 * 縦、横書を設定
 *
 */
- (void)setShowStyle:(BOOL)isTateShow{
    CGFloat width = self.textView.frame.size.width;
    CGFloat height = self.frame.size.height;
    NSString *jsString = [NSString stringWithFormat:@"showKijiArea(%d, '%f','%f','%ld');", isTateShow, width, height - 20 - 20, (long)_myfont];
    [_textView stringByEvaluatingJavaScriptFromString:jsString];
    _textView.scrollView.scrollEnabled=NO;
    self.isTateShow = isTateShow;
}
- (void)changeView:(NSString *)type{
    NSString *jsString;
    if ([type isEqualToString:@"text"]) {
        jsString = [NSString stringWithFormat:@"showPicOrText('%@');", type];
    }else{
        jsString = [NSString stringWithFormat:@"showPicOrText('%@');", type];
    }
    
    [_textView stringByEvaluatingJavaScriptFromString:jsString];
    _textView.scrollView.scrollEnabled=NO;
}
/**
 * 画面回転の前処理
 *
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (self.oldToInterfaceOrientation == toInterfaceOrientation) {
        return;
    }
    self.oldToInterfaceOrientation = toInterfaceOrientation;
}

/**
 * 画面回転の後処理
 *
 */
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (self.oldFromInterfaceOrientation == fromInterfaceOrientation) {
        return;
    }
   
    self.oldFromInterfaceOrientation = fromInterfaceOrientation;
    if ([self isLandscape]) {
        [self setShowStyle:YES];
        _isTateShow = YES;
    }else{
        _isTateShow = NO;
        [self setShowStyle:NO];
    }
    
}
- (BOOL)isLandscape
{
    
    return ([Util screenSize].width>[Util screenSize].height);
}

/**
 * 字体を設定
 *
 */
- (void)textFontValue:(CGFloat)fontValue
{
    _myfont=fontValue;

    [self setShowStyle:_isTateShow];
}

- (void)searchMiniPagePath
{
    if (self.paperDoc && [self.paperDoc.indexNo isEqualToString:self.detailDoc.publishingHistoryInfoContentIdPaperInfo]) {
        return;
    }
    
    NSDictionary *param = @{
                            @"K001"       :  self.detailDoc.publishingHistoryInfoContentIdPaperInfo,
                            @"Userid"     :  [NASaveData getLoginUserId],
                            @"UseDevice"  :  NAUserDevice,
                            @"Rows"       :  @"1",
                            @"K002"       :  @"2",
                            @"Mode"       :  @"1",
                            @"Sort"       :  @"K006:asc,K090:asc,K012:asc",
                            @"Fl"         :  [NSString searchCurrentFl]
                            };
    [[NANetworkClient sharedClient] postSearch:param completionBlock:^(id search, NSError *error) {
        
        if (!error) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                SHXMLParser *parser = [[SHXMLParser alloc] init];
                NSDictionary *dic = [parser parseData:search];
                NASearchBaseClass *searchBaseClass = [NASearchBaseClass modelObjectWithDictionary:dic];
                self.paperDoc=searchBaseClass.response.doc[0];
                NSString *jsString = [NSString stringWithFormat:@"loadLinkImg('%@');", self.paperDoc.miniPagePath];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                [_textView stringByEvaluatingJavaScriptFromString:jsString];
                });
                
            });
        }else{
            ITOAST_BOTTOM(NSLocalizedString(@"network timeout", nil));
        }
    }];
}

/**
 * 画像詳細画面を表示
 *
 */
- (void)toDisplayDetail{
    NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
    
    NSString *imagepath = self.detailDoc.miniPhotoPath;
    NSArray *uris=[imagepath componentsSeparatedByString:@","];
    [tmpdic setObject:uris forKey:@"imageUris"];
    [tmpdic setObject:[NSNumber numberWithBool:YES] forKey:@"isdetailimage"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"toImageDetail" object:nil userInfo:tmpdic];
}
- (void)editTags{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"editTags" object:nil userInfo:nil];
}
- (void)editDescription{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"editDescription" object:nil userInfo:nil];

}
/**
 * 関連紙面の遷移
 *
 */
- (void)noteToPage
{
    // 記事リストから
    if ([self.isfromWhere isEqualToString:TYPE_NOTE]||[_isfromWhere isEqualToString:TYPE_HOME]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"toHomePage" object:nil userInfo:nil];
        // clipリストから
    } else if ([self.isfromWhere isEqualToString:TYPE_CLIP]) {
        NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
        
        if (self.detailDoc.clippingImgPath) {
            NSMutableArray *uris = [[NSMutableArray alloc]init];
            [uris addObject:self.detailDoc.clippingImgPath];
            [tmpdic setObject:uris forKey:@"imageUris"];
        
            [[NSNotificationCenter defaultCenter] postNotificationName:@"toImageDetail" object:nil userInfo:tmpdic];
        }
        // 検索結果から
    } else if ([self.isfromWhere isEqualToString:TYPE_SEARCH]) {
        NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
        
        NSMutableArray *uris = [[NSMutableArray alloc]init];
        if (self.paperDoc) {
            [uris addObject:self.paperDoc.pagePath4];
            [tmpdic setObject:uris forKey:@"imageUris"];
            [tmpdic setObject:self.detailDoc forKey:@"noteDoc"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"toImageDetail" object:nil userInfo:tmpdic];
        }
        
    }
}
@end

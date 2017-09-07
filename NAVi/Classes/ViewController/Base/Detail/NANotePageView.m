/*!
 @header NANotePageView.m
 @abstract 記事詳細画面の関連紙面view
 @author eland
 @version 1.00 2015/05/20 Creation
 */

#import "NANotePageView.h"
#import "NAFileManager.h"
#import "FontUtil.h"
@interface NANotePageView () {
    CGFloat width;
    CGFloat height;
}

@end

@implementation NANotePageView

@synthesize isfromWhere;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    width = self.frame.size.width;
    height = self.frame.size.height;
    
    [self addSubview:self.headLabel];
    [self addSubview:self.imageView];
    [self addSubview:self.button];
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, 80, 100)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 25, 80, 100);
        [_button addTarget:self action:@selector(noteToPage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UILabel *)headLabel{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
        _headLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _headLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, width - 100, 30)];
        _detailLabel.font = [FontUtil systemFontOfSize:20];
        _detailLabel.textColor = [UIColor grayColor];
    }
    return _detailLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, width - 100, 60)];
        _titleLabel.font = [FontUtil systemFontOfSize:25];
    }
    return _titleLabel;
}

/**
 * 関連紙面情報を設定
 *
 */
- (void)setViewValue:(NAClipDoc *)doc
{
    self.noteDoc = doc;
    self.titleLabel.text = doc.pageInfoName;
    self.detailLabel.text = [NSString stringWithFormat:@"%@　%@ページ",doc.publicationInfoName, doc.pageno];
    
    if ([isfromWhere isEqualToString:TYPE_CLIP]) {
        self.headLabel.text = NSLocalizedString(@"Clip to Page", nil);
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:doc.clippingImgPath] placeholderImage:[UIImage imageNamed:NANOImage]];
        
    }else if([isfromWhere isEqualToString:TYPE_SEARCH]){
        self.headLabel.text = NSLocalizedString(@"Note to Page", nil);
        
        if ([NACheckNetwork sharedInstance].isHavenetwork){
            [self searchCurrentApi:doc];
        }else{
            self.imageView.image=[UIImage imageNamed:NANOImage];
        }
    }else{
        self.headLabel.text = NSLocalizedString(@"Note to Page", nil);
        
        NSString *path = [[NAFileManager sharedInstance] searchNotePathWithFileName:doc withImageName:NAPageMiniPhoto];
        UIImage *image=[UIImage imageWithContentsOfFile:path];
        if (image) {
            self.imageView.image=image;
        }else{
            self.imageView.image=[UIImage imageNamed:NANOImage];
        }
       
    }
}

- (void)searchCurrentApi:(NAClipDoc *)doc
{
    NSDictionary *param = @{
                            @"K001"       :  doc.publishingHistoryInfoContentIdPaperInfo,
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
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.paperDoc.miniPagePath] placeholderImage:[UIImage imageNamed:NANOImage]];
                
            });
        }
    }];
}

/**
 * 関連紙面の遷移
 *
 */
- (void)noteToPage:(UIButton *)sender
{
    // 記事リストから
    if ([self.isfromWhere isEqualToString:TYPE_NOTE]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"toHomePage" object:nil userInfo:nil];
    // clipリストから
    } else if ([self.isfromWhere isEqualToString:TYPE_CLIP]) {
        NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
        
        NSMutableArray *uris = [[NSMutableArray alloc]init];
        [uris addObject:self.noteDoc.clippingImgPath];
        [tmpdic setObject:uris forKey:@"imageUris"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"toImageDetail" object:nil userInfo:tmpdic];
    // 検索結果から
    } else if ([self.isfromWhere isEqualToString:TYPE_SEARCH]) {
        NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]init];
        
        NSMutableArray *uris = [[NSMutableArray alloc]init];
        if (self.paperDoc) {
            [uris addObject:self.paperDoc.pagePath4];
            [tmpdic setObject:uris forKey:@"imageUris"];
            [tmpdic setObject:self.noteDoc forKey:@"noteDoc"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"toImageDetail" object:nil userInfo:tmpdic];
        }
       
    }
}
@end

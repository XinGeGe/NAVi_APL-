
#import "NAGripTableViewCell.h"
#import "NADefine.h"
#import "FontUtil.h"
@interface NAGripTableViewCell ()

@end

@implementation NAGripTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateViews];
}

#pragma mark - utility -
#pragma mark

- (void)cellClickStatus:(BOOL)aClip
{
    self.clipType = aClip;
}

- (void)initViews
{
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.detailLbl];
    [self.contentView addSubview:self.dateLbl];
}

- (void)updateViews
{
    CGRect titleFrame = CGRectZero;
    CGRect detailFrame = CGRectZero;
    CGRect dateFrame = CGRectZero;
    CGFloat width = self.frame.size.width;
    //CGFloat height = self.frame.size.height;
    CGFloat originX = 10.0f;
    CGFloat originY = -5.0f;
    CGFloat frameHeight = 0.0f;
    CGFloat frameWidth = width - originX * 2;
    //    NALog(@"%f   %f",width,height);
    switch (self.cellType) {
        case NAiPadLandscape:
            //            NALog(@"NAiPadLandscape");
            frameHeight = 27.0f;
            titleFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 53.0f;
            detailFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 25.0f;
            dateFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            break;
        case NAiPadPortrait:
            //            NALog(@"NAiPadPortrait");
            frameHeight = 27.0f;
            titleFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 53.0f;
            detailFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 25.0f;
            dateFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            break;
        case NAiPhoneLandscape:
            //            NALog(@"NAiPhoneLandscape");
            frameHeight = 50.0f;
            titleFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 70.0f;
            detailFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 25.0f;
            dateFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            break;
        case NAiPhonePortrait:
            //            NALog(@"NAiPhonePortrait");
            frameHeight = 50.0f;
            titleFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 70.0f;
            detailFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            originY = originY + frameHeight;
            frameHeight = 25.0f;
            dateFrame = CGRectMake(originX, originY, frameWidth, frameHeight);
            break;
        default:
            break;
    }
    self.titleLbl.frame = titleFrame;
    self.dateLbl.frame = dateFrame;
    self.detailLbl.frame = detailFrame;
    
}

#pragma mark - layout -
#pragma mark

- (UITextView *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UITextView alloc] initWithFrame:CGRectZero];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.font = [FontUtil boldSystemFontOfSize:18];
        [_titleLbl setEditable:NO];
        _titleLbl.userInteractionEnabled=NO;
    }
    return _titleLbl;
}

- (UIWebView *)detailLbl
{
    if (!_detailLbl) {
        _detailLbl = [[UIWebView alloc] initWithFrame:CGRectZero];
        _detailLbl.backgroundColor = [UIColor clearColor];
        _detailLbl.userInteractionEnabled=NO;
        _detailLbl.delegate=self;
        _detailLbl.opaque=NO;
        
        
    }
    return _detailLbl;
}

- (UITextView *)dateLbl
{
    if (!_dateLbl) {
        _dateLbl = [[UITextView alloc] initWithFrame:CGRectZero];
        _dateLbl.backgroundColor = [UIColor clearColor];
        _dateLbl.textColor = [UIColor blueColor];
        _dateLbl.font =[FontUtil systemFontOfSize:14];
        [_dateLbl setEditable:NO];
        _dateLbl.userInteractionEnabled=NO;
    }
    return _dateLbl;
}
- (void)searchMatchInDirection:(NSString *)mysearchstr{
    NSString *searchString = mysearchstr;
    if (searchString.length){
        //[CharUtil setHighlightwithTextview:_detailLbl keyword:searchString];
        [CharUtil setHighlightwithTextview:_titleLbl keyword:searchString];
        NSString *bundleFile = [[NSBundle mainBundle] pathForResource:@"htmlsource" ofType:@"bundle"];
        NSString *filePath = [NSString stringWithFormat:@"%@/listNote.html",bundleFile];
        NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"@myContent@" withString:[CharUtil ChangetheDetailtext:_detailtext keyword:searchString]];
        
        
        [_detailLbl loadHTMLString:htmlString baseURL:nil];
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *jsString;
    jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%d;",14];
    [_detailLbl stringByEvaluatingJavaScriptFromString:jsString];

}
@end
